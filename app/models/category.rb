class Category < ApplicationRecord
  validates :title, uniqueness: true
end
