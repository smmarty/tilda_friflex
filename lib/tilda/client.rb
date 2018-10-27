require 'httparty'

module Tilda
  class Client
    include HTTParty
    base_uri 'http://api.tildacdn.info/v1'

    parser(
      proc do |body, format|
        #raise Error if format != :json
        JSON.parse body
      end
    )

    def get_projects_list
      self.class.get '/getprojectslist', query_params
    end

    def get_project(id)
      self.class.get '/getproject', query_params(projectid: id)
    end

    def get_project_export(id)
      self.class.get '/getprojectexport', query_params(projectid: id)
    end

    def get_pages_list(id)
      self.class.get '/getpageslist', query_params(projectid: id)
    end

    def get_page(id)
      self.class.get '/getpage', query_params(pageid: id)
    end

    def get_page_full(id)
      self.class.get '/getpagefull', query_params(pageid: id)
    end

    def get_page_export(id)
      self.class.get '/getpageexport', query_params(pageid: id)
    end

    def get_page_full_export(id)
      self.class.get '/getpagefullexport', query_params(pageid: id)
    end

    private

    def query_params(params = {})
      { query: params.merge(auth_keys) }
    end

    def auth_keys
      { publickey: Config.config.public_key, secretkey: Config.config.private_key }
    end
  end
end
