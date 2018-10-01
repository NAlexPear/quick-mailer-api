class GenericMailer < ApplicationMailer
  before_action :generate_message_values

  class NoRecipient < ArgumentError
  end

  def email
    mail(to: @email, subject: @subject)
  end

  private

  def generate_message_values
    @name = params[:name] || 'Wonderful User'
    @subject = params[:subject] || 'Welcome!'
    @email = params[:email]

    raise NoRecipient unless @email.present?
  end
end
