class Oystercard

  attr_reader :balance, :entry_station, :list_of_journeys

  
  LIMIT = 90
  MIN_BALANCE = 1
  def initialize
    @balance = 0
    #@in_journey = false
    #@min_balance = 1
    @entry_station = nil
    @list_of_journeys = []
  end

  def top_up(amount)
    raise "this has exceeded the top up limit value of #{LIMIT}" if over_limit?(@balance, amount)
    @balance += amount
    @balance
  end

  def touchin(entry_station)
    raise "can not touch in balance below #{MIN_BALANCE}" if @balance < MIN_BALANCE
    #@in_journey = true
    @entry_station = entry_station
  end
  
  
  def touchout(exit_station)
    #@in_journey = false
    deduct(1)
    save_journey(exit_station)
    @balance
    @entry_station = nil 
  end

  def in_journey?
    if @entry_station == nil 
      return false
    else true    
    end
  end

  # def start_station
  #   @entry_station
  # end




  private

  def over_limit?(balance,amount)
    @balance + amount > LIMIT
  end

  def deduct(amount)
    @balance -= amount
    @balance
  end

  def save_journey(exit_station)
    journey = {start: @entry_station, end: exit_station}
    @list_of_journeys << journey
  end
end