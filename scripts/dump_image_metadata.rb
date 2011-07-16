#!/usr/bin/env bundle exec ruby

require 'csv'
require 'fileutils'

include FileUtils

CSV.read("config/images.csv", :headers => true).each do |row|
  file_without_ext = File.basename(row["file"], ".*")
  base_dir = "#{File.dirname(__FILE__)}/../content/attachments/images/#{file_without_ext}"
  meta_file = "#{base_dir}/meta.yml"
  puts meta_file
  meta = { :description => row["description"],
           :source_url  => row["source_url"] }
  File.open(meta_file, "w+") do |f|
    YAML.dump(meta, f)
  end
end

