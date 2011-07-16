#!/usr/bin/env bundle exec ruby

require 'csv'
require 'fileutils'

include FileUtils::Verbose

CSV.read("config/images.csv", :headers => true).each do |row|
  source_file_glob = "#{File.dirname(__FILE__)}/../content/attachments/images/#{row["id"]}-original.*"
  source_file = Dir[source_file_glob].first
  puts "Can't find original file in #{source_file_glob}" unless source_file
  puts "Converting #{source_file}"
  dest_file = "content/attachments/images/#{row["file"]}/original.#{File.extname(source_file)}"
  mkdir_p File.dirname(dest_file)
  mv source_file, dest_file
end

