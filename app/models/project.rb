class Project < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :user_id }

  has_many :notes

end
