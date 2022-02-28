# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super
    update_user_with_ldap_attributes
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  private

  def update_user_with_ldap_attributes
    user = User.find_by(username: params[:user][:username])

    return unless user.email.nil?

    ldap = Net::LDAP.new(host: 'seha.com')
    ldap.auth("#{params[:user][:username]}@seha.com", params[:user][:password])
    base = 'DC=seha,DC=com'
    filter = Net::LDAP::Filter.eq('userPrincipalName', "#{params[:user][:username]}@seha.com")
    result = ldap.search(base:, filter:, attributes: ['mail'], return_result: true).first

    user.update(email: result.mail.first)
  end
end
