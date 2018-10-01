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

    it 'can deliver an email later' do
      delivery = instance_double(ActionMailer::MessageDelivery)

      expect(GenericMailer).to receive(:email).with(@params).and_return(delivery)
      expect(delivery).to receive(:deliver_later)

      GenericMailer.with(@params).email.deliver_later
    end

    it 'enqueues an email through Sidekiq' do
      expect {
        GenericMailer.with(@params).email.deliver_later
      }.to change(Sidekiq::Worker.jobs, :size).by(1)
    end
  end
end
