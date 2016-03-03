# encoding: UTF-8

require 'omniauth-oauth2'
require 'json'
require 'net/http'

module OmniAuth
  module Strategies
    class WinkPassword < OmniAuth::Strategies::OAuth2
      option :name, "wink_password"

      option :provider_ignores_state, true
      option :client_id, 'quirky_wink_android_app'
      option :client_secret, 'e749124ad386a5a35c0ab554a4f2c045'
      option :client_options, {
        :site => 'https://api.wink.com',
        :token_url => "/oauth2/token"
      }

      uid {
        raw_info["user_id"]
      }

      info do
        {
          "name" => "#{raw_info['first_name']} #{raw_info['last_name']}",
          "email" => raw_info["email"],
          "first_name" => raw_info["first_name"],
          "last_name" => raw_info["last_name"]
        }
      end

      extra do
        { "raw_info" => raw_info }
      end

      credentials do
        hash = {"token" => access_token.token}
        hash.merge!("refresh_token" => access_token.refresh_token) if access_token.refresh_token
        hash.merge!("expires_at" => access_token.expires_at) if access_token.expires?
        hash.merge!("expires" => access_token.expires?,
                    "email" => access_token.params["email"],
                    "password" => access_token.params["password"])
        hash
      end

      def request_phase
        form = ::OmniAuth::Form.new(:title => 'Wink Login', :url => callback_path)
        form.text_field "E-mail", "email"
        form.password_field "Password", "password"
        form.button 'Sign In'
        form.to_response
      end

      def build_password_access_token
        token = client.password.get_token(
            request.params["email"], request.params["password"],
            token_params.to_hash(:symbolize_keys => true),
            deep_symbolize(options.auth_token_params))
        token.params["email"] = request.params["email"]
        token.params["password"] = request.params["password"]
        return token
      end
      alias_method :build_access_token, :build_password_access_token

      def raw_info
        @raw_info ||= access_token.get("/users/me").parsed["data"]
      end
    end
  end
end
