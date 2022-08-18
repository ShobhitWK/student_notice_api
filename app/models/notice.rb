class Notice < ApplicationRecord

  # Association
  belongs_to :user

  # validations for notice creation
  validates :title, presence: true,
            length: {minimum: 5, maxmimum: 105}

  validates :description, presence: true,
            length: {minimum: 5, maxmimum: 400},
            uniqueness: {case_sensitive: false}

end
