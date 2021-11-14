class LogService
    def initialize(configService)
        @configService = configService
    end

    def log_error(message)
        path = "#{configService.log_path}/#{configService.error_log_file}"

        File.open(path, 'a') do |f|
            f.puts message
        end
    end
end