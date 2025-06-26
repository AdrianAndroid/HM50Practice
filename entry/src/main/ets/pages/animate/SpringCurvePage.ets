import { curves } from '@kit.ArkUI';


class Spring {
  public title: string;
  public subTitle: string;
  public iCurve: ICurve;

  constructor(title: string, subTitle: string, iCurve: ICurve) {
    this.title = title;
    this.iCurve = iCurve;
    this.subTitle = subTitle;
  }
}


// 弹簧组件
@Component
struct Motion {
  @Prop dRotate: number = 0
   title: string = ""
   subTitle: string = ""
   iCurve: ICurve | undefined = undefined

  build() {
    Column() {
      Circle()
        .translate({ y: this.dRotate })
        .animation({ curve: this.iCurve, iterations: -1 })
        .foregroundColor('#317AF7')
        .width(30)
        .height(30)


      Column() {
        Text(this.title)
          .fontColor(Color.Black)
          .fontSize(10).height(30)
        Text(this.subTitle)
          .fontColor(0xcccccc)
          .fontSize(10).width(50)
      }
      .borderWidth({ top: 1 })
      .borderColor(0xf5f5f5)
      .width(80)
      .alignItems(HorizontalAlign.Center)
      .height(100)

    }
    .height(110)
    .margin({ bottom: 5 })
    .alignItems(HorizontalAlign.Center)
  }
}


@Entry
@Component
struct SpringCurvePage {
  @State dRotate: number = 0;
  private springs: Spring[] = [
    new Spring('springMotion', '周期1, 阻尼0.25', curves.springMotion(1, 0.25)),
    new Spring('responsive' + '\n' + 'SpringMotion', '弹性跟手曲线', curves.responsiveSpringMotion(1, 0.25)),
    new Spring('interpolating' + '\n' + 'Spring', '初始速度10，质量1， 刚度228， 阻尼30', curves.interpolatingSpring(10, 1, 228, 30)),
    new Spring('springCurve', '初始速度10， 质量1， 刚度228， 阻尼30', curves.springCurve(10, 1, 228, 30))
  ];

  build() {
    Row() {
      ForEach(this.springs, (item: Spring) => {
        Motion({
          title: item.title,
          subTitle: item.subTitle,
          iCurve: item.iCurve,
          dRotate: this.dRotate
        })
      })
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Bottom)
    .width('100%')
    .height(437)
    .margin({ top: 20 })
    .onClick(() => {
      this.dRotate = -50;
    })
  }
}