# frozen_string_literal: true

# Redis service for caching and data storage
class RedisService
  class << self
    def get(key)
      $redis.get(key)
    end

    def set(key, value, expire_in: nil)
      if expire_in
        $redis.setex(key, expire_in, value)
      else
        $redis.set(key, value)
      end
    end

    def delete(key)
      $redis.del(key)
    end

    def exists?(key)
      $redis.exists?(key)
    end

    def keys(pattern = "*")
      $redis.keys(pattern)
    end

    def flushdb
      $redis.flushdb
    end

    def ping
      $redis.ping
    end

    def info
      $redis.info
    end

    # Cache helper methods
    def cache(key, expire_in: 1.hour, &block)
      cached_value = get(key)
      return cached_value if cached_value

      value = block.call
      set(key, value, expire_in: expire_in)
      value
    end

    def cache_json(key, value, expire_in: 1.hour)
      set(key, value.to_json, expire_in: expire_in)
    end

    def get_json(key)
      value = get(key)
      return nil unless value

      JSON.parse(value)
    rescue JSON::ParserError
      nil
    end
  end
end
