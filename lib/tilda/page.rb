module Tilda
  class Page
    def initialize(id)
      raise 'Page id must be set when creating class' if id.nil?
      @page_id = id
      @current_page = get_current_page
    end

    def get_current_page
      @current_page ||= Client.new.get_page_full_export(@page_id).dig(:result)
      #raise "Page not found" if page[:status] != 'FOUND' #TODO: replace with Error class
    end

    def get_html_code
      get_current_page.dig(:html)
    end

    def get_html_filename
      get_current_page.dig(:filename)
    end

    def get_css_files
      get_current_page.dig(:css)
    end

    def get_js_files
      get_current_page.dig(:js)
    end

    def get_published_timestamp
      get_current_page.dig(:published)
    end

    def get_img_files
      get_current_page.dig(:img)
    end

    def save_js(path)
      download_files(page.get_js_files, path) unless page.get_js_files.nil?
    end

    def save_css(path)
      download_files(page.get_css_files, path) unless page.get_css_files.nil?
    end

    def save_img(path)
      download_files(page.get_img_files, path) unless page.get_img_files.nil?
    end

    def save_html(path)
      full_name = "#{path}/#{page.get_html_filename}"
      File.open(full_name, "w") { |file| file.write(page.get_html_code) }
    end

    def save(path)
      save_js(path)
      save_css(path)
      save_img(path)
      save_html(path)
    end

    private

    def download_file(url, full_name)
      File.open(full_name, "w") do |file|
        HTTParty.get(url, stream_body: true) { |fragment| file.write(fragment) }
      end
    end

    def download_files(url_name_list, path)
      url_name_list.each do |file_info|
        download_file(file_info[:from], "#{path}/#{file_info[:to]}")
      end
    end
  end
end