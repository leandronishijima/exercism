class AssemblyLine
  def initialize(speed)
    @speed = speed
  end

  def production_rate_per_hour
    rate_per_hour = @speed * 221
    rate_per_hour.to_f * success_rate
  end

  def working_items_per_minute
    cars_per_minute = production_rate_per_hour / 60
    cars_per_minute.floor
  end

  private

  def success_rate
    if @speed <= 4
      1.0
    elsif @speed >= 5 && @speed <= 8
      0.9
    elsif @speed == 9
      0.8
    else
      0.77
    end
  end
end
