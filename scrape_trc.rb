#!/usr/bin/env ruby

require 'open-uri'
require 'nokogiri'
require 'uri'

ZIP_DIR = "zips"

def download_index_page(url)
  charset = nil
  html = open(url) do |f|
    charset = f.charset
    f.read
  end

  page = Nokogiri::HTML.parse(html, nil, charset)
  page
end

def find_zip_path(page, url)
  page.css("section a").each do |link|
    href = link["href"]
    filename = File.basename(href)
    zip_path = File.join(ZIP_DIR, filename)
    if filename =~ /.zip$/ && !File.exists?(zip_path)
      zip_url = URI.join(url, href)
      yield zip_url, zip_path
    end
  end
end

def main
  url = "http://www.trc.co.jp/trc_opendata/"
  page = download_index_page(url)
  find_zip_path(page, url) do |zip_url, path|
    zip_content = open(zip_url).read
    File.write(path, zip_content)
  end
end

main
