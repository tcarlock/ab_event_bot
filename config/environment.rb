# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
EventBot::Application.initialize!

TAG_SCORE_THRESHOLD = 15

EMBEDLY_KEYS = %w[
  a93b3ce30d4a4625a92d4881f39d9aff
  b3e2b1e88932405e95ec86306f32ea1b
]