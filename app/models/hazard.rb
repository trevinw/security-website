class Hazard < ApplicationRecord
  has_and_belongs_to_many :work_permits
end
