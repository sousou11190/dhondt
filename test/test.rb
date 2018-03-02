# coding: utf-8
require 'test/unit'
require "../" + File.dirname(__FILE__) + "/dhondt"
require "../" + File.dirname(__FILE__) + "/party"

class TestDhondt < Test::Unit::TestCase

  def setup
  end

  def test_party
    # initialize
    party = Party.new("テスト政党", 200)
    assert_equal("テスト政党", party.name)
    assert_equal(0, party.seat_count)
    assert_equal(200, party.vote)

    # initialize
    party.seat_count = 10
    assert_equal(10, party.seat_count)

    # 読み取り専用変数へのアクセスを禁止
    assert_raise(NoMethodError){party.name = "hoge"}
    assert_raise(NoMethodError){party.vote = 20}
    
  end
  
  DividedVote = Struct.new(:num, :is_accepted)
  def test_divided_vote_array
    # DividedVoteのインスタンス作成
    vote = DividedVote.new(100, false)
    assert_equal(100, vote.num)
    assert_equal(false, vote.is_accepted)

    # DividedVoteのis_accepted書き換え
    vote.is_accepted = true
    assert_equal(true, vote.is_accepted)

    # DividedVoteArrayのインスタンス作成
    vote_array = DividedVoteArray.new()

    # DividedVoteArrayに除算済得票数を格納&is_acceptedがfalse
    vote_array.push_divided_vote(100, 1)
    assert_equal(100.0/1.0, vote_array.div_vote_array[0].num)
    assert_equal(false,     vote_array.div_vote_array[0].is_accepted)
    
    vote_array.push_divided_vote(100, 2)
    assert_equal(100.0/2.0, vote_array.div_vote_array[1].num)
    assert_equal(false,     vote_array.div_vote_array[1].is_accepted)
    
    vote_array.push_divided_vote(100, 3)
    assert_equal(100.0/3.0, vote_array.div_vote_array[2].num)
    assert_equal(false,     vote_array.div_vote_array[2].is_accepted)

    # 0除算例外
    assert_raise(ZeroDivisionError) {vote_array.push_divided_vote(100, 0)}
    assert_raise(ZeroDivisionError) {vote_array.push_divided_vote(100, 0.0)}

    # vote_array要素数の確認
    assert_equal(3, vote_array.div_vote_array.size)

    # 当選議席数のテスト
    assert_equal(0, vote_array.count_seat())

    # 当選議席数のテスト
    vote_array.div_vote_array[0].is_accepted = true
    assert_equal(1, vote_array.count_seat())

    # 当選議席数のテスト
    vote_array.div_vote_array[1].is_accepted = true
    assert_equal(2, vote_array.count_seat())
    
  end

  PartyVoteArray = Struct.new(:party, :matrix)
  def test_party_vote_array

    party = Party.new("テスト政党", 200)
    vote_array = DividedVoteArray.new()
    vote_array.push_divided_vote(party.vote, 1)
    vote_array.push_divided_vote(party.vote, 2)
    vote_array.push_divided_vote(party.vote, 3)
    #p PartyVoteArray.new(party, vote_array)
     
  end
  

  def test_dhondt
    
    
  end

end
