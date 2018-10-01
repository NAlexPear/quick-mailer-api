class Error < ApplicationRecord
  belongs_to :message

  validates_presence_of :type
end
