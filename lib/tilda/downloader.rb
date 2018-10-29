module Tilda
  class Downloader
    def initialize(client)
      @client = client
    end

    def download_project(id)

    end

    def download_page(id)
      page = @client.get_page_export(id)
      page['result']['html']
    end
  end
end