module Tilda
  class Cache
    def initialize(cache_path = nil)
      @cache_path = cache_path || Config.config.cache_path
      if @cache_path.nil?
        @cache_path = defined?(Rails) ? "#{Rails.public_path}/tilda/" : "/tmp/tilda/"
      end
    end

    def get_cached_page(id)
      @cache_path
    end

    def cache_page(id)

    end

    def get_page_by_id

    end

    #private

    def clear_page(page)
      FileUtils.rmdir(get_page_fullpath(page), noop: true, verbose: true) #TODO: really do nothing
    end

    def get_page_dirname(page)
      "#{page.get_html_filename}__#{page.get_published_timestamp}"
    end

    def get_page_fullpath(page)
      "#{@cache_path}/#{get_page_dirname(page)}"
    end

    private

    def mk_path(path)
      FileUtils.mkdir_p(path) unless File.directory?(path)
    end


  end
end
