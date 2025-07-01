import { promptAction } from '@kit.ArkUI';


/**
 * 手势拦截
 */
@Entry
@Component
struct GestureJudgeResultPage {
  @State message: string = 'Hello World';
  scroller: Scroller = new Scroller();

  build() {
    Scroll(this.scroller) {
      Column({ space: 8 }) {
        Blank().height(50)
        Text("包括上下两层组件，上层组件绑定长按手势，下层组件绑定拖拽。其中上层组件下半区域绑定手势拦截，使该区域响应下层拖拽手势。")
          .width('100%')
          .fontSize(20)
          .fontColor('0xffdd00')
        Stack({ alignContent: Alignment.Center }) {

          Column() {
            // 模拟上半区和下半区
            Stack().width('200vp').height('100vp').backgroundColor(Color.Red)
            Stack().width('200vp').height('100vp').backgroundColor(Color.Blue)
          }.width('200vp').height('200vp').border({ width: 1, color: Color.Red })

          // Stack的下半区是绑定了拖动手势的图像区域。
          Image($r('sys.media.ohos_app_icon'))
            .draggable(true)
            .onDragStart(() => {
              promptAction.showToast({ message: "Drag 下半区蓝色区域，Image响应" });
            })
            .width('200vp').height('200vp')

          // Stack的上半区是绑定了长按手势的浮动区域。
          Stack() {
          }
          .width('200vp')
          .height('200vp')
          .border({ width: 1, color: Color.Green })
          .hitTestBehavior(HitTestMode.Transparent)
          .gesture(GestureGroup(GestureMode.Parallel, LongPressGesture()
            .onAction((event: GestureEvent) => {
              promptAction.showToast({ message: "LongPressGesture 长按上半区 红色区域，红色区域响应" });
            })
            .tag("longpress")
          ))
          .onGestureJudgeBegin((gestureInfo: GestureInfo, event: BaseGestureEvent) => {
            // 如果是长按类型手势，判断点击的位置是否在上半区
            if (gestureInfo.type == GestureControl.GestureType.LONG_PRESS_GESTURE) {
              if (event.fingerList.length > 0 && event.fingerList[0].localY < 100) {
                return GestureJudgeResult.CONTINUE;
              } else {
                return GestureJudgeResult.REJECT;
              }
            }
            return GestureJudgeResult.CONTINUE;
          })
        }.width('100%')
      }
      .width('100%')
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    }
  }

  @Builder
  exampleGestureJudgeResult() {

  }
}