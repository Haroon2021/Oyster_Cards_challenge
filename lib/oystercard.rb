class Oystercard

  attr_reader :balance

  def initialize
    @balance = 0
    @limit = 90
    @in_journey = false
    @min_balance = 1
  end

  def top_up(amount)
    raise "this has exceeded the top up limit value of #{@limit}" if over_limit?(@balance, amount)
    @balance += amount
    @balance
  end



  def touchin
    raise "can not touch in balance below min balance" if @balance < @min_balance
    @in_journey = true
  end
  
  def touchout
    @in_journey = false
    deduct(1)
    @balance
  end

  def in_journey?
    @in_journey
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