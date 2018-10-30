require 'httparty'

module Tilda
  class Downloader
    def initialize(client, save_path)
      @client = client
      @save_path = save_path
    end

    def save_project(id)

    end

    def save_page(id)
      page = @client.get_page_export(id)
      #page[:result][:html] = nil
      save_js(page[:result])
      save_css(page[:result])
      save_img(page[:result])
      #page
    end

    private

    def download_file(url, full_name)
      File.open(full_name, "w") do |file|
        HTTParty.get(url, stream_body: true) { |fragment| file.write(fragment) }
      end
    end

    def save_files(url_name_list)
      url_name_list.each do |file_obj|
        download_file(file_obj[:from], "#{@save_path}/#{file_obj[:to]}")
      end
    end

    def save_js(files)
      save_files(files[:js]) unless files[:js].nil?
    end

    def save_css(files)
      save_files(files[:css])  unless files[:css].nil?
    end

    def save_img(files)
      save_files(files[:images])  unless files[:images].nil?
    end

  end
end