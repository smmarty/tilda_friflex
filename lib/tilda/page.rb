module Tilda
  class Page
    def initialize(id, only_body: nil)
      raise 'Page id must be set when creating class' if id.nil?
      @page_id = id
      @only_body = only_body
      @current_page = nil
    end

    def get_current_page
      @current_page ||= fetch_page(@only_body).dig(:result)
    end

    def fetch_page(only_body)
      if only_body.nil?
        page = Client.new.get_page_full_export(@page_id)
      else
        page = Client.new.get_page_export(@page_id)
      end
      raise "Page not found" if page[:status] != 'FOUND' #TODO: replace with Error class
      return page
    end

    def get_html_code
      get_current_page.dig(:html)
    end

    def get_html_filename
      get_current_page.dig(:filename)
    end

    def get_html_meta_tags(files_url_path = nil)
      tags_list = ''
      get_css_files.each {|filename| tags_list << "<link rel=\"stylesheet\" href=\"#{files_url_path}#{filename}\" type=\"text/css\" media=\"all\"/>\n" }
      get_js_files.each {|filename| tags_list << "<script src=\"#{files_url_path}#{filename}\"></script>\n" }
      return tags_list
    end

    def get_published_timestamp
      get_current_page.dig(:published)
    end

    def get_css_struct
      get_current_page.dig(:css)
    end

    def get_js_struct
      get_current_page.dig(:js)
    end

    def get_img_struct
      get_current_page.dig(:images)
    end

    def get_img_files
      get_img_struct.map { |struct| struct[:to] }
    end

    def get_css_files
      get_css_struct.map { |struct| struct[:to] }
    end

    def get_js_files
      get_js_struct.map { |struct| struct[:to] }
    end

    def save_js(path)
      download_files(get_js_struct, path) unless get_js_struct.nil?
    end

    def save_css(path)
      download_files(get_css_struct, path) unless get_css_struct.nil?
    end

    def save_img(path)
      download_files(get_img_struct, path) unless get_img_struct.nil?
    end

    def save_html(path)
      full_name = "#{path}/#{get_html_filename}"
      File.open(full_name, "wb") { |file| file.write(get_html_code) }
    end

    def save(path)
      save_js(path)
      save_css(path)
      save_img(path)
      save_html(path)
    end

    private

    def download_file(url, full_name)
      File.open(full_name, "wb") do |file|
        HTTParty.get(url, stream_body: true) { |fragment| file.write(fragment) }
      end
    end

    def download_files(url_name_list, path)
      return if url_name_list.empty?
      url_name_list.each do |file_info|
        download_file(file_info[:from], "#{path}/#{file_info[:to]}")
      end
    end
  end
end