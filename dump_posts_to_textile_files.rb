#!/usr/bin/env ruby 

require "sequel"
require "mysql"
require "fileutils"

posts_root = "/Users/tsaleh/code/tsaleh/tammer-saleh/content/unpublished"

Sequel.connect(:adapter=>'mysql', :host=>'localhost', :database=>'tammer_saleh_development', :user=>'root') do |db|
  db[:posts].all do |post|
    date     = post[:published_at]
    title    = post[:title]
    slug     = post[:slug]
    body     = post[:body]
    extended = post[:extended]

    filename = "#{posts_root}/#{slug}.textile"
    puts filename
    File.open(filename, "w+") do |f|
      f.puts "date: #{date}"
      f.puts
      f.puts "h1. #{title}"
      f.puts
      f << body
      f.puts
      f << extended
    end
  end
end

