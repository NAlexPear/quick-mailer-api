class WelcomeMailer < ApplicationMailer
  before_action :generate_message_values

  class NoRecipient < ArgumentError
  end

  def welcome
    mail(to: @email, subject: 'Welcome!')
  end

  private

  def generate_message_values
    user = params[:user]
    
    raise ArgumentError, 'User param required' unless user.present?

    @name = user.name || 'Wonderful User'
    @email = user.email

    raise NoRecipient unless @email.present?
  end
end
