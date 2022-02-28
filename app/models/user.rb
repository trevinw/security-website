class User < ApplicationRecord
  devise :ldap_authenticatable
end
