defmodule Reader do
  @moduledoc """
  Read data from file.
  """

  def read_data(day) do
    File.read!("#{File.cwd!()}/lib/data/#{day}.txt")
  end
end
