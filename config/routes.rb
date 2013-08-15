DolChallenge::Application.routes.draw do
  mount JasmineRails::Engine => "/specs" if defined?(JasmineRails)
end
