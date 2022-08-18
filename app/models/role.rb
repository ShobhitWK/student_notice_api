class Role < ApplicationRecord

  # Associations
  has_many :users

  # validations for role creation
  validates :name, presence: true,
            uniqueness: {case_sensitive: false},
            length: {minimum: 3, maxmimum: 20}

end
