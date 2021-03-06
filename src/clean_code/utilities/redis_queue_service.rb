require "redis"

class RedisQueueService
  def initialize(configService)
    @connection = Redis.new(url: configService.redis_url)
  end

  def push_to_queue(queue, command, payload = nil)
    redis_msg = payload == nil ? command : "#{command}::#{JSON.dump(payload)}" 
    @connection.rpush queue, redis_msg
  end
end