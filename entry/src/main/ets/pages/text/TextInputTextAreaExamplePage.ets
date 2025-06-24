import Constants from '../../common/Constants';

@Entry
@Component
struct TextInputTextAreaExamplePage {
  @State message: string = 'Hello World';
  private placeHolderArr: string[] = ['1', '2', '3', '4', '5', '6', '7'];

  build() {
    Scroll() {
      Column({ space: 10 }) {
        // 单行输入框
        TextInput()

        // 多行输入框
        TextArea()

        // 多行输入框文字超出一行时会自动折行。
        TextArea({ text: "我是TextArea我是TextArea我是TextArea我是TextArea" }).width(300)

        // 基本输入模式（默认类型）
        TextInput({ text: 'teststst' })
          .type(InputType.Normal)

        // 密码输入模式
        TextInput({ text: 'dsfasdfasdf' })
          .type(InputType.Password)

        // 邮箱地址输入模式
        TextInput({ text: '124234@163.com' })
          .type(InputType.Email)

        // 纯数字输入模式
        TextInput({ text: '12342143' })
          .type(InputType.Number)

        // 电话号码输入模式
        TextInput({ text: '1341234123421343' })
          .type(InputType.PhoneNumber)

        // 带小数点的数字输入模式
        TextInput({ text: '1113.33' })
          .type(InputType.NUMBER_DECIMAL)

        // 带URL的输入模式
        TextInput({ text: 'https://www.baidu.com' })
          .type(InputType.URL)

        // 自定义样式
        // 设置无输入时的提示文本。
        TextInput({ placeholder: '我是提示文本' })

        // 设置输入框当前的文本内容。
        TextInput({ placeholder: '我是提示文本', text: '我是当前文本内容' })

        // 添加backgroundColor改变输入框的背景颜色。
        TextInput({ placeholder: '我是提示文本', text: '我是当前文本内容' })
          .backgroundColor(Color.Pink)

        // 添加事件
        TextInput({ text: '添加事件' })
          .onChange((value: string) => {
            console.info(value);
          })
          .onFocus(() => {
            console.info('获取焦点');
          })

        // 场景示例
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
        }.padding(20)

        // 键盘避让
        Column() {
          ForEach(this.placeHolderArr, (placeholder: string) => {
            TextInput({ placeholder: 'TextInput ' + placeholder })
              .margin(30)
          })
        }
      }
      .width(Constants.FULL_PERCENT)
    }
    .padding({ left: $r('sys.float.margin_left'), right: $r('sys.float.margin_right') })
    .align(Alignment.Top)
    .height('100%')
    .width('100%')
  }
}