#!/usr/bin/env bundle exec ruby

require 'csv'
require 'fileutils'

include FileUtils

CSV.read("config/images.csv", :headers => true).each do |row|
  source_file_glob = "#{File.dirname(__FILE__)}/../content/attachments/images/#{row["id"]}-original.*"
  source_file = Dir[source_file_glob].first

  puts "Can't find original file in #{source_file_glob}" unless source_file

  file_without_ext = File.basename(row["file"], ".*")
  ext = File.extname(source_file)
  dest_file = "content/attachments/images/#{file_without_ext}/original.#{ext}"

  puts dest_file

  mkdir_p File.dirname(dest_file)
  mv source_file, dest_file
end

