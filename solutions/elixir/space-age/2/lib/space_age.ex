defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet', or an error if 'planet' is not a planet.
  """
  @spec age_on(planet, pos_integer) :: {:ok, float} | {:error, String.t()}
  def age_on(planet, seconds) do
    years_on_earth = age_on_earth(seconds)
    case planet do
      :earth -> {:ok, years_on_earth}
      :mercury ->
        IO.inspect(years_on_earth)
        {:ok, years_on_earth / 0.2408467}
      :venus ->{:ok,  years_on_earth / 0.61519726}
      :mars -> {:ok, years_on_earth / 1.8808158}
      :jupiter -> {:ok, years_on_earth / 11.862615}
      :saturn -> {:ok, years_on_earth / 29.447498}
      :uranus -> {:ok, years_on_earth / 84.016846}
      :neptune -> {:ok, years_on_earth / 164.79132}
      _ -> {:error, "not a planet"}
    end
  end

  defp age_on_earth(seconds) do
    seconds / 31557600
  end
end
