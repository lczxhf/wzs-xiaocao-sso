# frozen_string_literal: true

module ::MyPluginModule
  class ExamplesController < ::ApplicationController
    requires_plugin PLUGIN_NAME
    layout false
    skip_before_action :check_xhr

    def index
      raise Discourse::NotFound unless SiteSetting.enable_discourse_connect?

      destination_url = cookies[:destination_url] || session[:destination_url]
      return_path = params[:return_path] || path("/")
      if destination_url && return_path == path("/")
        uri = URI.parse(destination_url)
        return_path = "#{uri.path}#{uri.query ? "?#{uri.query}" : ""}"
      end

      session.delete(:destination_url)
      cookies.delete(:destination_url)

      sso = DiscourseConnect.generate_sso(return_path, secure_session: secure_session)
      sso.custom_fields["token"] = params[:token]
      sso.custom_fields["cid"] = params[:cid]
      sso.custom_fields["apiwg"] = params[:apiwg]
      redirect_to sso_url(sso,params[:apiwg]), allow_other_host: true
    end

    private

    def sso_url(sso,host)
      sso.to_url(host ? "https://#{host}:6443/v3/user/ssocheck" : nil)
    end

  end
end
