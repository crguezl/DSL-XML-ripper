#!/usr/bin/env ruby

require 'rexml/document'
filename = ARGV.shift || 'fellowship.xml'
File.open(filename) do |f|
  doc = REXML::Document.new(f)
  REXML::XPath.each(doc, '/document/author') do |author|
    author.text = 'J.R.R. Tolkien'
  end
  puts doc
end
