class Comment < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :body, presence: true
  belongs_to :job
end
