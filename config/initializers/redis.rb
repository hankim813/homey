uri = URI.parse(ENV["REDISTOGO_URL"])
$redis = Redis.new(:url => ENV['REDISTOGO_URL'])