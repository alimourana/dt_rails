# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RedisService do
  before do
    # Clear Redis database before each test
    RedisService.flushdb
  end

  describe '.get and .set' do
    it 'can store and retrieve a simple string value' do
      RedisService.set('test_key', 'test_value')
      expect(RedisService.get('test_key')).to eq('test_value')
    end

    it 'returns nil for non-existent keys' do
      expect(RedisService.get('non_existent_key')).to be_nil
    end
  end

  describe '.delete' do
    it 'can delete a key' do
      RedisService.set('test_key', 'test_value')
      expect(RedisService.get('test_key')).to eq('test_value')
      
      RedisService.delete('test_key')
      expect(RedisService.get('test_key')).to be_nil
    end
  end

  describe '.exists?' do
    it 'returns true for existing keys' do
      RedisService.set('test_key', 'test_value')
      expect(RedisService.exists?('test_key')).to be true
    end

    it 'returns false for non-existent keys' do
      expect(RedisService.exists?('non_existent_key')).to be false
    end
  end

  describe '.set with expiration' do
    it 'sets a key with expiration' do
      RedisService.set('test_key', 'test_value', expire_in: 1)
      expect(RedisService.get('test_key')).to eq('test_value')
      
      # Wait for expiration
      sleep(2)
      expect(RedisService.get('test_key')).to be_nil
    end
  end

  describe '.cache' do
    it 'caches the result of a block' do
      counter = 0
      result = RedisService.cache('cached_key') do
        counter += 1
        'cached_result'
      end
      
      expect(result).to eq('cached_result')
      expect(counter).to eq(1)
      
      # Second call should use cached value
      result2 = RedisService.cache('cached_key') do
        counter += 1
        'cached_result'
      end
      
      expect(result2).to eq('cached_result')
      expect(counter).to eq(1) # Counter should not increment
    end
  end

  describe '.cache_json and .get_json' do
    it 'can cache and retrieve JSON data' do
      test_data = { 'name' => 'John', 'age' => 30, 'active' => true }
      
      RedisService.cache_json('json_key', test_data)
      retrieved_data = RedisService.get_json('json_key')
      
      expect(retrieved_data).to eq(test_data)
    end

    it 'returns nil for invalid JSON' do
      RedisService.set('invalid_json_key', 'invalid json')
      expect(RedisService.get_json('invalid_json_key')).to be_nil
    end
  end

  describe '.ping' do
    it 'can ping Redis server' do
      expect(RedisService.ping).to eq('PONG')
    end
  end

  describe '.info' do
    it 'returns Redis server information' do
      info = RedisService.info
      expect(info).to be_a(Hash)
      expect(info['redis_version']).to be_present
    end
  end
end
