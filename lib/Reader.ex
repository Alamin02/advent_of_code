defmodule Reader do
  @moduledoc """
  Read data from file.
  """

  @spec read_data(any) :: binary
  def read_data(day) do
    File.read!("#{File.cwd!()}/lib/data/#{day}.txt")
  end
end
