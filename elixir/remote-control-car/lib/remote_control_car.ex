defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  def new(), do: %__MODULE__{nickname: "none"}

  def new(nickname), do: %__MODULE__{nickname: nickname}

  def display_distance(%__MODULE__{distance_driven_in_meters: distance}),
    do: "#{distance} meters"

  def display_battery(%__MODULE__{battery_percentage: 0}),
    do: "Battery empty"

  def display_battery(%__MODULE__{battery_percentage: battery_percentage}),
    do: "Battery at #{battery_percentage}%"

  def drive(%__MODULE__{battery_percentage: 0} = car), do: car

  def drive(%__MODULE__{} = car) do
    car
    |> update_meters_driven()
    |> drain_battery()
  end

  defp drain_battery(%__MODULE__{battery_percentage: battery} = car),
    do: %{car | battery_percentage: battery - 1}

  defp update_meters_driven(%__MODULE__{distance_driven_in_meters: distance} = car),
    do: %{car | distance_driven_in_meters: distance + 20}
end
