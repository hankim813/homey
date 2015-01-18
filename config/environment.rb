# Load the Rails application.
require File.expand_path('../application', __FILE__)

require 'bcrypt' # password hasing
require 'token' # AuthToken class
require 'error' # Auth Errors

# Initialize the Rails application.
Rails.application.initialize!
