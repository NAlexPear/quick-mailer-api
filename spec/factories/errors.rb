FactoryBot.define do
  factory :error do
    failure_type { [:smtp, :network].sample }

    before :create do |error|
      create(:message, error: error)
    end
  end
end
