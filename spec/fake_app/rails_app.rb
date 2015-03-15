require 'action_controller/railtie'
require 'action_view/railtie'

require 'fake_app/active_record/config' 
# config
app = Class.new(Rails::Application)
app.config.secret_key_base = '9489b3eee4eccf317ed77407553e8adc97baca7c74dc7ee33cd93e4c8b69477eea66eaedeb18af0be2679887c7c69c0a28c0fded0a71ea472a8c4laalal19cb'
app.config.secret_token = '3b7cd727ee24e8444053437c36cc66c4'
app.config.session_store :cookie_store, :key => '_myapp_session'
app.config.active_support.deprecation = :log
app.config.eager_load = false
# Rais.root
app.config.root = File.dirname(__FILE__)
Rails.backtrace_cleaner.remove_silencers!
app.initialize!

# routes
app.routes.draw do
  resources :users
end

#models
require 'fake_app/active_record/models'

# controllers
class ApplicationController < ActionController::Base; end
class UsersController < ApplicationController
  def index
    @users = User.paginate page: params[:page]
    render :inline => <<-ERB
<%= @users.map(&:name).join("\n") %>
<%= simple_paginate @users %>
ERB
  end
end

# helpers
Object.const_set(:ApplicationHelper, Module.new)
