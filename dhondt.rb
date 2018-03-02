# coding: utf-8
class DividedVoteArray
  attr_accessor :div_vote_array

  DividedVote = Struct.new(:num, :is_accepted)
  
  def initialize()
    @div_vote_array = []
  end

  # 得票数voteをdiv_numで割った商をDividedVoteとして@div_vote_arrayに格納
  # ※div_numはInteger型で入れる必要あり
  def push_divided_vote(vote, div_num)
    if div_num != 0 then
      # 商の小数点以下を残すためにvoteはDouble型に変換する
      divided_vote = vote.to_f/div_num
      @div_vote_array.push(DividedVote.new(divided_vote, false))
    else
      raise ZeroDivisionError.new()
    end
  end

  # @div_vote_array中のis_acceptedを解析し、獲得議席数をreturnする
  def count_seat()
    count = 0
    @div_vote_array.each do |vote|
      if vote.is_accepted == true then
        count = count + 1
      end
    end
    return count
  end
  
end

class Dhondt
  attr_accessor :vote_matrix

  # PartyとDividedVoteArrayを格納するクラス変数
  PartyVoteArray = Struct.new(:party, :matrix)
  @@party_vote_matrix = []

  #------------------------------------------------------------------------
  # count_seat(): ドント方式に基づき、各政党の議席を計算するメソッド
  # <input>
  # - party_array: Partyクラスの配列
  # - capacity: 議席定数
  # <output>
  # - Partyクラスのseat_countに獲得議席数を格納
  #------------------------------------------------------------------------
  def self.count_seat(party_array, capacity)
    # 各政党の得票数を1〜(議員定数)でそれぞれ割り算し、結果を@@party_vote_matrixに格納
    divide_vote(party_array, capacity)
    # @@party_vote_matrixを解析し、各政党の議席を計算
    calculate_seat(party_array, capacity)
  end
  
  # 各政党の得票数を1〜(議員定数)でそれぞれ割り算し、結果を@@party_vote_matrixに格納
  def self.divide_vote(party_array, capacity)
    party_array.each do |party|
      div_num = 1
      vote_array = DividedVoteArray.new()

      capacity.times do
        vote_array.push_divided_vote(party.vote, div_num)
        div_num = div_num + 1
      end

      @@party_vote_matrix.push(PartyVoteArray.new(party, vote_array))
    end
  end

  # @@party_vote_matrixを解析し、各政党の議席を計算
  def self.calculate_seat(party_array, capacity)
    # DividedVoteを得票数に応じて降順ソート
    # (calc_array: ソート前, sorted_calc_array: ソート後)
    calc_array = []
    @@party_vote_matrix.each do |vote_array|
      vote_array.matrix.div_vote_array.each do |hash|
        calc_array.push(hash)
      end
    end
    sorted_calc_array = calc_array.sort{|aa, bb|
      bb.num <=> aa.num # 降順ソート
    }

    # 議席定数に基づき、上位得票数の当選フラグis_acceptedをtrueに変更
    for index in 0..(capacity - 1) do
      sorted_calc_array[index].is_accepted = true
    end

    # is_acceptedフラグのtrue数を計算し、Partyクラスのseat_countを更新
    @@party_vote_matrix.each do |vote_array|
      vote_array.party.seat_count = vote_array.matrix.count_seat()
    end
  end

end
