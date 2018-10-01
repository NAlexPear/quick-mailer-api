require 'rails_helper'


RSpec.describe GenericMailer, :type => :mailer do
  before do
    @params = {
      :name => 'foo', 
      :email => 'bar@baz.com',
      :subject => 'luhrman'
    }
  end

  context '#email' do
    it 'generates an email' do
      email = GenericMailer.with(@params).email

      expect(email.to).to eq([@params[:email]])
      expect(email.subject).to eq(@params[:subject])
    end
  end
end
