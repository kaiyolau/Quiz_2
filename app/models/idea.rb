class Idea < ApplicationRecord

  has_many :reviews, dependent: :nullify
  belongs_to :user

  before_save :capitalize_title

  validates :title, presence: {message: 'must be provided'}

  validates :description, length: {minimum: 2, maximum: 100}

  validates :title, uniqueness: {scope: :description}

  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user



	private

	def capitalize_title
		self.title.capitalize!
  end



end
