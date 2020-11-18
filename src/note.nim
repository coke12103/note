import loader

when isMainModule:
  var account_info = load_account()
  echo account_info.host
