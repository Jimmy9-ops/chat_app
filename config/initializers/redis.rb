# Initialize a Redis client
REDIS_CONFIG = {
  host: 'redis', # This should match the service name defined in docker-compose.yml
  port: 6379,    # Default Redis port
  db: 0          # Default Redis database
}

$redis = Redis.new(REDIS_CONFIG)
