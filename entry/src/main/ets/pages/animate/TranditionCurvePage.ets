class MyCurve {
  public title: string;
  public curve: Curve;
  public color: Color | string;

  constructor(title: string, curve: Curve, color: Color | string = '') {
    this.title = title;
    this.curve = curve;
    this.color = color;
  }
}

const myCurves: MyCurve[] = [
  new MyCurve(' Linear', Curve.Linear, '#317AF7'),
  new MyCurve(' Ease', Curve.Ease, '#D94838'),
  new MyCurve(' EaseIn', Curve.EaseIn, '#DB6B42'),
  new MyCurve(' EaseOut', Curve.EaseOut, '#5BA854'),
  new MyCurve(' EaseInOut', Curve.EaseInOut, '#613AF7'),
  new MyCurve(' FastOutSlowIn', Curve.FastOutSlowIn, '#D94838')
]

@Entry
@Component
struct TranditionCurvePage {
  @State dRotate: number = 0; // 旋转角度

  build() {
    Column() {
      // 曲线图例
      Grid() {
        ForEach(myCurves, (item: MyCurve) => {
          GridItem() {
            Column() {
              Row()
                .width(30)
                .height(30)
                .borderRadius(15)
                .backgroundColor(item.color)
              Text(item.title)
                .fontSize(15)
                .fontColor(0x909399)
            }
            .width('100%')
          }
        })
      }
      .columnsTemplate('1fr 1fr 1fr')
      .rowsTemplate('1fr 1fr 1fr 1fr 1fr')
      .padding(10)
      .width('100%')
      .height(300)
      .margin({ top: 50 })

      Stack() {
        // 摆动管道
        Row()
          .width(290)
          .height(290)
          .border({
            width: 15,
            color: 0xE6E8EB,
            radius: 145
          })

        ForEach(myCurves, (item: MyCurve) => {
          // 小球
          Column() {
            Row()
              .width(30)
              .height(30)
              .borderRadius(15)
              .backgroundColor(item.color)
          }
          .width(20)
          .height(300)
          .rotate({ angle: this.dRotate })
          .animation({
            duration: 2000,
            iterations: -1,
            curve: item.curve,
            delay: 100
          })
        })
      }
      .width('100%')
      .height(200)
      .onClick(() => {
        this.dRotate ? null : this.dRotate = 360;
      })
    }
    .width('100%')
  }
}