# coding: utf-8

VERSION = '20141004'

class NenpouCsvValidator

  attr_reader :prepare_err, :eltax_data

  OK      = true
  NG      = false
  LOG_SEP = "\t"
  CASE    = {
    check_enc: {
      :msg      => "●ファイルの文字コードが不正です●",
    },
    check_cnt: {
      :msg      => "●項目数が不正です●",
    },
    check_001: {
      :msg      => "法定資料の種類 331であること 必須",
      :must     => true,
      :pattern  => /^331$/,
      :max_size => 3,
      :range    => nil,
    },
    check_002: {
      :msg      => "整理番号1 税務署から連絡されている１０桁の整理番号 半角10",
      :must     => false,
      :pattern  => /^([0-9]|[A-z]|\s)*$/,
      :max_size => 10,
      :range    => nil,
    },
    check_003: {
      :msg      => "本支店等区分番号 半角5",
      :must     => false,
      :pattern  => /^[[:ascii:]]*$/,
      :max_size => 5,
      :range    => nil,
    },
    check_004: {
      :msg      => "提出義務者の住所又は所在地 必須 全角60",
      :must     => true,
      :pattern  => /^[^ -~｡-ﾟ]+$/,
      :max_size => 60,
      :range    => nil,
    },
    check_005: {
      :msg      => "提出義務者の氏名又は名称 必須 全角30",
      :must     => true,
      :pattern  => /^[^ -~｡-ﾟ]+$/,
      :max_size => 30,
      :range    => nil,
    },
    check_006: {
      :msg      => "提出義務者の電話番号 半角15",
      :must     => false,
      :pattern  => /^[[:ascii:]]*$/,
      :max_size => 15,
      :range    => nil,
    },
    check_007: {
      :msg      => "整理番号2 税務署から連絡されている１３桁の整理番号 半角13",
      :must     => false,
      :pattern  => /^[[:ascii:]]*$/,
      :max_size => 13,
      :range    => nil,
    },
    check_008: {
      :msg      => "提出者の住所又は所在地 ブランク 全角60",
      :must     => false,
      :pattern  => /^[^ -~｡-ﾟ]*$/,
      :max_size => 60,
      :range    => nil,
    },
    check_009: {
      :msg      => "提出者の氏名又は名称 ブランク 全角30",
      :must     => false,
      :pattern  => /^[^ -~｡-ﾟ]*$/,
      :max_size => 30,
      :range    => nil,
    },
    check_010: {
      :msg      => "訂正表示 必須 数字1 0~3",
      :must     => true,
      :pattern  => /^0|1|2|3$/,
      :max_size => 1,
      :range    => nil,
    },
    check_011: {
      :msg      => "年分 必須 数字2",
      :must     => true,
      :pattern  => /^[0-9]+$/,
      :max_size => 2,
      :range    => nil,
    },
    check_012: {
      :msg      => "支払を受ける者－住所又は居所 必須 全角60",
      :must     => true,
      :pattern  => /^[^ -~｡-ﾟ]+$/,
      :max_size => 60,
      :range    => nil,
    },
    check_013: {
      :msg      => "支払を受ける者－国外住居表示 数字1 0~1",
      :must     => false,
      :pattern  => /^(0|1)*$/,
      :max_size => 1,
      :range    => nil,
    },
    check_014: {
      :msg      => "支払を受ける者－氏名 必須 全角30",
      :must     => true,
      :pattern  => /^[^ -~｡-ﾟ]+$/,
      :max_size => 30,
      :range    => nil,
    },
    check_015: {
      :msg      => "受給者の生年月日－元号 必須 数字1 1~4",
      :must     => true,
      :pattern  => /^1|2|3|4$/,
      :max_size => 1,
      :range    => nil,
    },
    check_016: {
      :msg      => "受給者の生年月日－年 必須 数字2 01~99",
      :must     => true,
      :pattern  => /^[0-9][0-9]$/,
      :max_size => 2,
      :range    => 1..99,
    },
    check_017: {
      :msg      => "受給者の生年月日－月 必須 数字2 01~12",
      :must     => true,
      :pattern  => /^[0-9][0-9]$/,
      :max_size => 2,
      :range    => 1..12,
    },
    check_018: {
      :msg      => "受給者の生年月日－日 必須 数字2 01~31",
      :must     => true,
      :pattern  => /^[0-9][0-9]$/,
      :max_size => 2,
      :range    => 1..31,
    },
    check_019: {
      :msg      => "所得税法第２０３条の３第１号適用分－支払金額 数字10 0以上であること",
      :must     => false,
      :pattern  => /^[0-9]*$/,
      :max_size => 10,
      :range    => nil,
    },
    check_020: {
      :msg      => "所得税法第２０３条の３第１号適用分－未払金額 数字10 0以上であること",
      :must     => false,
      :pattern  => /^[0-9]*$/,
      :max_size => 10,
      :range    => nil,
    },
    check_021: {
      :msg      => "所得税法第２０３条の３第１号適用分－源泉徴収税額 数字10 0以上であること",
      :must     => false,
      :pattern  => /^[0-9]*$/,
      :max_size => 10,
      :range    => nil,
    },
    check_022: {
      :msg      => "所得税法第２０３条の３第１号適用分－未徴収税額 数字10 0以上であること",
      :must     => false,
      :pattern  => /^[0-9]*$/,
      :max_size => 10,
      :range    => nil,
    },
    check_023: {
      :msg      => "所得税法第２０３条の３第２号適用分－支払金額 数字10 0以上であること",
      :must     => false,
      :pattern  => /^[0-9]*$/,
      :max_size => 10,
      :range    => nil,
    },
    check_024: {
      :msg      => "所得税法第２０３条の３第２号適用分－未払金額 数字10 0以上であること",
      :must     => false,
      :pattern  => /^[0-9]*$/,
      :max_size => 10,
      :range    => nil,
    },
    check_025: {
      :msg      => "所得税法第２０３条の３第２号適用分－源泉徴収税額 数字10 0以上であること",
      :must     => false,
      :pattern  => /^[0-9]*$/,
      :max_size => 10,
      :range    => nil,
    },
    check_026: {
      :msg      => "所得税法第２０３条の３第２号適用分－未徴収税額 数字10 0以上であること",
      :must     => false,
      :pattern  => /^[0-9]*$/,
      :max_size => 10,
      :range    => nil,
    },
    check_027: {
      :msg      => "所得税法第２０３条の３第３号適用分－支払金額 数字10 0以上であること",
      :must     => false,
      :pattern  => /^[0-9]*$/,
      :max_size => 10,
      :range    => nil,
    },
    check_028: {
      :msg      => "所得税法第２０３条の３第３号適用分－未払金額 数字10 0以上であること",
      :must     => false,
      :pattern  => /^[0-9]*$/,
      :max_size => 10,
      :range    => nil,
    },
    check_029: {
      :msg      => "所得税法第２０３条の３第３号適用分－源泉徴収税額 数字10 0以上であること",
      :must     => false,
      :pattern  => /^[0-9]*$/,
      :max_size => 10,
      :range    => nil,
    },
    check_030: {
      :msg      => "所得税法第２０３条の３第３号適用分－未徴収税額 数字10 0以上であること",
      :must     => false,
      :pattern  => /^[0-9]*$/,
      :max_size => 10,
      :range    => nil,
    },
    check_031: {
      :msg      => "本人－特別障害者 数字1 0~1",
      :must     => false,
      :pattern  => /^(0|1)*$/,
      :max_size => 1,
      :range    => nil,
    },
    check_032: {
      :msg      => "本人－その他の障害者 数字1 0~1",
      :must     => false,
      :pattern  => /^(0|1)*$/,
      :max_size => 1,
      :range    => nil,
    },
    check_033: {
      :msg      => "本人－老年者 ブランク 数字1",
      :must     => false,
      :pattern  => /^([0-9])*$/,
      :max_size => 1,
      :range    => nil,
    },
    check_034: {
      :msg      => "控除対象配偶者の有無等 数字1 1~3",
      :must     => false,
      :pattern  => /^(1|2|3)*$/,
      :max_size => 1,
      :range    => nil,
    },
    check_035: {
      :msg      => "控除対象扶養親族の数－老人 数字2",
      :must     => false,
      :pattern  => /^[0-9]*$/,
      :max_size => 2,
      :range    => nil,
    },
    check_036: {
      :msg      => "控除対象扶養親族の数－その他 数字2",
      :must     => false,
      :pattern  => /^[0-9]*$/,
      :max_size => 2,
      :range    => nil,
    },
    check_037: {
      :msg      => "障害者の数－特別障害者 数字2",
      :must     => false,
      :pattern  => /^[0-9]*$/,
      :max_size => 2,
      :range    => nil,
    },
    check_038: {
      :msg      => "障害者の数－その他 数字2",
      :must     => false,
      :pattern  => /^[0-9]*$/,
      :max_size => 2,
      :range    => nil,
    },
    check_039: {
      :msg      => "社会保険料の金額 数字10 0以上であること",
      :must     => false,
      :pattern  => /^[0-9]*$/,
      :max_size => 10,
      :range    => nil,
    },
    check_040: {
      :msg      => "控除対象扶養親族の数－特定 数字2",
      :must     => false,
      :pattern  => /^[0-9]*$/,
      :max_size => 2,
      :range    => nil,
    },
    check_041: {
      :msg      => "摘要 全角100",
      :must     => false,
      :pattern  => /^[^ -~｡-ﾟ]*$/,
      :max_size => 100,
      :range    => nil,
    },
    check_042: {
      :msg      => "障害者の数－特別障害者のうち同居 数字2",
      :must     => false,
      :pattern  => /^[0-9]*$/,
      :max_size => 2,
      :range    => nil,
    },
    check_043: {
      :msg      => "本人－特別寡婦 数字1 0~1",
      :must     => false,
      :pattern  => /^(0|1)*$/,
      :max_size => 1,
      :range    => nil,
    },
    check_044: {
      :msg      => "本人－寡婦・寡夫 数字1 0~1",
      :must     => false,
      :pattern  => /^(0|1)*$/,
      :max_size => 1,
      :range    => nil,
    },
    check_045: {
      :msg      => "１６歳未満の扶養親族の数 数字2",
      :must     => false,
      :pattern  => /^[0-9]*$/,
      :max_size => 2,
      :range    => nil,
    },
    check_046: {
      :msg      => "カナ氏名 必須 半角カナ60",
      :must     => true,
      :pattern  => /^([\xA1-\xDF]|\s)+$/s,
      :max_size => 60,
      :range    => nil,
      :hankaku_kana => true,
    },
    check_047: {
      :msg      => "受給者番号 半角25",
      :must     => false,
      :pattern  => /^[[:ascii:]]*$/,
      :max_size => 25,
      :range    => nil,
    },
    check_048: {
      :msg      => "提出先市町村コード 必須 数字6 5桁~6桁",
      :must     => true,
      :pattern  => /^[0-9]{5,}$/,
      :max_size => 6,
      :range    => nil,
    },
    check_049: {
      :msg      => "指定番号 半角12",
      :must     => false,
      :pattern  => /^[[:ascii:]]*$/,
      :max_size => 12,
      :range    => nil,
    },
  }

  def initialize(log_fd)
    @logging_to  = log_fd
    @prepare_err = nil
    @eltax_data  = false
  end

  def prepare_validate?(line)
    begin
      size = line.split(/@/).size
      @eltax_data = true if size == 2
    rescue
      @prepare_err = :check_enc
      return false
    end
    data = ""
    if @eltax_data
      data = line.split(/@/)[1]
    else
      data = line
    end
    unless data.split(/,/).size == 49
      @prepare_err = :check_cnt
      return false
    end
    return true
  end

  def validate(check_id, data, lineno)
    test_case = data.chomp
    validate_result = OK
    error_msg = []
    # must
    if test_case.empty? && CASE[check_id][:must]
      validate_result = NG 
      error_msg.push "必須"
    end
    # pattern
    if CASE[check_id][:hankaku_kana]
      unless CASE[check_id][:pattern] =~ test_case
        validate_result = NG
        error_msg.push "パターン"
      end
    else
      unless CASE[check_id][:pattern] =~ test_case.encode('utf-8')
        validate_result = NG
        error_msg.push "パターン"
      end
    end
    # size
    if !test_case.empty? && CASE[check_id][:max_size] < test_case.encode('utf-8').split(//).size
      validate_result = NG
      error_msg.push "サイズ"
    end
    # range
    if !test_case.empty? && CASE[check_id][:range] && !CASE[check_id][:hankaku_kana]
      begin
        unless CASE[check_id][:range].include?(test_case.to_i)
          validate_result = NG
          error_msg.push "範囲"
        end
      rescue
        validate_result = NG
        error_msg.push "範囲"
      end
    end
    # logging
    unless validate_result == OK
      logging(check_id, test_case, lineno, error_msg.join('&')) if @logging_to
      return NG
    end
    return OK
  end

  def logging(check_id, data, lineno, error_msg)
    log_output  = "#{sprintf('%05d', lineno)}#{LOG_SEP}"
    log_output += "#{check_id.to_s}#{LOG_SEP}"
    log_output += "#{CASE[check_id][:msg]}#{LOG_SEP}"
    log_output += "#{error_msg}#{LOG_SEP}"
    @logging_to.write log_output.encode('cp932')
    @logging_to.puts ">#{data}<".encode('cp932')
  end
end

def main
  ext_patterns = ["./*.csv", "./*.txt", "./*.dat"]
  csv_files = Dir.glob(ext_patterns)
  csv_files.each do |file|
    puts Time.now.strftime("%Y-%m-%d %H:%M:%S ") + "#{file.to_s}"
    input = File.open(file, "r:cp932")
    output = File.open("#{file}.error.log", "w:cp932")
    input.each_line.with_index do |line, lineno|
      validator = NenpouCsvValidator.new(output)
      unless validator.prepare_validate?(line)
        validator.logging(validator.prepare_err, '', lineno + 1, '検証不可能')
        next
      end
      if validator.eltax_data
        target_data = line.split(/@/)[1]
      else
        target_data = line
      end
      target_data.split(/,/).each.with_index do |data, index|
        check_id = "check_#{sprintf('%03d', index + 1)}".to_sym
        validator.validate(check_id, data, lineno + 1)
      end
    end
    input.close; output.close
  end
end

def show_info(version)
  info = <<-INFO

  The MIT License (MIT)

  Copyright (c) 2014 Masahiro Arakane

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.

  - nenpou_csv_validator.rb
    - version : #{version}
    - https://github.com/arakanema/nenpou_csv_validator

  INFO
  puts info
end

if $0 == __FILE__
  show_info(VERSION)
  puts "処理を開始します、何かキーを押してください"
  dummy = gets
  main()
  puts "終了するには何かキーを押してください"
  dummy = gets
end

