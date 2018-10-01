class Message < ApplicationRecord
  has_one :error, dependent: :destroy

  validates_presence_of :email
  accepts_nested_attributes_for :error
end
