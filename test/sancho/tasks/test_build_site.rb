require_relative '../test_helper'

describe Task::BuildSite do
  include SanchoHelper
  let(:subject) { Task::BuildSite }

  it '#run' do
    Tempbox.call {
      capture_io {
        File.write('README.md', '% README')
        File.write('CHANGELOG.md', '% CHANGELOG')
        
        config = Task::ReadConfig.run
        Task::CopyAssets.run(Dir.pwd)
        Task::BuildSite.run(config)

        content = %w[index.html readme.html changelog.html robots.txt sitemap.xml]
        content.each{ assert File.exist?(File.join(config.directory, it)) }
      }      
      # puts out
      # puts Dir['**/*.*']
    }
  end
end
