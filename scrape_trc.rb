#!/usr/bin/env ruby

require 'open-uri'
require 'nokogiri'
require 'uri'

url = "http://www.trc.co.jp/trc_opendata/"
ZIP_DIR = "zips"

charset = nil
html = open(url) do |f|
  charset = f.charset
  f.read
end

page = Nokogiri::HTML.parse(html, nil, charset)
page.css("section a").each do |link|
  href = link["href"]
  filename = File.basename(href)
  zip_filename = File.join(ZIP_DIR, filename)
  if filename =~ /.zip$/ && !File.exists?(zip_filename)
    zip_url = URI.join(url, href)
    zip_content = open(zip_url).read
    File.write(zip_filename, zip_content)
  end
end
