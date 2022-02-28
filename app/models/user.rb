class User < ApplicationRecord
  devise :ldap_authenticatable

  after_create :add_info_from_s2

  def add_info_from_s2
    person = S2Netbox::ApiRequest.send_request(
      'SearchPersonData',
      { PERSONID: username.delete('^0-9') },
      s2_session_id
    ).details['PEOPLE']['PERSON']

    update(
      first_name: person['FIRSTNAME'],
      last_name: person['LASTNAME'],
      badge: person['PERSONID'].to_i,
      job_title: person['UDF10'],
      department: person['UDF5']
    )
  end

  def s2_session_id
    S2Netbox::Commands::Authentication.login.session_id
  end
end
