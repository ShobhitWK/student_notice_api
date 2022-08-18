class Notice < ApplicationRecord
  belongs_to :user
  validates :title, :description, presence: true

end
