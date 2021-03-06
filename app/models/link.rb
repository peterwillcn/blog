class Link
  class << self
    def fetch_title(url)
      meta = fetch(url)
      title = meta.try(:title).to_s.scrub
      Rails.cache.delete(url) if title.blank?
      title
    end

    def fetch(url)
      Rails.cache.fetch(url, expires_in: 1.hours) do
        MetaInspector.new(url)
      end
    rescue => e
      Rails.logger.error "#{e.message}\n#{e.backtrace.join("\n        from ")}"
      nil
    end
  end
end
