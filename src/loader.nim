import json

type ClientInfo* = ref object
  host*: string
  secret*: string
  token*: string

proc load_account*(path = "./data/account.json"): ClientInfo =
  try:
    result = to(parseFile(path), ClientInfo)
  except IOError:
    echo "ファイルが見付かりませんでした!"
  except JsonParsingError, KeyError:
    echo "設定ファイルが壊れています!"
  except:
    echo repr(getCurrentException())
