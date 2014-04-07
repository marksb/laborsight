require 'rubygems'
require 'net/http'
require 'uri'
require 'thread'
require 'hmac-sha1'
require 'json'
require 'open-uri'
require 'net/https'
require 'openssl'
require 'always_verify_ssl_certificates'
require 'cgi'

module GOV
  API_VALID_ARGUMENTS = %w[top skip select orderby filter]
    class DataContext
      attr_accessor :host, :key, :secret, :data, :uri

      def initialize host, key, secret, data,  uri
        @host, @key, @secret, @data, @uri = host, key, secret, data, uri
      end
    end

    # This class handles requesting data using the API.
    # All DataRequest objects must be initialized with a DataContext
    # that provides the DatRequest with a host, API key and SharedSecret.
    # After generating a request, call #call_api to submit it.
    class DataRequest
      attr_accessor :context

      def initialize context
        @context = context
        @mutex = Mutex.new
        @active_requests = []
      end

      # This method consturcts and submits the data request.
      # It calls the passed block when it completes, returning both a result and an error.
      # If error is not nil, there was an error during processing.
      # The request is submittreed in another thread, so call #wait_until_finished to ensure
      # that all requests have processed after submitting a request.
      # You can make multiple requests with #call_api from a single DataRequest object,
      # and #wait_until_finished wll correctly wait for all of them.

      def call_api method, arguments = {}, &block
        unless @context.is_a? DataContext
          block.call nil, 'A context object was not provided.'
          return
        end

        query = []
        arguments.each_pair do |key, value|
          if API_VALID_ARGUMENTS.member? key.to_s
            query << "$#{key}=#{URI.escape value.to_s}"
          else
            if context.host == "http://go.usa.gov"
              ### See comment in go.usa.gov section below
              query << "#{key}=#{CGI::escape(value.to_s)}"
            else
              query << "#{key}=#{URI.escape value.to_s}"
            end
          end
        end

        timestamp = GOV.timestamp
        sdkUseSSL = FALSE

        # Creates a new thread, creates an authenticaed request, and requests data from the host
        @mutex.synchronize do
          @active_requests << Thread.new do
            if context.host == "http://api.dol.gov"
              url = URI.parse ["#{@context.host}/#{@context.uri}/#{method}", query.join('&')].join '?'
            elsif context.host == "http://go.usa.gov"
              sdkUseSSL = FALSE
              login = query.at(0)
              longURL = query.at(1)
              url = URI.parse ["#{@context.host}/#{@context.uri}/#{method}?#{login}&apiKey=#{@context.key}&#{longURL}"].join '&'
            elsif context.host == "http://www.ncdc.noaa.gov"
              url = URI.parse ["#{@context.host}/#{@context.uri}/#{method}?token=#{@context.key}", query.join('&')].join '&'
            elsif ((context.host == "http://api.eia.gov") || (context.host == "http://developer.nrel.gov") || (context.host == "http://api.stlouisfed.org") || (context.host == "http://healthfinder.gov"))
              url = URI.parse ["#{@context.host}/#{@context.uri}/#{method}?api_key=#{@context.key}", query.join('&')].join '&'
            elsif ((context.host == "http://api.census.gov") || (context.host == "http://pillbox.nlm.nih.gov"))
              url = URI.parse ["#{@context.host}/#{@context.uri}/#{method}?key=#{@context.key}", query.join('&')].join '&'
            else
              url = URI.parse ["#{@context.host}/#{@context.uri}/#{method}", query.join('&')].join '?'
            end

          request = Net::HTTP::Get.new [url.path, url.query].join '?'

          if context.host == "http://api.dol.gov"
            request.add_field 'Authorization', "Timestamp=#{timestamp}&ApiKey=#{@context.key}&Signature=#{signature timestamp, url}"
          end

          request.add_field 'Accept', 'application/json'

          result = Net::HTTP.start url.host, url.port do |http|
          http.request request
        end

        if result.is_a? Net::HTTPSuccess
          rawresult = result.body
          result = result.body.gsub(/\\+"/, '"')
          result = result.gsub(/\\+n/, "")
          result = result.gsub(/\"\"\{/, "{")
          result = result.gsub(/\"\"/, "}")

          begin
            result = JSON.parse(result)['d']
          rescue
            print "parse attempt failed"
          end

          # If the JSON is not parsed successfully, we need to avoid an error regarding result.include?.
          # In this case, we return the raw API output.  Either the parser above needs work or
          # the JSON results need love.
          # This may be an area that needs future improvements

          if !result.nil?
            if (result.include?'results')
              result = result['results'] if result.is_a? Hash
            end
            block.call result, nil
          else
            block.call rawresult, nil
          end
        else
          block.call nil, "Error Will Robinson: #{result.message}"
        end

        @mutex.synchronize do
          @active_requests.delete Thread.current
        end
      end
    end
  end

  # Halts program until all ongoing requests sent by this DataRequest finish
  def wait_until_finished
    @active_requests.dup.each do |n|
      n.join
    end
  end

  private
  # Generates a signature using your SharedSecret and the request path
  def signature timestamp, url
    HMAC::SHA1.hexdigest @context.secret, [url.path, url.query + "&Timestamp=#{timestamp}&ApiKey=#{@context.key}"].join('?')
  end
end

  module_function
  def timestamp
    Time.now.utc.strftime "%Y-%m-%dT%H:%M:%SZ"
  end
end

class String
  # converts date strings provided by the API (of the format /Date(milliseconds-since-Epoch)/) into Ruby Time objects
  def to_api_date
    if match(/\A\/Date\((\d+)\)\/\Z/)
      Time.at $1.to_i / 1000
    else
      raise TypeError, "Not a valid date format"
    end
  end
end