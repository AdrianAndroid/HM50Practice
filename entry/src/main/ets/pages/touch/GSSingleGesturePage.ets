@Entry
@Component
struct GSSingleGesturePage {
  @State message: string = 'Hello World';
  @State value: string = "";
  @State count: number = 0;

  @State offsetX: number = 0;
  @State offsetY: number = 0;
  @State positionX: number = 0;
  @State positionY: number = 0;

  @State scaleValue: number = 1;
  @State pinchValue: number = 1;
  @State pinchX: number = 0;
  @State pinchY: number = 0;


  @State angle: number = 0;
  @State rotateValue: number = 0;


  @State rotateAngle: number = 0;
  @State speed: number = 1;

  @State enableScroll: boolean = true
  build() {
    Scroll() {
      Column() {
        Text('点击手势（TapGesture）')
        Column() {
          Text('Click twice').fontSize(28)
            .gesture(
              // 绑定count为2的TapGesture
              TapGesture({ count: 2 })
                .onAction((event: GestureEvent|undefined) => {
                  if(event){
                    this.value = JSON.stringify(event.fingerList[0]);
                  }
                }))
          Text(this.value)
        }
        .height(200)
        .width(250)
        .padding(20)
        .border({ width: 3 })

        Text('长按手势（LongPressGesture）')
        Column() {
          Text('LongPress OnAction:' + this.count).fontSize(28)
            .gesture(
              // 绑定可以重复触发的LongPressGesture
              LongPressGesture({ repeat: true })
                .onAction((event: GestureEvent|undefined) => {
                  if(event){
                    if (event.repeat) {
                      this.count++;
                    }
                  }
                })
                .onActionEnd(() => {
                  this.count = 0;
                })
            )
        }
        .height(200)
        .width(250)
        .padding(20)
        .border({ width: 3 })

        Text('拖动手势（PanGesture）')
        Column() {
          Text('PanGesture Offset:\nX: ' + this.offsetX + '\n' + 'Y: ' + this.offsetY)
            .fontSize(28)
            .height(200)
            .width(300)
            .padding(20)
            .border({ width: 3 })
              // 在组件上绑定布局位置信息
            .translate({ x: this.offsetX, y: this.offsetY, z: 0 })
            .gesture(
              // 绑定拖动手势
              PanGesture()
                .onActionStart((event: GestureEvent|undefined) => {
                  console.info('Pan start');
                })
                  // 当触发拖动手势时，根据回调函数修改组件的布局位置信息
                .onActionUpdate((event: GestureEvent|undefined) => {
                  if(event){
                    this.offsetX = this.positionX + event.offsetX;
                    this.offsetY = this.positionY + event.offsetY;
                  }
                })
                .onActionEnd(() => {
                  this.positionX = this.offsetX;
                  this.positionY = this.offsetY;
                })
            )
        }
        .border({width: 3})
        .height(200)
        .width(250)

        Text('捏合手势（PinchGesture）')
        Column() {
          Text('PinchGesture scale:\n' + this.scaleValue)
          Text('PinchGesture center:\n(' + this.pinchX + ',' + this.pinchY + ')')
        }
        .height(200)
        .width(300)
        .border({ width: 3 })
        // 在组件上绑定缩放比例，可以通过修改缩放比例来实现组件的缩小或者放大
        .scale({ x: this.scaleValue, y: this.scaleValue, z: 1 })
        .gesture(
          // 在组件上绑定三指触发的捏合手势
          PinchGesture({ fingers: 3 })
            .onActionStart((event: GestureEvent|undefined) => {
              console.info('Pinch start');
            })
              // 当捏合手势触发时，可以通过回调函数获取缩放比例，从而修改组件的缩放比例
            .onActionUpdate((event: GestureEvent|undefined) => {
              if(event){
                this.scaleValue = this.pinchValue * event.scale;
                this.pinchX = event.pinchCenterX;
                this.pinchY = event.pinchCenterY;
              }
            })
            .onActionEnd(() => {
              this.pinchValue = this.scaleValue;
              console.info('Pinch end');
            })
        )

        Text('旋转手势（RotationGesture）')
        Text('RotationGesture angle:' + this.angle).fontSize(28)
          // 在组件上绑定旋转布局，可以通过修改旋转角度来实现组件的旋转
          .rotate({ angle: this.angle })
          .gesture(
            RotationGesture()
              .onActionStart((event: GestureEvent|undefined) => {
                console.info('RotationGesture is onActionStart');
              })
                // 当旋转手势生效时，通过旋转手势的回调函数获取旋转角度，从而修改组件的旋转角度
              .onActionUpdate((event: GestureEvent|undefined) => {
                if(event){
                  this.angle = this.rotateValue + event.angle;
                }
                console.info('RotationGesture is onActionEnd');
              })
                // 当旋转结束抬手时，固定组件在旋转结束时的角度
              .onActionEnd(() => {
                this.rotateValue = this.angle;
                console.info('RotationGesture is onActionEnd');
              })
              .onActionCancel(() => {
                console.info('RotationGesture is onActionCancel');
              })
          )
          .height(200)
          .width(300)
          .padding(20)
          .border({ width: 3 })

        Text('滑动手势（SwipeGesture）')
        Column() {
          Text("SwipeGesture speed\n" + this.speed)
          Text("SwipeGesture angle\n" + this.rotateAngle)
        }
        .border({ width: 3 })
        .width(300)
        .height(200)
        .margin({bottom: 300})
        // 在Column组件上绑定旋转，通过滑动手势的滑动速度和角度修改旋转的角度
        .rotate({ angle: this.rotateAngle })
        .onTouch((event: TouchEvent) => {
          if (event.type === TouchType.Down) {
            this.enableScroll = false
          } else if (event.type === TouchType.Up){
            this.enableScroll = true
          }
        })
        .gesture(
          // 绑定滑动手势且限制仅在竖直方向滑动时触发
          SwipeGesture({ direction: SwipeDirection.Vertical })
            // 当滑动手势触发时，获取滑动的速度和角度，实现对组件的布局参数的修改
            .onAction((event: GestureEvent|undefined) => {
              if(event){
                this.speed = event.speed;
                this.rotateAngle = event.angle;
              }
            })
        )

      }
    }
    .enableScrollInteraction(this.enableScroll)
    .height('100%')
    .width('100%')
  }
}