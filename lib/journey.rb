class Journey

  PENALTY_FARE = 6

  attr_reader :entry_station

  def initialize(entry_station)
    @entry_station = entry_station
  end

  def complete?

  end

  def fare
    PENALTY_FARE
  end

  def finish(exit_station)
    self
  end

  # def save_journey(exit_station)
  #   journey = {start: @entry_station, end: exit_station}
  #   @list_of_journeys << journey
  # end

end