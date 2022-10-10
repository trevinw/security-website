desc 'Mark old users Active status as False if they are expired in S2'
task mark_users_inactive: :environment do
  s2_session_id = S2Netbox::Commands::Authentication.login.session_id

  User.all.each do |user|
    person = S2Netbox::ApiRequest.send_request(
      'SearchPersonData',
      { PERSONID: user.badge.to_s },
      s2_session_id
    ).details['PEOPLE']['PERSON']

    next if person['EXPDATE'].nil?

    user.update(active: false) if DateTime.parse(person['EXPDATE']) < DateTime.now
  end
end
