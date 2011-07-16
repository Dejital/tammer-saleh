#!/usr/bin/env bundle exec ruby

CSV.read("config/images.csv").each do |i,file,desc,source_url|
  source_file = Dir["content/attachments/images/#{i}-original.*"].first
  dest_file   = "content/attachments/images/#{file}/original.#{File.extname(source_file)}"
  FileUtil.mkdir_p File.dirname(dest_file)
  FileUtil.mv source_file, dest_file
end

