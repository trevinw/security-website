require 'faker'

Hazard.destroy_all
Building.destroy_all
WorkPermit.destroy_all
Company.destroy_all

hazard_names = [
  'Breaking of Lines or Ducting',
  'Breaking/Cutting/Opening of Lines or Equipment',
  'Confined Space Entry',
  'Demolition',
  'Elevated Work',
  'Energized Electrical Work',
  'Excavating/Trenching',
  'General Hot Work',
  'Hazardous Chemical/Gas',
  'Lifting by Crane or Hoist',
  'MCZ',
  'Odor Generating Activity',
  'Off Line Fire/Life/Safety System',
  'Other (See Notes)',
  'PSM/RMP Work',
  'Supplied Air Respirator',
  'X-Ray Radiation or Laser Beam Work'
]

hazard_names.each do |hazard_name|
  Hazard.create(name: hazard_name)
end

BUILDING_NUMBERS = [
  10,
  15,
  16,
  17,
  30,
  31,
  33,
  40,
  41,
  42,
  44,
  45,
  48,
  49,
  50,
  51,
  55,
  60,
  61,
  62,
  63,
  64,
  65,
  66
].freeze

BUILDING_NUMBERS.each { |building_number| Building.create(number: building_number) }

COMPANY_NAMES = [
  'ATG',
  'EC Company',
  'EC Company (EEW)',
  'JH Kelly',
  'SEH',
  'Stoner'
].freeze

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

COMPANY_NAMES.each { |company_name| Company.create(name: company_name) }

20.times do |index|
  WorkPermit.create!(
    alternative_contact: "#{Faker::Name.first_name} #{Faker::Name.last_name}",
    bypass_building: rand > 0.5,
    bypass_ozone: rand > 0.5,
    category: %w[Regular Hazardous].sample,
    cover_uv_sensor: rand > 0.5,
    number: index + 1,
    seh_representative: "#{Faker::Name.first_name} #{Faker::Name.last_name}",
    status: STATUSES.sample,
    work_location: Faker::Lorem.sentence(word_count: 5),
    work_description: Faker::Lorem.sentence(word_count: 20),
    notes: Faker::Lorem.sentence(word_count: 5),
    start_date: Date.today + [-2, -1, 0, 1, 2].sample,
    end_date: Date.today + [3, 4, 5, 6, 7].sample,
    company: Company.all.sample,
    buildings: [Building.all.sample],
    hazards: [Hazard.all.sample]
  )
end
