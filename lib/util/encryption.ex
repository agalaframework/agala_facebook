defmodule Agala.Provider.Facebook.Util.Encryption do
  @moduledoc false

  @doc """
  Validate sha1 signature for given binary
  """
  @spec validate_sha1(secret :: String.t(), body :: binary(), signature :: String.t()) :: :ok | {:error, Map.t()}
  def validate_sha1(secret, body, signature) do
    case signature == calculate_sha1(secret, body) do
      true -> :ok
      false -> {:error, %{signature: "invalid"}}
    end
  end

  @doc """
  Calculate sha256
  """
  @spec calculate_sha256(secret :: String.t(), body :: binary()) :: String.t()
  def calculate_sha256(secret, body) do
    calculate_sha(:sha256, secret, body)
  end

  defp calculate_sha1(secret, body) do
    calculate_sha(:sha, secret, body)
  end

  defp calculate_sha(alg, secret, body) do
    alg
    |> :crypto.hmac("#{secret}", "#{body}")
    |> Base.encode16()
    |> String.downcase()
  end
end
