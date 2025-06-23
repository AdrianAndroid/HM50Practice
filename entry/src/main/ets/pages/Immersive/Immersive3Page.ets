@Entry
@Component
struct Immersive3Page {
  build() {
    Column() {
      Row() {
        Text('Top Row').fontSize(40).textAlign(TextAlign.Center).width('100%')
      }
      .backgroundColor('#F08080')
      // 设置顶部绘制延伸到状态栏
      // .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])

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
        Text('Bottom Row').fontSize(40).textAlign(TextAlign.Center).width('100%')
      }
      .backgroundColor(Color.Orange)
      // 设置底部绘制延伸到导航条
      // .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#008000')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}