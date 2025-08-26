require_relative '../test_helper'

describe Task::BuildSite do
  include SanchoHelper
  let(:subject) { Task::BuildSite }

  it '#run' do
    Tempbox.call {
      # capture_io {
        File.write('README.md', '% README')
        File.write('CHANGELOG.md', '% CHANGELOG')
        
        config = Task::ReadConfig.run
        Task::CopyAssets.run(Dir.pwd)
        Task::BuildSite.run(config)
        puts Dir[File.join(config.directory, '**/*.*')]
        Task::ServeSite.run
      # }      
      # puts out
    }
  end
end
