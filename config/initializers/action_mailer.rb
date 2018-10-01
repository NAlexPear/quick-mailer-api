ActionMailer::DeliveryJob.rescue_from(StandardError) do |error|
  # @TODO: add more granular error handling
  # e.g. SMTP vs Network vs configuration errors

  message = arguments.last

  if message.kind_of?(Message)
    error = Error.create!(message_id: message.id,
                          failure_type: :network)

    message.update(error_id: error.id)
  end
end
