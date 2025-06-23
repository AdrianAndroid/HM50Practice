import Constants from '../../common/Constants';

/**
 * 窗口全屏布局方案
 */
@Entry
@Component
struct ImmersivePage {
  @State message: string = 'Hello World';
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;
  private scroller = new Scroller()

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Row()
          .width(Constants.FULL_PERCENT)
          .height(px2vp(this.topRectHeight))
          .backgroundColor(Color.Blue)
        Scroll(this.scroller) {
          Column() {
            Row() {
              Text('DEMO-ROW1').fontSize(40)
            }.backgroundColor(Color.Orange).padding(20)

            Row() {
              Text('DEMO-ROW2').fontSize(40)
            }.backgroundColor(Color.Orange).padding(20)

            Row() {
              Text('DEMO-ROW3').fontSize(40)
            }.backgroundColor(Color.Orange).padding(20)

            Row() {
              Text('DEMO-ROW4').fontSize(40)
            }.backgroundColor(Color.Orange).padding(20)

            Row() {
              Text('DEMO-ROW5').fontSize(40)
            }.backgroundColor(Color.Orange).padding(20)

            Row() {
              Text('DEMO-ROW6').fontSize(40)
            }.backgroundColor(Color.Orange).padding(20)

            Row() {
              Text('DEMO-ROW7').fontSize(40)
            }.backgroundColor(Color.Orange).padding(20)

            Row() {
              Text('DEMO-ROW8').fontSize(40)
            }.backgroundColor(Color.Orange).padding(20)

            Row() {
              Text('DEMO-ROW9').fontSize(40)
            }.backgroundColor(Color.Orange).padding(20)

            Row() {
              Text('DEMO-ROW10').fontSize(40)
            }.backgroundColor(Color.Orange).padding(20)

            Row() {
              Text('DEMO-ROW11').fontSize(40)
            }.backgroundColor(Color.Orange).padding(20)
          }
          // .alignItems(HorizontalAlign.Center)
          // .justifyContent(FlexAlign.SpaceBetween)
          .width(Constants.FULL_PERCENT)
          .backgroundColor('#008000')
        }
        .scrollable(ScrollDirection.Vertical)
        .width('100%')
        .height('100%')
        // top数值与状态栏区域高度保持一致；bottom数值与导航条区域高度保持一致
        .padding({ top: px2vp(this.topRectHeight), bottom: px2vp(this.bottomRectHeight) })
        .layoutWeight(1)

        Row()
          .width(Constants.FULL_PERCENT)
          .height(px2vp(this.bottomRectHeight))
          .backgroundColor(Color.Red)
      }
      .width(Constants.FULL_PERCENT)
      .height(Constants.FULL_PERCENT)
    }
    .width(Constants.FULL_PERCENT)
    .height(Constants.FULL_PERCENT)
  }
}