@Entry
@Component
struct GSBindGesturePage {
  @State message: string = 'Hello World';

  build() {
    Column() {
      Blank().height(100)
      Text('gesture（常规手势绑定方法）')
      Column() {
        Text('Gesture').fontSize(28)
          .gesture(
            TapGesture()
              .onAction(() => {
                console.info('Text TapGesture is onAction');
              }))
      }
      .border({width: 3})
      .height(160)
      .width(250)
      // 设置为priorityGesture时，点击文本区域会忽略Text组件的TapGesture手势事件，优先响应父组件Column的TapGesture手势事件
      .priorityGesture(
        TapGesture()
          .onAction(() => {
            console.info('Column TapGesture is onAction');
          }), GestureMask.IgnoreInternal)

      Text('priorityGesture（带优先级的手势绑定方法）')
      Column() {
        Text('Gesture').fontSize(28)
          .gesture(
            TapGesture()
              .onAction(() => {
                console.info('Text TapGesture is onAction');
              }))
      }
      .height(160)
      .width(250)
      .border({width: 3})
      // 设置为priorityGesture时，点击文本区域会忽略Text组件的TapGesture手势事件，优先响应父组件Column的TapGesture手势事件
      .priorityGesture(
        TapGesture()
          .onAction(() => {
            console.info('Column TapGesture is onAction');
          }), GestureMask.IgnoreInternal)

      Text('parallelGesture（并行手势绑定方法）')
      Column() {
        Text('Gesture').fontSize(28)
          .gesture(
            TapGesture()
              .onAction(() => {
                console.info('Text TapGesture is onAction');
              }))
      }
      .height(160)
      .width(250)
      .border({width: 3})
      // 设置为parallelGesture时，点击文本区域会同时响应父组件Column和子组件Text的TapGesture手势事件
      .parallelGesture(
        TapGesture()
          .onAction(() => {
            console.info('Column TapGesture is onAction');
          }), GestureMask.Normal)

    }
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
    .height('100%')
    .width('100%')
  }
}