require 'rails_helper'

RSpec.describe 'Errors API', type: :request do
  let!(:errors) { create_list(:error, 10) }

  context 'GET /errors' do
    before { get '/errors' }

    it 'returns all errors' do
      result = JSON.parse(response.body)

      expect(result).not_to be_empty
      expect(result.size).to eq(10)
    end
  end

  context 'GET /errors?type={type}' do
    before { get '/errors?type=smtp' }

    it 'returns all errors filtered by failure type' do
      smtp_errors = errors.select do |error|
        error.failure_type == 'smtp'
      end

      result = JSON.parse(response.body)

      expect(result).not_to be_empty
      expect(result.size).to eq(smtp_errors.size)
    end
  end
end
