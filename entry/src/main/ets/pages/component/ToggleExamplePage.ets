import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct ToggleExamplePage {
  @State message: string = 'Hello World';
  @State BOnSt:promptAction.ShowToastOptions = {'message': 'Bluetooth is on.'}
  @State BOffSt:promptAction.ShowToastOptions = {'message': 'Bluetooth is off.'}


  build() {
    Flex({wrap: FlexWrap.Wrap}) {
      Toggle({ type: ToggleType.Checkbox, isOn: false })
      Toggle({ type: ToggleType.Checkbox, isOn: true })
      Toggle({ type: ToggleType.Switch, isOn: false })
      Toggle({ type: ToggleType.Switch, isOn: true })
      // 创建包含子组件的Toggle
      Toggle({ type: ToggleType.Button, isOn: false }) {
        Text('status button')
          .fontColor('#182431')
          .fontSize(12)
      }.width(100)
      Toggle({ type: ToggleType.Button, isOn: true }) {
        Text('status button')
          .fontColor('#182431')
          .fontSize(12)
      }.width(100)

      // 通过selectedColor属性设置Toggle打开选中后的背景颜色
      Toggle({ type: ToggleType.Button, isOn: true }) {
        Text('status button')
          .fontColor('#182431')
          .fontSize(12)
      }.width(100).selectedColor(Color.Pink)
      Toggle({ type: ToggleType.Checkbox, isOn: true })
        .selectedColor(Color.Pink)
      Toggle({ type: ToggleType.Switch, isOn: true })
        .selectedColor(Color.Pink)

      // 通过switchPointColor属性设置Switch类型的圆形滑块颜色，仅对type为ToggleType.Switch生效。
      Toggle({ type: ToggleType.Switch, isOn: false })
        .switchPointColor(Color.Pink)
      Toggle({ type: ToggleType.Switch, isOn: true })
        .switchPointColor(Color.Pink)
      // 添加事件
      Toggle({ type: ToggleType.Switch, isOn: false })
        .onChange((isOn: boolean) => {
          if(isOn) {
            // 需要执行的操作
          }
        })

      Column() {
        Row() {
          Text("Bluetooth Mode")
            .height(50)
            .fontSize(16)
        }
        Row() {
          Text("Bluetooth")
            .height(50)
            .padding({left: 10})
            .fontSize(16)
            .textAlign(TextAlign.Start)
            .backgroundColor(0xFFFFFF)
          Toggle({ type: ToggleType.Switch })
            .margin({left: 200, right: 10})
            .onChange((isOn: boolean) => {
              if(isOn) {
                promptAction.showToast(this.BOnSt)
              } else {
                promptAction.showToast(this.BOffSt)
              }
            })
        }
        .backgroundColor(0xFFFFFF)
      }
      .padding(10)
      .backgroundColor(0xDCDCDC)
      .width('100%')
      .height('100%')
    }
    .height('100%')
    .width('100%')
  }
}