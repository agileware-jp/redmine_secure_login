require 'redmine_secure_login/account_controller_patch'

ActionDispatch::Callbacks.to_prepare do
  require_dependency 'account_controller'

  unless AccountController.included_modules.include?(RedmineSecureLogin::AccountControllerPatch)
    AccountController.send(:include, RedmineSecureLogin::AccountControllerPatch)
  end
end

Redmine::Plugin.register :redmine_secure_login do
  name 'Redmine Secure Login plugin'
  author 'Agileware, Inc'
  description 'This is a secure login plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
end
