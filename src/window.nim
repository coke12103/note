import nigui, client

proc init*() =
  app.init()
  client.init()

  var window = newWindow("Hello!")

  window.width = 260.scaleToDpi
  window.height = 100.scaleToDpi

  var layout = newLayoutContainer(Layout_Vertical)
  layout.padding = 6
  window.add(layout)

  var buttons = newLayoutContainer(Layout_Horizontal)
  layout.padding = 6

  var text_area = newTextArea()
  var post_button = newButton("ぽすと!")
  var clear_button = newButton("くりあ!")
  layout.add(text_area)
  layout.add(buttons)

  buttons.add(post_button)
  buttons.add(clear_button)

  text_area.addLine("押すとなんか投稿されるよ")

  post_button.onClick = proc(event: ClickEvent) =
    if(text_area.text.len < 0): return
    post_note(text_area.text)
    text_area.text = ""

  clear_button.onClick = proc(event: ClickEvent) =
    text_area.text = ""

  window.show()

  app.run()
