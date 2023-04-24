require 'csv'

desc 'Import deliveries from CSV into DB'
task import_deliveries: :environment do
  table = CSV.parse(File.read('2018_deliveries.csv'), headers: true)

  table.each.with_index do |row, index|
    date = row['date'].split('/').map(&:to_i)
    year = "20#{date[2]}".to_i
    month = date[0]
    day = date[1]

    if row['time'].include?(':')
      hours = row['time'].split(':')[0].to_i
      minutes = row['time'].split(':')[1].to_i
    else
      time_string = row['time'].to_i.to_s

      if time_string.length == 3
        hours = time_string[0].to_i
        minutes = time_string[1..].to_i
      elsif time_string.length == 4
        hours = row['time'].to_i.to_s[0..1].to_i
        minutes = row['time'].to_i.to_s[2..].to_i
      end
    end

    datetime = DateTime.new(year, month, day, hours, minutes)
    company = row['company']
    category = if row['category'].nil?
                 'Delivery'
               elsif row['category'].downcase.include?('pick')
                 'Pick-Up'
               else
                 'Delivery'
               end
    destination = if row['destination'].nil?
                    'N/A'
                  elsif row['destination'].downcase.include?('other')
                    row['notes']
                  else
                    row['destination']
                  end
    chemical_delivery = !['No', 'no', nil].include?(row['chemical_delivery'])
    chemical_type = if row['chemical_type'].nil?
                      nil
                    elsif row['chemical_type'].downcase.include?('other')
                      row['notes']
                    else
                      row['chemical_type']
                    end
    seh_contact = if row['seh_contact'].nil?
                    'N/A'
                  elsif row['seh_contact'].downcase.include?('other')
                    row['notes']
                  else
                    row['seh_contact']
                  end
    notes = if row['notes'].nil?
              ''
            else
              row['notes']
            end
    username = row['username'].downcase
    user = User.find_by(username:)

    user = User.create(username:) if user.nil?

    delivery = Delivery.create(datetime:, company:, category:, destination:, chemical_delivery:, chemical_type:,
                               seh_contact:, notes:, user_id: user.id)

    puts "#{index + 2}: #{delivery.inspect}"
  end
end
