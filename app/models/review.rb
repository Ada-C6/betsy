class Review < ActiveRecord::Base
  belongs_to :user_id
  # validates :rank, presence: true, only_integer: true, :inclusion => 1..5, message: "only allows integers 1-5"
end
