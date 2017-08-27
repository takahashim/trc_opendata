# TRC新刊図書オープンデータ(trc_opendata) 非公式アーカイブ

[TRC新刊図書オープンデータ](http://www.trc.co.jp/trc_opendata/)の書誌情報ファイルをアーカイブするものです。

## アーカイブファイル

オリジナルのzipファイルは[zips](./zips/)に、zipファイルを展開したファイルは[docs](./docs/)以下に置いてあります。

### TSV形式ファイル (*.txt, *.tsv)

オリジナルの配布ファイルはTSV(tab separated values)形式ですが、拡張子は`.txt`になっています。これはこのまま保存しています。

さらに、これに「収録項目」の各項目をヘッダとして追加したファイルを`.tsv`にrenameして保存しています。こちらのファイルは、githubの拡張子対応により、github上で閲覧した際に表形式で表示されます。

例: https://github.com/takahashim/trc_opendata/blob/master/docs/TRCOpenBibData_20170826.tsv

### JSON形式ファイル (*.json)

TSVを変換したJSON形式のファイルも配布しています。ファイル名は同じで、拡張子を`.json`にしたものです。

JSONの各メンバー名は以下のようにしています(いまいちONIX等との互換性もないようなので命名は適当です)。

* isbn
* title
* subtitle
* author
* author2
* edition
* publisher
* publisher2
* publishing_date
* page
* size
* product_part
* series
* series2
* series3
* volume_title
* price
* set_price


## ライセンス

元データについては以下の条件が記載されています。

> ※この書誌情報は、営利・非営利を問わず、利用手続きなしでご自由にご利用いただけます。なお、この書誌情報を利用して行う行為について、弊社では一切責任を負うものではありません。

ここでアーカイブしているファイルについても、オリジナルの配布・利用条件に従います。
