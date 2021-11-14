require "redis"

class RedisQueueService
  def initialize
    @connection = Redis.new(url: 'my_redis_host_url')
  end

  def push_to_queue(queue, command, payload = nil)
    redis_msg = payload == nil ? command : "#{command}::#{JSON.dump(payload)}" 
    @connection.rpush queue, redis_msg
  end
end