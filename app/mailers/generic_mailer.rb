class GenericMailer < ApplicationMailer
  before_action :generate_message_values

  class NoRecipient < ArgumentError
  end

  def email
    mail(to: @email, subject: @subject)
  end

  private

  def generate_message_values
    @name, @email, @subject = params.values_at(:name, :email, :subject)
    @name ||= 'Wonderful User'
    @subject ||= 'Welcome!'

    raise NoRecipient unless @email.present?
  end
end
