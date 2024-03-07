module Sancho

  class Page < Data.define(:source, :url, :date)
    def initialize(source:, url: '')
      url = File.basename(source, '.md').downcase + '.html' if url.empty?
      date = File.mtime(source).to_date
      super(source: source, url: url, date: date)
    end
  end

end
