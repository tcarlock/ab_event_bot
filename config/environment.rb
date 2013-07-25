# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
EventBot::Application.initialize!

TAG_SCORE_THRESHOLD = 15