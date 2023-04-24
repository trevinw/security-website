class Delivery < ApplicationRecord
  belongs_to :user

  before_validation :set_datetime, only: :create
  before_validation :set_chemical_type, only: %i[create update]

  CHEMICAL_TYPES = [
    'N/A',
    'Other',
    'Bulk Ammonia',
    'Bulk Argon',
    'Bulk HCL',
    'Bulk Lime',
    'Bulk NaOH (Caustic)',
    'Bulk Nitric Acid',
    'Bulk Nitrogen',
    'Bulk Nox',
    'Bulk Peroxide',
    'Bulk Sulfuric Acid',
    'Cyl - Argon',
    'Cyl - CO',
    'Cyl - CO2',
    'Cyl - Dioborne',
    'Cyl - Helium',
    'Cyl - Hydrogen',
    'Cyl - N2',
    'Cyl - Oxygen',
    'Cyl - Phosphine',
    'Cyl - Silane',
    'Dewars - CO2',
    'Dewars - N2',
    'High Purity Helium'
  ].freeze

  DESTINATIONS = [
    'Other',
    'Shipping',
    'Receiving',
    'EC Trailer',
    'JH Kelly',
    'Loop',
    'EPI Parking'
  ] + Building.all.order(number: :asc).map do |b|
        "B#{b.number}"
      end.freeze

  SEH_CONTACTS = [
    'N/A',
    'Other',
    'Unit 2',
    'Unit 3',
    'Unit 6',
    'Unit 10',
    'Unit 18',
    'Unit 20',
    'Shipping',
    'Receiving'
  ].freeze

  def date
    datetime.in_time_zone('Pacific Time (US & Canada)').strftime('%m/%d/%y')
  end

  def time
    datetime.in_time_zone('Pacific Time (US & Canada)').strftime('%H:%M')
  end

  def self.chemical_types
    CHEMICAL_TYPES
  end

  def self.destinations
    DESTINATIONS
  end

  def self.seh_contacts
    SEH_CONTACTS
  end

  private

  def set_datetime
    self.datetime = DateTime.now if datetime.nil?
  end

  def set_chemical_type
    self.chemical_type = 'N/A' if chemical_type.nil?
  end
end
