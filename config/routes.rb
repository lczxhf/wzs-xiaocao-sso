# frozen_string_literal: true

MyPluginModule::Engine.routes.draw do
  get "/sso" => "examples#index"
  # define routes here
end

Discourse::Application.routes.draw { mount ::MyPluginModule::Engine, at: "xiaocao" }
