module Sancho
  module Model

    # Page model
    Page = Data.define(:source, :url, :date) do
      # @param source [String] filename
      # @param url [String]
      def self.from(source, url = '')
        url = File.basename(source, '.md').downcase + '.html' if url.empty?
        date = File.mtime(source).to_date
        new(source:, url:, date:)
      end
    end

  end
end
