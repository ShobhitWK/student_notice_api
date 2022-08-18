class Role < ApplicationRecord

  validates :name, presence: true,
            uniqueness: {case_sensitive: false},
            length: {minimum: 3, maxmimum: 20}

  has_many :users
  
end
