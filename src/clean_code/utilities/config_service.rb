#Simple string returns for now, could be fed from a config file later
class ConfigService
    def redis_url
        'my_redis_host_url'
    end

    def liquidity_provider_base_url
        "http://lp_c_host"
    end

    def log_path
        "path_to_log_file"
    end

    def error_log_file
        "errors.log"
    end
end