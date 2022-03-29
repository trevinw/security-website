class Api::PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :badge

  def badge
    if params[:badge]
      s2_session_id = S2Netbox::Commands::Authentication.login.session_id
      info = get_info(s2_session_id)
      picture = get_picture(s2_session_id)

      if info.success && picture.success
        render json: { info: info.details, picture: picture.details['PICTURE'] }
      else
        render json: { error: 'Something went wrong with the request, possibly an invalid badge number?' }
      end
    else
      render json: { error: 'Must specify a badge in the query string, such as: `/badge?badge=1234`' }
    end
  end

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
