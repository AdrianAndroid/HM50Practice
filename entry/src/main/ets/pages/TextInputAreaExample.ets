import Constants from '../common/Constants';
import Logger from '../common/Logger';

@Entry
@Component
struct TextInputAreaExample {
  @State message: string = 'Hello World';
  placeHolderArr: string[] = ['1', '2', '3', '4', '5', '6', '7'];

  build() {
    Scroll() {
      Column() {
        TextInput({ placeholder: 'input your username' }).margin({ top: 20 })
          .onSubmit((EnterKeyType) => {
            console.info(EnterKeyType + '输入法回车键的类型值');
          })
        TextInput({ placeholder: 'input your password' }).type(InputType.Password).margin({ top: 20 })
          .onSubmit((EnterKeyType) => {
            console.info(EnterKeyType + '输入法回车键的类型值');
          })
        Button('Sign in').width(150).margin({ top: 20 })
        TextInput({text: '', placeholder: '我是提示文本'})
          .type(InputType.Normal)
          .backgroundColor(Color.Pink)
          .onChange((value: string) => {
            Logger.info('TextInputAreaExample', value)
          })
          .onFocus(() => {
            Logger.info('TextInputAreaExample', 'onFocus')
          })
        TextInput({text: 'InputType.Password'})
          .type(InputType.Password)
        TextInput({text: 'InputType.Number'})
          .type(InputType.Email)
        TextInput({text: 'InputType.Number'})
          .type(InputType.Number)
        TextInput({text: 'InputType.PhoneNumber'})
          .type(InputType.PhoneNumber)
        TextInput({text: 'InputType.NUMBER_DECIMAL'})
          .type(InputType.NUMBER_DECIMAL)
        TextInput({text: 'InputType.URL'})
          .type(InputType.URL)
        Line()
          .backgroundColor(Color.Green)
        TextArea()
        Line()
          .backgroundColor(Color.Green)
        TextArea({ text: "我是TextArea我是TextArea我是TextArea我是TextArea" })
          .width(300)
        // 键盘避让
        ForEach(this.placeHolderArr, (placeholder: string) => {
          TextInput({ placeholder: 'TextInput ' + placeholder })
            .margin(30)
        })
      }
    }
    .width(Constants.FULL_WIDTH)
    .height(Constants.FULL_HEIGHT)
  }
}