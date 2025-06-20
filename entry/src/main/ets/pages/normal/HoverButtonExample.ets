import Constants from '../../common/Constants'

// xxx.ets
@Entry
@Component
struct HoverButtonExample {
  private arr: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
  build() {
    Stack() {
      List({ space: 20, initialIndex: 0 }) {
        ForEach(this.arr, (item:number) => {
          ListItem() {
            Text('' + item)
              .width('100%').height(100).fontSize(16)
              .textAlign(TextAlign.Center).borderRadius(10).backgroundColor(0xFFFFFF)
          }
        }, (item:number) => item.toString())
      }.width('90%')
      .height(Constants.FULL_HEIGHT)
      Button() {
        Image($r('app.media.ic_public_add'))
          .width(50)
          .height(50)
      }
      .width(60)
      .height(60)
      .position({x: '80%', y: 600})
      .shadow({radius: 10})
      .onClick(() => {
        // 需要执行的操作
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(0xDCDCDC)
    .padding({ top: 5 })
  }
}