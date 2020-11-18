import httpclient, json, strformat
import loader, model/client_info_model

var client_info: ClientInfo

proc init*(path = "./data/account.json") =
  client_info = load_account(path)

proc post_note*(text: string) =
  var client = newHttpClient()

  client.headers = newHttpHeaders({ "Content-Type": "application/json" })

  var body = %*{
    "i": client_info.api_token,
    "text": text
  }

  var res = client.request(fmt"https://{client_info.host}/api/notes/create", httpMethod = HttpPost, body = $body)
  echo res.status

