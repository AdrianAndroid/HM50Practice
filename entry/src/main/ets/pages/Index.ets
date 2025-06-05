import { router } from '@kit.ArkUI'
import { BusinessError } from '@kit.BasicServicesKit'

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        Button(){
          Text('Next')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
        }
        .type(ButtonType.Capsule)
        .margin({top:20})
        .backgroundColor('#0D9FFB')
        .width('40%')
        .height('5%')
        .onClick(() => {
          console.info(`Succeeded in clicking the 'Next' button.`)
          router.pushUrl({url: 'pages/Second'})
            .then(() => {
              console.info('Successed in jumping to the second page.')
            })
            .catch((err: BusinessError) => {
              console.error(`Failed to jump to the seoncd page. Code is ${err.code}, message is ${err.message}`)
            })
        })
      }
    }
    .width('100%')
    .height('100%')
  }
}