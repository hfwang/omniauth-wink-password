# encoding: UTF-8

require 'omniauth-oauth2'
require 'json'
require 'net/http'

module OmniAuth
  module Strategies
    class WinkPassword

      include OmniAuth::Strategy

      args [:dummy]
      option :dummy, nil

      CLIENT = ::OAuth2::Client.new(
          'quirky_wink_android_app', 'e749124ad386a5a35c0ab554a4f2c045',
          :site => 'https://api.wink.com',
          :token_url => "/oauth2/token")

      attr_accessor :access_token

      # option :client_options, {
      #   :site => 'https://cloud.lifx.com',
      #   :authorize_url => '/oauth/authorize',
      #   :token_url => '/oauth/token'
      # }
      # option :scope, "remote_control:all"

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

      credentials do
        hash = {"token" => access_token.token}
        hash.merge!("refresh_token" => access_token.refresh_token) if access_token.expires? && access_token.refresh_token
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

      def callback_phase
        self.access_token = CLIENT.password.get_token(request.params["email"], request.params["password"])
        self.access_token.params["email"] = request.params["email"]
        self.access_token.params["password"] = request.params["password"]
        super
      rescue ::OAuth2::Error => e
        fail!(:invalid_credentials, e)
      rescue ::Timeout::Error, ::Errno::ETIMEDOUT => e
        fail!(:timeout, e)
      rescue ::SocketError => e
        fail!(:failed_to_connect, e)
      end

      def raw_info
        @raw_info ||= access_token.get("/users/me").parsed["data"]
      end
    end
  end
end
