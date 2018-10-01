class Message < ApplicationRecord
  has_one :error, dependent: :destroy

  validates_presence_of :email
end
