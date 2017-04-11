defmodule PhoenixCowboyRemoveServerHeader do
  def enable_for(otp_app, endpoint) do
    new_config =
      Application.get_env(otp_app, endpoint)
      |> maybe_add_on_response(:http)
      |> maybe_add_on_response(:https)

    Application.put_env(otp_app, endpoint, new_config)
  end

  defp maybe_add_on_response(config, proto) do
    with true <- Keyword.has_key?(config, proto),
         {_, config} <- put_default_in(config, [proto, :protocol_options], [])
      do

      replace_onresponse(config, proto)

      else
        _ -> config
    end
  end

  defp put_default_in(container, keys, default_val) do
    Kernel.get_and_update_in(container, keys, fn val ->
      if val == nil do
        {default_val, default_val}
      else
        {val, val}
      end
    end)
  end

  defp replace_onresponse(config, proto) do
    if is_function(Kernel.get_in(config, [proto, :protocol_options, :onresponse])) do
      Kernel.put_in(config,
        [proto, :protocol_options, :onresponse],
        fn (status_code, headers, body, req) ->
          removed_headers = remove_server_header(headers)
          Kernel.get_in(config, [proto, :protocol_options, :onresponse]).(status_code, removed_headers, body, req)
        end)
    else
        Kernel.put_in(config,
          [proto, :protocol_options, :onresponse],
          &__MODULE__.removed_server_header_req/4)
    end
  end

  defp remove_server_header(headers) do
    Enum.filter(headers, fn {k, _v} -> k != "server" end)
  end

  def removed_server_header_req(status_code, headers, body, req) do
    headers = remove_server_header(headers)
    {:ok, req} = :cowboy_req.reply(status_code, headers, body, req)
    req
  end
end
