class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :badge

  def badge
    return unless params[:badge]

    s2_session_id = S2Netbox::Commands::Authentication.login.session_id
    info = get_info(s2_session_id)
    picture = get_picture(s2_session_id)

    if info.success && picture.success
      @picture = picture.details['PICTURE']
      @full_name = "#{info.details['FIRSTNAME']} #{info.details['LASTNAME']}"
    else
      flash.alert = "Employee with badge ##{params[:badge]} not found."
      render :badge, status: 404
    end
  end

  def home; end

  private

  def get_info(s2_session_id)
    S2Netbox::ApiRequest.send_request(
      'GetPerson',
      { PERSONID: params[:badge] },
      s2_session_id
    )
  end

  def get_picture(s2_session_id)
    S2Netbox::ApiRequest.send_request(
      'GetPicture',
      { PERSONID: params[:badge] },
      s2_session_id
    )
  end
end
