class Party
  attr_reader :name, :vote
  attr_accessor :seat_count

  def initialize(name, vote)
    @name = name
    @vote = vote
    @seat_count = 0
  end
  
end
