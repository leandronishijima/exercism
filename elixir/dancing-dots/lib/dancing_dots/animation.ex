defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(opts :: opts()) :: {:ok, opts :: opts()} | {:error, error :: error()}
  @callback handle_frame(dot :: dot(), frame_number :: frame_number(), opts :: opts()) :: dot()

  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation

      def init(opts), do: {:ok, opts}
      defoverridable init: 1
    end
  end
end

defmodule DancingDots.Flicker do
  use DancingDots.Animation

  def handle_frame(dot, frame_number, _opts) do
    if rem(frame_number, 4) == 0 do
      %{dot | opacity: dot.opacity / 2}
    else
      dot
    end
  end
end

defmodule DancingDots.Zoom do
  use DancingDots.Animation

  def init(velocity: velocity) when is_number(velocity) do
    {:ok, [velocity: velocity]}
  end

  def init(opts) do
    value = Keyword.get(opts, :velocity)

    {:error,
     "The :velocity option is required, and its value must be a number. Got: #{inspect(value)}"}
  end

  def handle_frame(dot, 1, _opts), do: dot

  def handle_frame(dot, frame_number, velocity: velocity) do
    calculated_frame = frame_number - 1
    %{dot | radius: dot.radius + calculated_frame * velocity}
  end
end
