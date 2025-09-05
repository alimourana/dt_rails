# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    # Example of using Redis for caching
    @redis_status = RedisService.ping
    @page_views = increment_page_views
    @cached_time = get_cached_time
  end

  private

  def increment_page_views
    RedisService.cache('page_views', expire_in: 1.hour) do
      current_views = RedisService.get('page_views').to_i
      new_views = current_views + 1
      RedisService.set('page_views', new_views.to_s)
      new_views
    end
  end

  def get_cached_time
    RedisService.cache('current_time', expire_in: 30.seconds) do
      Time.current.to_s
    end
  end
end
