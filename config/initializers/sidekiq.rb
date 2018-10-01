Sidekiq.configure_server do |config|
  config.redis = { url: ENV['JOB_WORKER_URL'] }
  config.error_handlers << Proc.new do |error, context|
    gid = context[:job]['args'][0]['arguments'].last['_aj_globalid'].split('/').last

    message = Message.find(gid)

    unless message.nil?
      error = Error.create!(message_id: message.id,
                            failure_type: :network)

      message.update(error_id: error.id)
    end
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['JOB_WORKER_URL'] }
end
