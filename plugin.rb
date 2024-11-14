# frozen_string_literal: true

# name: wzs-xiaocao-sso
# about: custom sso 
# meta_topic_id: TODO
# version: 0.0.1
# authors: WZS
# url: https://forum.teendow.com
# required_version: 2.7.0

enabled_site_setting :plugin_name_enabled

module ::MyPluginModule
  PLUGIN_NAME = "wzs-xiaocao-sso"
end

require_relative "lib/my_plugin_module/engine"

after_initialize do
  # Code which should run after Rails has finished booting
  SessionController.skip_before_action :check_local_login_allowed, only: [:create]
  # SessionController.class_eval do
  #      protected
  #      def check_local_login_allowed(user: nil, check_login_via_email: false)
  #         return if user&.admin?
  #         if (check_login_via_email && !SiteSetting.enable_local_logins_via_email) ||
  #               !SiteSetting.enable_local_logins
  #               raise Discourse::InvalidAccess, "SSO takes over local login or the local login is disallowed."
  #         end
  #      end
  # end

  DiscourseConnectBase.class_eval do
    def unsigned_payload
        self.to_h.to_json
    end
  end
end
