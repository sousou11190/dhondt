class Party
  attr_reader :name, :vote, :seat_count

  def initialize(name, vote)
    @name = name
    @vote = vote
    @seat_count = 0
  end

  def set_seat_count(count)
    @seat_count = count
  end
  
end
