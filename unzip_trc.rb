#!/usr/bin/env ruby

require 'zip'
require 'pathname'
require 'csv'
require 'json'

JSON_COLS = %w[isbn	title	subtitle	author	author2	edition	publisher	publisher2	publishing_date	page	size	product_part	series	series2	series3	volume_title	price	set_price]

DATA_DIR = "docs"

def rename_ext(path, ext)
  Pathname(path).sub_ext(ext).to_s
end

def unzip_tsv(file)
  tsv_path = nil
  Zip::InputStream.open(file) do |zis|
    entry = zis.get_next_entry
    txt_path = File.join(DATA_DIR, entry.name)
    tsv_path = rename_ext(txt_path, ".tsv")
    File.write(tsv_path, zis.read)
  end
  tsv_path
end

def tsv2json(file)
  rows = CSV.read(file, col_sep: "\t", headers: JSON_COLS)
  rows.map(&:to_hash).to_json
end

if __FILE__ == $0
  file = ARGV[0]
  if ARGV.size != 1
    puts "usage: gettsv <filename>"
    exit 1
  end

  txt_path = unzip_tsv(file)
  json_path = rename_ext(txt_path, ".json")
  File.write(json_path, tsv2json(txt_path))
end

