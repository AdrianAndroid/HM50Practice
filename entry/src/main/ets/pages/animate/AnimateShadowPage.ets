@Entry
@Component
struct AnimateShadowPage {
  @State message: string = 'Hello World';

  build() {
    Stack() {
      Row() {
        Column() {
          Column() {
            Text('shadowOption').fontSize(12)
          }
          .width(100)
          .aspectRatio(1)
          .margin(10)
          .justifyContent(FlexAlign.Center)
          .backgroundColor(Color.White)
          .borderRadius(20)
          .shadow({ radius: 10, color: Color.Gray })

          Column() {
            Text('shadowOption').fontSize(12)
          }
          .width(100)
          .aspectRatio(1)
          .margin(10)
          .justifyContent(FlexAlign.Center)
          .backgroundColor('#a8a888')
          .borderRadius(20)
          .shadow({
            radius: 10,
            color: Color.Gray,
            offsetX: 20,
            offsetY: 20
          })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
      }
      .height('100%')
    }
    .height('100%')
    .width('100%')
  }
}