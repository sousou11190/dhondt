# coding: utf-8
require 'test/unit'
require "../" + File.dirname(__FILE__) + "/dhondt"
require "../" + File.dirname(__FILE__) + "/party"

class PartyTest < Test::Unit::TestCase

  sub_test_case "Partyオブジェクトは政党名と得票数を格納できる" do
    def setup
      @party = Party.new(name="テスト政党", vote=200)
    end
    def test_Partyオブジェクトは政党名と得票数を格納
      assert_equal("テスト政党", @party.name)
      assert_equal(200, @party.vote)
    end
    def test_読み取り専用変数へのアクセスを禁止
      assert_raise(NoMethodError){ @party.name = "hoge" }
      assert_raise(NoMethodError){ @party.vote = 20 }
    end
  end

  sub_test_case "Partyオブジェクトの議席数" do
    def setup
      @party = Party.new(name="テスト政党", vote=200)
    end
    def test_Partyオブジェクトのseat_count初期値は0
      assert_equal(0, @party.seat_count)      
    end
    def test_Partyオブジェクトのseat_countはset_seat_countメソッドで設定
      @party.set_seat_count(10)
      assert_equal(10, @party.seat_count)
    end
  end 

end
