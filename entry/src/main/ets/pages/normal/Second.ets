import { router } from '@kit.ArkUI'
import { BusinessError } from '@kit.BasicServicesKit'


@Entry
@Component
struct Second {
  @State message: string = 'hi there';

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        Button() {
          Text('Back')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
        }
        .type(ButtonType.Capsule)
        .margin({top: 20})
        .backgroundColor('#0D9FFB')
        .width('40%')
        .height('5%')
        .onClick(() => {
          console.info(`Succeeded in clicking the 'Back' button.`)
          try {
            router.back()
            console.info('Succeeded in returning to the first page.')
          } catch (err) {
            let code = (err as BusinessError).code
            let message = (err as BusinessError).message
            console.error(`Failed to return to the first page. Code is ${code}, message is ${message}`)
          }
        })
      }
      .width('100%')
      .height('100%')
    }
  }
}