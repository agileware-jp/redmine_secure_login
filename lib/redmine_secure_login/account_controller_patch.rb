module RedmineSecureLogin
  module AccountControllerPatch
    extend ActiveSupport::Concern

    included do
      alias_method_chain :invalid_credentials, :secure_login
      alias_method_chain :password_authentication, :secure_login
    end

    def invalid_credentials_with_secure_login
      session[:login_failure_count] ||= 0
      session[:login_failure_count] += 1

      invalid_credentials_without_secure_login
    end

    def password_authentication_with_secure_login
      return if session[:login_failure_count].present? && session[:login_failure_count] > 5
      password_authentication_without_secure_login
    end
  end
end
