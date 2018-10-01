class Error < ApplicationRecord
  belongs_to :message

  enum failure_type: [:smtp, :network]
end
