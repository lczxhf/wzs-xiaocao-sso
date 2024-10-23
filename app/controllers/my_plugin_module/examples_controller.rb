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
      sso.custom_fields["xiaocao_token"] = params[:xiaocao_token]
      redirect_to sso_url(sso), allow_other_host: true
    end

    private

    def sso_url(sso)
      sso.to_url
    end
    
  end
end
