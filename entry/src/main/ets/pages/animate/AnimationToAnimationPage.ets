import { curves } from '@kit.ArkUI';
import { trustedAppService } from '@kit.DeviceSecurityKit';


class SetSlt {
  isAnimation: boolean = true

  set(): void {
    this.isAnimation = !this.isAnimation;
  }
}


@Entry
@Component
struct AnimationToAnimationPage {
  // 第一步：声明相关状态变量
  @State SetAnimation: SetSlt = new SetSlt();
  @State enableScroll: boolean = true

  build() {
    Scroll() {
      Column() {
        Column() {
          Row() {
            Circle({ width: this.diameter, height: this.diameter })
              .fill(Color.Blue)
              .position({ x: this.positionX, y: this.positionY })// 第二步：将状态变量设置到相关可动画属性接口
              .onTouch((event?: TouchEvent) => {
                // 第三步：在跟手过程改变状态变量值，并且采用responsiveSpringMotion动画运动到新的值
                if (event) {
                  if (event.type === TouchType.Move) {
                    if (this.enableScroll === true) {
                      this.enableScroll = false
                    }
                    // 跟手过程，使用responsiveSpringMotion曲线
                    this.getUIContext()?.animateTo({ curve: curves.responsiveSpringMotion() }, () => {
                      // 减去半径，以使球的中心运动到手指位置
                      this.positionX = event.touches[0].windowX - this.diameter / 2;
                      this.positionY = event.touches[0].windowY - this.diameter / 2;
                      console.info(`move, animateTo x:${this.positionX}, y:${this.positionY}`);
                    })
                  } else if (event.type === TouchType.Up) {
                    // 第四步：在离手过程设定状态变量终点值，并且用springMotion动画运动到新的值，springMotion动画将继承跟手阶段的动画速度
                    this.getUIContext()?.animateTo({ curve: curves.springMotion() }, () => {
                      this.positionX = 100;
                      this.positionY = 100;
                      console.info(`touchUp, animateTo x:100, y:100`);
                    })
                    if (this.enableScroll === false) {
                      this.enableScroll = true
                    }
                  }
                }
              })
          }
          .width("100%").height("80%")
          .clip(true) // 如果球超出父组件范围，使球不可见
          .backgroundColor(Color.Orange)

          Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Start, justifyContent: FlexAlign.Center }) {
            Text("拖动小球").fontSize(16)
          }
          .width("100%")

          Row() {
            Text('点击位置: [x: ' + Math.round(this.positionX) + ', y:' + Math.round(this.positionY) + ']').fontSize(16)
          }
          .padding(10)
          .width("100%")
          Text('手势与动画的衔接')
        }.height('100%').width('100%')


        Text('动画衔接')
          .fontWeight(FontWeight.Bold)
          .fontSize(12)
          .fontColor(Color.White)
          .textAlign(TextAlign.Center)
          .borderRadius(10)
          .backgroundColor(0xf56c6c)
          .width(100)
          .height(100)
          .scale({
            // 第二步：将状态变量设置到相关可动画属性接口
            x: this.SetAnimation.isAnimation ? 2 : 1,
            y: this.SetAnimation.isAnimation ? 2 : 1
          })
          .animation({ curve: curves.springMotion(0.4, 0.8) }) // 第四步：通过隐式动画接口开启隐式动画，动画终点值改变时，系统自动添加衔接动画
        Button('Click')
          .onClick(() => {
            // 第三步：通过点击事件改变状态变量值，影响可动画属性值
            this.SetAnimation.set()
          })
      }
      .justifyContent(FlexAlign.Center)
    }
    .enableScrollInteraction(this.enableScroll)
    .width('100%')
    .height('100%')
  }

  // 第一步：声明相关状态变量
  @State positionX: number = 100;
  @State positionY: number = 100;
  diameter: number = 50;
}