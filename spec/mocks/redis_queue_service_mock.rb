class RedisQueueServiceMock
    @queue
    @redis_msg

    def queue
        @queue
    end

    def redis_msg
        @redis_msg
    end
    
    def push_to_queue(queue, command, payload = nil)
        redis_msg = payload == nil ? command : "#{command}::#{JSON.dump(payload)}" 
        
        @queue = queue
        @redis_msg = redis_msg
    end
end