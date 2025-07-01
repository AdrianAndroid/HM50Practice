@Entry
@Component
struct GSGroupGesturePage {
  @State offsetX: number = 0;
  @State offsetY: number = 0;
  @State count: number = 0;
  @State positionX: number = 0;
  @State positionY: number = 0;
  @State borderStyles: BorderStyle = BorderStyle.Solid

  @State count1: number = 0;
  @State count2: number = 0;

  @State count3: number = 0;
  @State count4: number = 0;

  build() {
    Column() {
      Text('顺序识别')
      Column() {
        Text('sequence gesture\n' + 'LongPress onAction:' + this.count + '\nPanGesture offset:\nX: ' + this.offsetX + '\n' + 'Y: ' + this.offsetY)
          .fontSize(28)
      }
      .margin(10)
      .borderWidth(1)
      // 绑定translate属性可以实现组件的位置移动
      .translate({ x: this.offsetX, y: this.offsetY, z: 0 })
      .height(250)
      .width(300)
      //以下组合手势为顺序识别，当长按手势事件未正常触发时不会触发拖动手势事件
      .gesture(
        // 声明该组合手势的类型为Sequence类型
        GestureGroup(GestureMode.Sequence,
          // 该组合手势第一个触发的手势为长按手势，且长按手势可多次响应
          LongPressGesture({ repeat: true })// 当长按手势识别成功，增加Text组件上显示的count次数
            .onAction((event: GestureEvent | undefined) => {
              if (event) {
                if (event.repeat) {
                  this.count++;
                }
              }
              console.info('LongPress onAction');
            })
            .onActionEnd(() => {
              console.info('LongPress end');
            }),
          // 当长按之后进行拖动，PanGesture手势被触发
          PanGesture()
            .onActionStart(() => {
              this.borderStyles = BorderStyle.Dashed;
              console.info('pan start');
            })// 当该手势被触发时，根据回调获得拖动的距离，修改该组件的位移距离从而实现组件的移动
            .onActionUpdate((event: GestureEvent | undefined) => {
              if (event) {
                this.offsetX = (this.positionX + event.offsetX);
                this.offsetY = this.positionY + event.offsetY;
              }
              console.info('pan update');
            })
            .onActionEnd(() => {
              this.positionX = this.offsetX;
              this.positionY = this.offsetY;
              this.borderStyles = BorderStyle.Solid;
            })
        )
          .onCancel(() => {
            console.log("sequence gesture canceled")
          })
      )

      Text('并行识别')
      Column() {
        Text('Parallel gesture\n' + 'tapGesture count is 1:' + this.count3 + '\ntapGesture count is 2:' + this.count4 + '\n')
          .fontSize(28)
      }
      .borderWidth(1)
      .height(200)
      .width('100%')
      // 以下组合手势为并行并别，单击手势识别成功后，若在规定时间内再次点击，双击手势也会识别成功
      .gesture(
        GestureGroup(GestureMode.Parallel,
          TapGesture({ count: 1 })
            .onAction(() => {
              this.count3++;
            }),
          TapGesture({ count: 2 })
            .onAction(() => {
              this.count4++;
            })
        )
      )

      Text('互斥识别')
      Column() {
        Text('Exclusive gesture\n' + 'tapGesture count is 1:' + this.count1 + '\ntapGesture count is 2:' + this.count2 + '\n')
          .fontSize(28)
      }
      .height(200)
      .width('100%')
      .borderWidth(1)
      //以下组合手势为互斥并别，单击手势识别成功后，双击手势会识别失败
      .gesture(
        GestureGroup(GestureMode.Exclusive,
          TapGesture({ count: 1 })
            .onAction(() => {
              this.count1++;
            }),
          TapGesture({ count: 2 })
            .onAction(() => {
              this.count2++;
            })
        )
      )

    }
    .height('100%')
    .width('100%')
  }
}