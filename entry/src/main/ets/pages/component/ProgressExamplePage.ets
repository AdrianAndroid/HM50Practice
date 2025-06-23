import Constants from '../../common/Constants';
import { LengthMetrics } from '@kit.ArkUI';

@Entry
@Component
struct ProgressExamplePage {
  @State message: string = 'Hello World';
  @State progress: number = 24

  build() {
    Flex({ wrap: FlexWrap.Wrap, space: { cross: LengthMetrics.vp(5), main: LengthMetrics.vp(5) } }) {
      Button('进度条 +5')
        .width(Constants.FULL_PERCENT)
        .onClick(() => {
          this.progress = (this.progress + 5) % 100
        })
      Progress({ value: this.progress, total: 100, type: ProgressType.Linear }) // 创建一个进度总长为100，初始进度值为24的线性进度条
      Progress({ value: this.progress, total: 100, type: ProgressType.Linear }).width(200).height(30)
      Progress({ value: this.progress, total: 100, type: ProgressType.Linear }).width(30).height(50)

      // 环形无刻度样式进度条
      // 从左往右，1号环形进度条，默认前景色为蓝色渐变，默认strokeWidth进度条宽度为2.0vp
      Progress({ value: this.progress, total: 100, type: ProgressType.Ring }).width(50).height(50)
      // 从左往右，2号环形进度条
      Progress({ value: this.progress, total: 100, type: ProgressType.Ring }).width(50).height(50)
        .color(Color.Grey)// 进度条前景色为灰色
        .style({ strokeWidth: 15 }) // 设置strokeWidth进度条宽度为15.0vp

      // 环形有刻度样式进度条
      Progress({ value: this.progress, total: 100, type: ProgressType.ScaleRing }).width(50).height(50)
        .backgroundColor(Color.Black)
        .style({ scaleCount: 20, scaleWidth: 5 })    // 设置环形有刻度进度条总刻度数为20，刻度宽度为5vp
      Progress({ value: this.progress, total: 100, type: ProgressType.ScaleRing }).width(50).height(50)
        .backgroundColor(Color.Black)
        .style({ strokeWidth: 15, scaleCount: 20, scaleWidth: 5 })    // 设置环形有刻度进度条宽度15，总刻度数为20，刻度宽度为5vp
      Progress({ value: this.progress, total: 100, type: ProgressType.ScaleRing }).width(50).height(50)
        .backgroundColor(Color.Black)
        .style({ strokeWidth: 15, scaleCount: 20, scaleWidth: 3 })    // 设置环形有刻度进度条宽度15，总刻度数为20，刻度宽度为3vp

      // 圆形样式进度条
      // 从左往右，1号圆形进度条，默认前景色为蓝色
      Progress({ value: this.progress, total: 150, type: ProgressType.Eclipse }).width(100).height(100)
      // 从左往右，2号圆形进度条，指定前景色为灰色
      Progress({ value: this.progress, total: 150, type: ProgressType.Eclipse }).color(Color.Grey).width(100).height(100)

      // 胶囊样式进度条
      Progress({ value: this.progress, total: 150, type: ProgressType.Capsule }).width(100).height(50)
      Progress({ value: this.progress, total: 150, type: ProgressType.Capsule }).width(50).height(100).color(Color.Grey)
      Progress({ value: this.progress, total: 150, type: ProgressType.Capsule }).width(50).height(100).color(Color.Blue).backgroundColor(Color.Black)

      Column() {
        Column() {
          Progress({value:0, total:100, type:ProgressType.Capsule}).width(200).height(50).value(this.progress)
          Row().width('100%').height(5)
          Button("进度条+5")
            .onClick(()=>{
              this.progress += 5
              if (this.progress > 100){
                this.progress = 0
              }
            })
        }
      }.width('100%').height('100%')
    }
    .height('100%')
    .width('100%')
  }
}