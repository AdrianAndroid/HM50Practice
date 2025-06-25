@Entry
@Component
struct CustomDialogExample2Page {
  @State message: string = '点击返回';

  build() {
    Column() {
      Button(this.message)
        .type(ButtonType.Capsule)
        .onClick(() => {
          this.getUIContext().getRouter().back({
            url: 'pages/Index',
            params: {
              info: 'Hello World'
            }
          });
        })
    }.width('100%').height('100%').margin({ top: 20 })
  }
}