uri = URI.parse(ENV["REDIS_PROVIDER"])
REDIS = Redis.new(:url => ENV['REDIS_PROVIDER'])
