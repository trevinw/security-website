class Api::PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :badge

  def badge
    if params[:badge]
      s2_session_id = S2Netbox::Commands::Authentication.login.session_id
      info = get_info(s2_session_id).details
      picture = get_picture(s2_session_id)

      S2Netbox::Commands::Authentication.logout(s2_session_id)

      render json: { info:, picture: }
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
    ).details['PICTURE']
  end
end
