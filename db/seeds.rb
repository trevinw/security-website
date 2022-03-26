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

building_numbers = [
  10,
  15,
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
]

building_numbers.each { |building_number| Building.create(number: building_number) }

company_names = [
  'EC Company',
  'JH Kelly',
  'SEH',
  'Stoner'
]

company_names.each { |company_name| Company.create(name: company_name) }

20.times do |index|
  WorkPermit.create!(
    number: index + 1,
    status: ['Returned', 'Out', 'Out/Disabled', 'Missing', 'Expired'].sample,
    work_location: Faker::Lorem.sentence(word_count: 10),
    work_description: Faker::Lorem.sentence(word_count: 20),
    notes: Faker::Lorem.sentence(word_count: 5),
    start_date: Date.today + [-2, -1, 0, 1, 2].sample,
    end_date: Date.today + [3, 4, 5, 6, 7].sample,
    category: %w[Regular Hazardous].sample,
    needs_bypass: rand > 0.5,
    seh_representative: "#{Faker::Name.first_name} #{Faker::Name.last_name}",
    alternative_contact: "#{Faker::Name.first_name} #{Faker::Name.last_name}",
    company: Company.all.sample,
    buildings: [Building.all.sample],
    hazards: [Hazard.all.sample]
  )
end
