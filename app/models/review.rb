class Review < ApplicationRecord

  belongs_to :idea
  belongs_to :user

  validates :body, length: {minimum: 3, maximum:200}

end
