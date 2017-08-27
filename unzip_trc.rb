#!/usr/bin/env ruby

require 'zip'
require 'pathname'
require 'csv'
require 'json'

JSON_COLS = %w[isbn	title	subtitle	author	author2	edition	publisher	publisher2	publishing_date	page	size	product_part	series	series2	series3	volume_title	price	set_price]
TSV_COLS = "ISBN	タイトル	サブタイトル	著者	著者2	版表示	出版社	発売者	出版年月	ページ数等	大きさ	付属資料の種類と形態	シリーズ名・シリーズ番号	シリーズ名・シリーズ番号2	シリーズ名・シリーズ番号3	各巻のタイトル	本体価格	セット本体価格"

DATA_DIR = "docs"

def rename_ext(path, ext)
  Pathname(path).sub_ext(ext).to_s
end

def unzip_tsv(file)
  txt_path = nil
  Zip::InputStream.open(file) do |zis|
    entry = zis.get_next_entry
    txt_path = File.join(DATA_DIR, entry.name)
    content = zis.read
    content.force_encoding("utf-8")
    File.write(txt_path, content)
    tsv_path = rename_ext(txt_path, ".tsv")
    tsv_data = TSV_COLS + "\r\n" + content
    File.write(tsv_path, tsv_data)
  end
  txt_path
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

