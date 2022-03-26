class Company < ApplicationRecord
  has_many :work_permits

  validates :name, uniqueness: { case_sensitive: false }
end
