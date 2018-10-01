require 'rails_helper'


RSpec.describe 'Messages API', type: :request do
  let!(:messages) { create_list(:message, 10) }
  let(:message_id) { messages.first.id }

  context 'GET /messages' do
    before { get '/messages' }

    it 'returns all messages' do
      result = JSON.parse(response.body)

      expect(result).not_to be_empty
      expect(result.size).to eq(10)
    end
  end

  context 'GET /messages/:id' do
    before { get "/messages/#{message_id}"}

    it 'returns single message by ID' do
      result = JSON.parse(response.body)

      expect(result).not_to be_empty
      expect(result['id']).to eq(message_id)
    end
  end

  context 'POST /messages' do
    let(:message_params) {{ name: 'foo', email: 'bar@baz.com', subject: 'Luhrman' }}

    before { post '/messages', params: message_params }

    it 'creates a new message' do
      result = JSON.parse(response.body)
      name, email, subject = message_params.values_at(:name, :email, :subject)

      expect(result['name']).to eq(name)
      expect(result['email']).to eq(email)
      expect(result['subject']).to eq(subject)
    end
  end
end
