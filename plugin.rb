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
end
