# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
DolChallenge::Application.initialize!

# Import GovDataSDK
require_relative 'DOLDataSDK'

# Gov Data Permssions
API_HOST = 'http://api.dol.gov'
API_KEY = 'c789a707-76b6-470e-8e94-a9bfb9d9a7d6'
API_SECRET = 'bosses_office'
API_DATA = 'Safety/Fatalities/OSHA_Fatalities'
API_URI = 'V1'
