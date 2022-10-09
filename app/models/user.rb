class User < ApplicationRecord
  has_many :deliveries

  devise :ldap_authenticatable
  rolify before_add: :remove_previous_role

  before_create :add_info_from_s2
  after_create :assign_default_role

  def capital_username
    username.upcase
  end

  def full_name_with_badge
    "#{badge} - #{first_name} #{last_name}"
  end

  private

  def add_info_from_s2
    person = S2Netbox::ApiRequest.send_request(
      'SearchPersonData',
      { PERSONID: username.delete('^0-9') },
      s2_session_id
    ).details['PEOPLE']['PERSON']

    self.first_name = person['FIRSTNAME']
    self.last_name = person['LASTNAME']
    self.badge = person['PERSONID'].to_i
    self.job_title = person['UDF10']
    self.department = person['UDF5']
  end

  def assign_default_role
    if department == '783 Security'
      if job_title == 'Security Officer'
        add_role(:security_lead)
      else
        add_role(:security_rover)
      end
    else
      add_role(:user)
    end
  end

  def remove_previous_role(_role)
    self.roles = []
  end

  def s2_session_id
    S2Netbox::Commands::Authentication.login.session_id
  end
end
