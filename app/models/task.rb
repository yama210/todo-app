class Task < ApplicationRecord
  validates :text, presence: true
end
