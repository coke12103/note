import json, nimSHA2, strformat, model/client_info_model

type ClientInfoParseError = object of JsonParsingError

proc load_account*(path: string): ClientInfo =
  try:
    var json_file = parseFile(path)
    if not (
      json_file.hasKey("host") and
      json_file.hasKey("secret") and
      json_file.hasKey("token")
    ): raise newException(ClientInfoParseError, "要件を満していません!")

    var client_info = ClientInfo(
      host: json_file["host"].getStr,
      secret: json_file["secret"].getStr,
      token: json_file["token"].getStr
    )

    client_info.api_token = computeSHA256(fmt"{client_info.token}{client_info.secret}").hex

    result = client_info
  except IOError:
    echo "ファイルが見付かりませんでした!"
  except JsonParsingError, ClientInfoParseError:
    echo "設定ファイルが壊れています!"
  except:
    echo repr(getCurrentException())
