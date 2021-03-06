class DiscourseSsoController < ApplicationController
  def sso
    secret = "redinnovacion"
    sso = SingleSignOn.parse(request.query_string, secret)

    if sso
      sso.email = current_refinery_user.email
      sso.name = current_refinery_user.full_name
      sso.username = current_refinery_user.username
      sso.external_id = current_refinery_user.id
      sso.sso_secret = secret

      redirect_to sso.to_url("http://auth.redinnovacion.org/session/sso_login")
    else
      redirect_to new_refinery_user_session_url
    end

  end
end