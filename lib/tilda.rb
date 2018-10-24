require 'httparty'
require 'dry-configurable'
#require 'tilda/version'
#require 'tilda/config'
#require 'tilda/client'

module Tilda
  class Client
    extend Dry::Configurable
    setting :public_key
    setting :private_key

    include HTTParty
    base_uri 'http://api.tildacdn.info/v1'

    def get_projects_list
      response = self.class.get "/getprojectslist", query_params
      JSON.parse response.body.to_s
    end

    private

    def query_params(params = {})
      { query: params.merge(auth_keys) }
    end

    def auth_keys
      { publickey: Client.config.public_key, secretkey: Client.config.private_key }
    end
  end
end
