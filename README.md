
# nenpou_csv_validator

公的年金等支払報告書（総務省通達形式）CSVの検証ツール

## Code Status
[![Build Status](https://travis-ci.org/arakanema/nenpou_csv_validator.svg?branch=master)](https://travis-ci.org/arakanema/nenpou_csv_validator)

## About
[eLTAX-各種ドキュメント-仕様書](http://www.eltax.jp/www/contents/1403107599834/index.html#dlCSV)に掲載してある、CSVレイアウト仕様書（公的年金支払報告書）に合致したデータであることを検証するためのツール.

## License
[MITライセンス](http://ja.wikipedia.org/wiki/MIT_License)  

This software is released under the MIT License, see LICENSE.

## Usage
1. 作業用フォルダを作成
1. 作業用フォルダに nenpou\_data\_validator.rb を置く
1. 同じフォルダにチェックしたいファイルをコピーする
1. nenpou\_data\_validator.rb を実行する
1. ファイル名.error.log が作られる
1. Excel or メモ帳 でファイルを開く
1. エラー箇所を確認

※チェック対象ファイルの拡張子は \*.csv, \*.txt, \*.dat を想定

\*.error.log の内容は以下のとおり

    何行目|チェック番号|チェック内容|エラーパターン|データ

※Rubyインタプリタが使えない環境用に、[ocra](http://rubygems.org/gems/ocra) にてexe化したファイルも合わせてコミットしている.  
　exe形式の利用方法は上記 .rb を .exe と読み替え.

## Contact
Issue, PullRequest, [問い合わせフォーム](https://drive.google.com/open?id=1oSCqvtAe9WDst_mJGI5POfdLlk_33UVOimLE9WPYI0k&authuser=0) より.

