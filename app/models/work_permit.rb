class WorkPermit < ApplicationRecord
  belongs_to :company
  belongs_to :user
  has_and_belongs_to_many :buildings
  has_and_belongs_to_many :hazards

  validates :alternative_contact, presence: true
  validates :bypass_building, inclusion: { in: [true, false] }
  validates :bypass_ozone, inclusion: { in: [true, false] }
  validates :category, presence: true
  validates :cover_uv_sensor, inclusion: { in: [true, false] }
  validates :number, numericality: { greater_than: 0, only_integer: true }
  validates :seh_representative, presence: true
  validates :status, presence: true
  validates :work_location, presence: true
  validates :work_description, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  after_create_commit { broadcast_append_later_to('work_permits') }
  after_update_commit { broadcast_update_later_to('work_permits') }

  STATUSES = [
    'Returned',
    'Out',
    'Out - Building Disabled',
    'Out - Ozone Disabled',
    'Out - Building & Ozone Disabled',
    'Missing',
    'Expired',
    'Out for Extension'
  ].freeze

  def expired?
    end_date < Date.today
  end

  def formatted_start_date
    start_date.in_time_zone('Pacific Time (US & Canada)').strftime('%m/%d/%y')
  end

  def formatted_end_date
    end_date.in_time_zone('Pacific Time (US & Canada)').strftime('%m/%d/%y')
  end

  def hazard_names
    hazards.map(&:name).sort
  end

  def bypass_building?
    bypass_building
  end

  def bypass_ozone?
    bypass_ozone
  end

  def cover_uv_sensor?
    cover_uv_sensor
  end

  def self.statuses
    STATUSES
  end
end
