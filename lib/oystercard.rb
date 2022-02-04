class Oystercard

  attr_reader :balance, :start_station, :list_of_journeys

  
  LIMIT = 90
  MIN_BALANCE = 1
  def initialize
    @balance = 0
    @limit = 90
    #@in_journey = false
    #@min_balance = 1
    @start_station = nil
    @list_of_journeys = []
  end

  def top_up(amount)
    raise "this has exceeded the top up limit value of #{@limit}" if over_limit?(@balance, amount)
    @balance += amount
    @balance
  end

  def touchin(station)
    raise "can not touch in balance below #{MIN_BALANCE}" if @balance < MIN_BALANCE
    #@in_journey = true
    @start_station = station
    
  end
  
  
  def touchout(station)
    #@in_journey = false
    deduct(1)
    @balance
    @start_station = nil 
  end

  def in_journey?
    if @start_station == nil 
      return false
    else true    
    end
  end

  def start_station
    @start_station
  end




  private

  def over_limit?(balance,amount)
    @balance + amount > @limit
  end

  def deduct(amount)
    @balance -= amount
    @balance
  end

end