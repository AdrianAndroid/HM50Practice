import { PointPredictor } from '@kit.Penkit';
@Entry
@Component
struct PointPredictorDemo {
  pointPredictor: PointPredictor = new PointPredictor();
  aboutToAppear() {
    console.info('getPredictionPoint aboutToAppear')
  }
  aboutToDisappear(){
    console.info('getPredictionPoint aboutToDisappear')
  }


  build() {
    Stack({ alignContent: Alignment.TopEnd }) {
      this.Canvas() // 画布
    }.height('100%').width('100%')
  }


  // 画布
  @Builder Canvas() {
    Stack()
      .width('100%')
      .height('100%')
      .onTouch((event: TouchEvent) => {
        switch (event.type) {
          case TouchType.Down: // 按下时，新建一条画图路径
            break;
          case TouchType.Move: // 使用预测算法进行预测,获得预测点
            let predictorPoint = this.pointPredictor?.getPredictionPoint(event)
            break;
          case TouchType.Up:
            break;
        }
      })
  }
}