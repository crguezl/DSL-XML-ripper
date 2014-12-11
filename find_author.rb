#!/usr/bin/env ruby

require 'rexml/document'
filename = ARGV.shift || 'fellowship.xml'
File.open(filename) do |f|
  doc = REXML::Document.new(f)
  author = REXML::XPath.first(doc, '/document/author')
  print "Author: "
  puts author.text

  puts "Chapters:"
  REXML::XPath.each(doc, '/document/chapter/title') do |title|
    puts "  "+title.text
  end
end
