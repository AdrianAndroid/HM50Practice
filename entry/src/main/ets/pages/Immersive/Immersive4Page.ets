import Constants from '../../common/Constants';

@Entry
@Component
struct Immersive4Page {
  @State message: string = 'Hello World';
  private arr: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

  build() {
    Stack() {
      this.example1()
    }
    .height('100%').width('100%')
  }

  @Builder
  example2() {
    Column() {
      List({initialIndex: 0 }) {
        ForEach(this.arr, (item: number) => {
          ListItem() {
            Text('' + item)
              .width('100%')
              .height(100)
              .fontSize(16)
              .textAlign(TextAlign.Center)
              .borderRadius(10)
              .backgroundColor(0xFFFFFF)
          }
        }, (item: number) => item.toString())
      }
      .listDirection(Axis.Vertical) // 排列方向
      .scrollBar(BarState.Off)
      // .friction(0.6)
      .divider({
        strokeWidth: 2,
        color: 0xFFFFFF,
        startMargin: 20,
        endMargin: 20
      }) // 每行之间的分界线
      .edgeEffect(EdgeEffect.Spring) // 边缘效果设置为Spring
      .width('90%')
      .height(Constants.FULL_PERCENT)
      // List组件的视窗范围扩展至导航条。
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    }
    .width('100%')
    .height('100%')
    //.padding({ top: 15 })
  }

  @Builder
  example1() {
    Stack() {
      Image($r('app.media.img_0'))
        .height('100%').width('100%')
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM]) // 图片组件的绘制区域扩展至状态栏和导航条。
    }.height('100%').width('100%')
    .height('100%')
    .width('100%')
  }
}