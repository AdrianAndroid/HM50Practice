import Constants from '../common/constants/Constants';

@Entry
@Component
struct ButtonExample {

  build() {
    Scroll() {
      Column() {
        Button('Ok', { type: ButtonType.Normal, stateEffect: true })
          .borderRadius(8)
          .backgroundColor(0x317aff)
          .width(90)
          .height(40)

        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Row() {
            Image($r('app.media.loading')).width(20).height(40).margin({ left: 12 })
            Text('loading').fontSize(12).fontColor(0xffffff).margin({ left: 5, right: 12 })
          }.alignItems(VerticalAlign.Center)
        }.borderRadius(8).backgroundColor(0x317aff).width(90).height(40)
        // 胶囊类型
        Button('Disable', { type: ButtonType.Capsule, stateEffect: false })
          .backgroundColor(0x317aff)
          .width(90)
          .height(40)

        // 圆形按钮
        Button('Circle', { type: ButtonType.Circle, stateEffect: false })
          .backgroundColor(0x317aff)
          .width(90)
          .height(90)

        // 普通按钮
        Button('Ok', { type: ButtonType.Normal, stateEffect: true })
          .borderRadius(8)
          .backgroundColor(0x317aff)
          .width(90)
          .height(40)

        // 自定义样式
        Button('circle border', { type: ButtonType.Normal })
          .borderRadius(20)
          .height(40)

        // 设置文本样式
        Button('font style', { type: ButtonType.Normal })
          .fontSize(20)
          .fontColor(Color.Pink)
          .fontWeight(800)

        // 设置背景颜色
        Button('background color').backgroundColor(0xF55A42)

        // 创建功能性按钮
        // let MarLeft: Record<string, number> = { 'left': 20 }
        Button({ type: ButtonType.Circle, stateEffect: true }) {
          Image($r('app.media.ic_public_delete_filled')).width(30).height(30)
        }.width(55).height(55).margin({ 'left': 20 }).backgroundColor(0xF55A42)

        // 添加事件
        Button('Ok', { type: ButtonType.Normal, stateEffect: true })
          .onClick(()=>{
            console.info('Button onClick')
          })


      }
    }
    .width(Constants.FULL_WIDTH)
    .height(Constants.FULL_HEIGHT)
  }
}