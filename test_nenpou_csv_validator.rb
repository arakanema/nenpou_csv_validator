# coding: utf-8

$:.unshift(File.expand_path(File.dirname(__FILE__)))
require "nenpou_csv_validator"
require "test/unit"

class NenpouCsvValidatorTest < Test::Unit::TestCase
  def setup
    @validator = NenpouCsvValidator.new(nil)
    @lineno = 0
    @fixtures = {
      check_001: '318',
      check_002: '12345678901',
      check_003: '12345あ',
      check_004: '東京 都千代田区永田町二丁目ああああああああああああああああ',
      check_005: 'ｆｊｄａｏｉｊｆｏａｊｆ  ｏａｊｆａｊｏｆａｆ',
      check_006: '12345 78--9012345',
      check_007: '1234567890a39999',
      check_008: 'fa  ',
      check_009: 'ba   aaa',
      check_010: '4',
      check_011: '２４',
      check_012: 'あいう えお-かきくけこ',
      check_013: '8',
      check_014: '支払い-太郎',
      check_015: '窓際係長 ',
      check_016: 'syubetu',
      check_017: '-12345',
      check_018: '12-345',
      check_019: ' 12345',
      check_020: '12345'*3,
      check_021: '12345あ',
      check_022: '1234 5',
      check_023: '-120',
      check_024: '8 ',
      check_025: '-12345',
      check_026: '12 ',
      check_027: '123,333',
      check_028: '-9',
      check_029: '2,300',
      check_030: '-588 ',
      check_031: '577',
      check_032: '45aaaa',
      check_033: '33fafa',
      check_034: '34  fa',
      check_035: '9 ',
      check_036: '-12345',
      check_037: '-12345',
      check_038: '-12345',
      check_039: '-12345',
      check_040: '-12345',
      check_041: '-12345',
      check_042: '-12345',
      check_043: '-12345',
      check_044: '9',
      check_045: '000',
      check_046: '14',
      check_047: 'Ａ-1234',
      check_048: '　',
      check_049: '12345-Ａ',
    }
  end

  def mock(method_name)
    check_id = method_name.to_s.split('_')[1..-1].join('_').to_sym
    fixture = @fixtures[check_id].encode('cp932')
    assert_equal(
      false,
      @validator.validate(check_id, fixture, @lineno),
      "fixture => #{fixture.encode('utf-8')}"
    )
  end

  def test_check_001; mock __method__; end
  def test_check_002; mock __method__; end
  def test_check_003; mock __method__; end
  def test_check_004; mock __method__; end
  def test_check_005; mock __method__; end
  def test_check_006; mock __method__; end
  def test_check_007; mock __method__; end
  def test_check_008; mock __method__; end
  def test_check_009; mock __method__; end
  def test_check_011; mock __method__; end
  def test_check_012; mock __method__; end
  def test_check_013; mock __method__; end
  def test_check_014; mock __method__; end
  def test_check_015; mock __method__; end
  def test_check_016; mock __method__; end
  def test_check_017; mock __method__; end
  def test_check_018; mock __method__; end
  def test_check_019; mock __method__; end
  def test_check_020; mock __method__; end
  def test_check_021; mock __method__; end
  def test_check_022; mock __method__; end
  def test_check_023; mock __method__; end
  def test_check_024; mock __method__; end
  def test_check_025; mock __method__; end
  def test_check_026; mock __method__; end
  def test_check_027; mock __method__; end
  def test_check_028; mock __method__; end
  def test_check_029; mock __method__; end
  def test_check_030; mock __method__; end
  def test_check_031; mock __method__; end
  def test_check_032; mock __method__; end
  def test_check_033; mock __method__; end
  def test_check_034; mock __method__; end
  def test_check_035; mock __method__; end
  def test_check_036; mock __method__; end
  def test_check_037; mock __method__; end
  def test_check_038; mock __method__; end
  def test_check_039; mock __method__; end
  def test_check_040; mock __method__; end
  def test_check_041; mock __method__; end
  def test_check_042; mock __method__; end
  def test_check_043; mock __method__; end
  def test_check_044; mock __method__; end
  def test_check_045; mock __method__; end
  def test_check_046; mock __method__; end
  def test_check_047; mock __method__; end
  def test_check_048; mock __method__; end
  def test_check_049; mock __method__; end
end
