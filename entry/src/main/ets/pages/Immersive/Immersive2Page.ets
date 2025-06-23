
/**
 * 应用扩展布局，隐藏避让区
 */
@Entry
@Component
struct Immersive2Page {
  build() {
    Row() {
      Column() {
        Row() {
          Text('ROW1').fontSize(40)
        }.backgroundColor(Color.Orange).padding(20)


        Row() {
          Text('ROW2').fontSize(40)
        }.backgroundColor(Color.Orange).padding(20)


        Row() {
          Text('ROW3').fontSize(40)
        }.backgroundColor(Color.Orange).padding(20)


        Row() {
          Text('ROW4').fontSize(40)
        }.backgroundColor(Color.Orange).padding(20)


        Row() {
          Text('ROW5').fontSize(40)
        }.backgroundColor(Color.Orange).padding(20)


        Row() {
          Text('ROW6').fontSize(40)
        }.backgroundColor(Color.Orange).padding(20)
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
      .backgroundColor('#008000')
    }
  }
}