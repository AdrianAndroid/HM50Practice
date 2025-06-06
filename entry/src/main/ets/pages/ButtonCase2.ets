// xxx.ets
@Entry
@Component
struct ButtonCase2 {
  build() {
    Column() {
      TextInput({ placeholder: 'input your username' }).margin({ top: 20 })
      TextInput({ placeholder: 'input your password' }).type(InputType.Password).margin({ top: 20 })
      Button('Register').width(300).margin({ top: 20 })
        .onClick(() => {
          // 需要执行的操作
        })
    }.padding(20)
  }
}