require 'rails_helper'

class MockUser
  attr_accessor :name, :email

  def initialize(name, email)
    @name = name
    @email = email
  end
end

RSpec.describe WelcomeMailer, :type => :mailer do
  before do
    @user = MockUser.new('foo', 'bar@baz.com')
  end

  # context '#generate_message_values' do
  #   it 'raises an ArgumentError if no user given' do
  #     expect{  WelcomeMailer.with(user: nil).welcome }.to raise_error(ArgumentError)
  #   end

  #   it 'raises a NoRecipientError if no user email provided' do
  #     expect{  WelcomeMailer.with(user: { email: nil }).welcome }.to raise_error(WelcomeMailer::NoRecipient)
  #   end
  # end

  context '#welcome' do
    it 'sends a welcome email to a provided user' do
      welcome_email = WelcomeMailer.with(user: @user).welcome

      expect(welcome_email.to).to eq([@user.email])
    end
  end
end
