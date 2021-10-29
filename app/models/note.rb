class Note < ApplicationRecord
  scope :search, ->(term){
    where("LOWER(message) LIKE ?", "%#{term.downcase}%")
  }
end
