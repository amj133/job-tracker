class Contact < ApplicationRecord
  belongs_to :company

  validates :full_name, presence: true, uniqueness: true
  validates :position, presence: true
  validates :email, presence: true, uniqueness: true
  validates :company, presence: true
end
