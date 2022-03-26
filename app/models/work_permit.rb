class WorkPermit < ApplicationRecord
  belongs_to :company
  has_and_belongs_to_many :buildings
  has_and_belongs_to_many :hazards

  validates :number, numericality: { greater_than: 0 }

  after_create_commit { broadcast_append_later_to('work_permits') }
  after_update_commit { broadcast_update_later_to('work_permits') }

  def expired?
    end_date < Date.today
  end

  def formatted_start_date
    start_date.strftime('%m/%d/%y')
  end

  def formatted_end_date
    end_date.strftime('%m/%d/%y')
  end

  def hazard_names
    hazards.map(&:name).sort
  end

  def needs_bypass?
    needs_bypass
  end
end
