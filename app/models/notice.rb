class Notice < ApplicationRecord
  belongs_to :user

  validates :title, presence: true,
            length: {minimum: 5, maxmimum: 105}

  validates :description, presence: true,
            length: {minimum: 5, maxmimum: 400}

end
