@Entry()
@Component
struct StateV1Page {
  @State text: string = ''
  controller: TextInputController = new TextInputController()

  build() {
    Column({ space: 20 }) {
      Blank().height(500)
      Text(this.text)
      TextInput({ text: $$this.text, placeholder: 'input your word...', controller: this.controller })
        .placeholderColor(Color.Grey)
        .placeholderFont({ size: 14, weight: 400 })
        .caretColor(Color.Blue)
        .width(300)
    }.width('100%').height('100%').justifyContent(FlexAlign.Center)
  }
}