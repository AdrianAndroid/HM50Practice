import { PromptAction, promptAction } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct ToastExamplePage {
  @State message: string = 'Hello World';
  private uiContext: UIContext = this.getUIContext()
  private promptAction: PromptAction = this.uiContext.getPromptAction()

  build() {
    Column({ space: 10 }) {
      // 即时反馈模式对比
      TextInput()
      Button() {
        Text("DEFAULT类型Toast")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)

      }
      .width('100%')
      .onClick(() => {
        promptAction.showToast({
          message: "ok，我是DEFAULT toast",
          duration: 2000,
          showMode: promptAction.ToastShowMode.DEFAULT,
          bottom: 80
        })
      })

      Button() {
        Text("TOPMOST类型Toast")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)

      }
      .width('100%')
      .onClick(() => {
        promptAction.showToast({
          message: "ok，我是TOP_MOST toast",
          duration: 2000,
          showMode: promptAction.ToastShowMode.TOP_MOST,
          bottom: 85
        })
      })

      // 创建即时反馈
      Button('Show toast').fontSize(20)
        .onClick(() => {
          try {
            this.promptAction.showToast({
              message: 'Hello World',
              duration: 2000
            });
          } catch (error) {
            let message = (error as BusinessError).message
            let code = (error as BusinessError).code
            console.error(`showToast args error code is ${code}, message is ${message}`);
          }
          ;
        })
    }
    .height('100%')
    .width('100%')
  }
}