import Constants from '../../common/Constants';

@Entry
@Component
struct ShapeExamplePage {
  @State message: string = 'Hello World';

  build() {
    Scroll() {
      this.example1()
    }
    .height('100%')
    .width('100%')
  }

  @Builder
  example1() {
    Flex({ wrap: FlexWrap.Wrap, space: {} }) {
      Rect().width(50).height(50)
      Text('normal').fontSize(11).fontColor(0xCCCCCC).width('90%')
      // 绘制90% * 50的矩形
      Column({ space: 5 }) {
        Text('normal').fontSize(9).fontColor(0xCCCCCC).width('90%')
        // 绘制90% * 50矩形
        Rect({ width: '90%', height: 50 })
          .fill(Color.Pink)
        // 绘制90% * 50的矩形框
        Rect()
          .width('90%')
          .height(50)
          .fillOpacity(0)
          .stroke(Color.Red)
          .strokeWidth(3)

        Text('with rounded corners').fontSize(11).fontColor(0xCCCCCC).width('90%')
        // 绘制90% * 80的矩形, 圆角宽高分别为40、20
        Rect({ width: '90%', height: 80 })
          .radiusHeight(20)
          .radiusWidth(40)
          .fill(Color.Pink)
        // 绘制90% * 80的矩形, 圆角宽高为20
        Rect({ width: '90%', height: 80 })
          .radius(20)
          .fill(Color.Pink)
          .stroke(Color.Transparent)
      }.width('100%').margin({ top: 10 })

      // 绘制90% * 50矩形, 左上圆角宽高40,右上圆角宽高20,右下圆角宽高40,左下圆角宽高20
      Rect({ width: '90%', height: 80 })
        .radius([[40, 40], [20, 20], [40, 40], [20, 20]])
        .fill(Color.Pink)
      Text('Circle').width(Constants.FULL_PERCENT)
      // 绘制一个直径为150的圆
      Circle({ width: 50, height: 50 })
      // 绘制一个直径为150、线条为红色虚线的圆环（宽高设置不一致时以短边为直径）
      Circle()
        .width(50)
        .height(50)
        .fillOpacity(0)
        .strokeWidth(3)
        .stroke(Color.Red)
        .strokeDashArray([1, 2])

      Text('Ellipse').width(Constants.FULL_PERCENT)
      // 绘制一个 150 * 80 的椭圆
      Ellipse({ width: 150, height: 80 })
      // 绘制一个 150 * 100 、线条为蓝色的椭圆环
      Ellipse()
        .width(150)
        .height(100)
        .fillOpacity(0)
        .stroke(Color.Blue)
        .strokeWidth(3)


      Text('Line').width(Constants.FULL_PERCENT)
      // 线条绘制的起止点坐标均是相对于Line组件本身绘制区域的坐标
      Line()
        .width(200)
        .height(150)
        .startPoint([0, 0])
        .endPoint([50, 100])
        .stroke(Color.Black)
        .backgroundColor('#F5F5F5')
      Line()
        .width(200)
        .height(150)
        .startPoint([50, 50])
        .endPoint([150, 150])
        .strokeWidth(5)
        .stroke(Color.Orange)
        .strokeOpacity(0.5)
        .backgroundColor('#F5F5F5')
      // strokeDashOffset用于定义关联虚线strokeDashArray数组渲染时的偏移
      Line()
        .width(200)
        .height(150)
        .startPoint([0, 0])
        .endPoint([100, 100])
        .stroke(Color.Black)
        .strokeWidth(3)
        .strokeDashArray([10, 3])
        .strokeDashOffset(5)
        .backgroundColor('#F5F5F5')
      // 当坐标点设置的值超出Line组件的宽高范围时，线条会画出组件绘制区域
      Line()
        .width(50)
        .height(50)
        .startPoint([0, 0])
        .endPoint([100, 100])
        .stroke(Color.Black)
        .strokeWidth(3)
        .strokeDashArray([10, 3])
        .backgroundColor('#F5F5F5')
      // 当LineCapStyle值为Butt时
      Line()
        .width(100)
        .height(200)
        .startPoint([50, 50])
        .endPoint([50, 200])
        .stroke(Color.Black)
        .strokeWidth(20)
        .strokeLineCap(LineCapStyle.Butt)
        .backgroundColor('#F5F5F5')
        .margin(10)
      // 当LineCapStyle值为Round时
      Line()
        .width(100)
        .height(200)
        .startPoint([50, 50])
        .endPoint([50, 200])
        .stroke(Color.Black)
        .strokeWidth(20)
        .strokeLineCap(LineCapStyle.Round)
        .backgroundColor('#F5F5F5')
      // 当LineCapStyle值为Square时
      Line()
        .width(100)
        .height(200)
        .startPoint([50, 50])
        .endPoint([50, 200])
        .stroke(Color.Black)
        .strokeWidth(20)
        .strokeLineCap(LineCapStyle.Square)
        .backgroundColor('#F5F5F5')

      Text('Polyline').width(Constants.FULL_PERCENT)
      // 在 100 * 100 的矩形框中绘制一段折线，起点(0, 0)，经过(20,60)，到达终点(100, 100)
      Polyline({ width: 100, height: 100 })
        .points([[0, 0], [20, 60], [100, 100]])
        .fillOpacity(0)
        .stroke(Color.Blue)
        .strokeWidth(3)
      // 在 100 * 100 的矩形框中绘制一段折线，起点(20, 0)，经过(0,100)，到达终点(100, 90)
      Polyline()
        .width(100)
        .height(100)
        .fillOpacity(0)
        .stroke(Color.Red)
        .strokeWidth(8)
        .points([[20, 0], [0, 100], [100, 90]])// 设置折线拐角处为圆弧
        .strokeLineJoin(LineJoinStyle.Round)// 设置折线两端为半圆
        .strokeLineCap(LineCapStyle.Round)


      Text('Polygon').width(Constants.FULL_PERCENT)
      // 在 100 * 100 的矩形框中绘制一个三角形，起点(0, 0)，经过(50, 100)，终点(100, 0)
      Polygon({ width: 100, height: 100 })
        .points([[0, 0], [50, 100], [100, 0]])
        .fill(Color.Green)
      // 在 100 * 100 的矩形框中绘制一个四边形，起点(0, 0)，经过(0, 100)和(100, 100)，终点(100, 0)
      Polygon()
        .width(100)
        .height(100)
        .points([[0, 0], [0, 100], [100, 100], [100, 0]])
        .fillOpacity(0)
        .strokeWidth(5)
        .stroke(Color.Blue)
      // 在 100 * 100 的矩形框中绘制一个五边形，起点(50, 0)，依次经过(0, 50)、(20, 100)和(80, 100)，终点(100, 50)
      Polygon()
        .width(100)
        .height(100)
        .points([[50, 0], [0, 50], [20, 100], [80, 100], [100, 50]])
        .fill(Color.Red)
        .fillOpacity(0.6)


      Text('Straight line').width(Constants.FULL_PERCENT)
      Text('Straight line')
        .fontSize(11)
        .fontColor(0xCCCCCC)
        .width('90%')
      // 绘制一条长600px，宽3vp的直线
      Path()
        .width('600px')
        .height('10px')
        .commands('M0 0 L600 0')
        .stroke(Color.Black)
        .strokeWidth(3)

      Text('Straight line graph')
        .fontSize(11)
        .fontColor(0xCCCCCC)
        .width('90%')
      // 绘制直线图形
      Flex({ justifyContent: FlexAlign.SpaceBetween }) {
        Path()
          .width('210px')
          .height('310px')
          .commands('M100 0 L200 240 L0 240 Z')
          .fillOpacity(0)
          .stroke(Color.Black)
          .strokeWidth(3)
        Path()
          .width('210px')
          .height('310px')
          .commands('M0 0 H200 V200 H0 Z')
          .fillOpacity(0)
          .stroke(Color.Black)
          .strokeWidth(3)
        Path()
          .width('210px')
          .height('310px')
          .commands('M100 0 L0 100 L50 200 L150 200 L200 100 Z')
          .fillOpacity(0)
          .stroke(Color.Black)
          .strokeWidth(3)
      }.width('95%')

      Line().width(Constants.FULL_PERCENT)
      Text('Curve graphics').fontSize(11).fontColor(0xCCCCCC).width('90%')
      // 绘制弧线图形
      Flex({ justifyContent: FlexAlign.SpaceBetween }) {
        Path()
          .width('250px')
          .height('310px')
          .commands("M0 300 S100 0 240 300 Z")
          .fillOpacity(0)
          .stroke(Color.Red)
          .strokeWidth(3)
        Path()
          .width('210px')
          .height('310px')
          .commands('M0 150 C0 10+0 140 0 200 150 L100 300 Z')
          .fillOpacity(0)
          .stroke(Color.Red)
          .strokeWidth(3)
        Path()
          .width('210px')
          .height('310px')
          .commands('M0 100 A30 20 20 0 0 200 100 Z')
          .fillOpacity(0)
          .stroke(Color.Red)
          .strokeWidth(3)
      }.width('95%')

      Line().width(Constants.FULL_PERCENT)
      Column()
        .width(100)
        .height(100)
        .linearGradient({
          direction: GradientDirection.Right,
          colors: [[0xff0000, 0.0], [0x0000ff, 0.3], [0xffff00, 1.0]]
        })
        .clip(new Rect({ width: 100, height: 100, radius: 40 }))
      Rect()
        .width(100)
        .height(100)// 设置矩形填充，如果需要显示背景的渐变色，请设置区域透明度.fillOpacity(0.0)
        .fill(Color.Pink)// 设置倒角为40
        .radius(40)
        .stroke(Color.Black)// 设置渐变色，仅100*100的矩形区域生效，渐变色的边界不包含倒角
        .linearGradient({
          direction: GradientDirection.Right,
          colors: [[0xff0000, 0.0], [0x0000ff, 0.3], [0xffff00, 1.0]]
        })

      Text('形状视口viewport').width(Constants.FULL_PERCENT)
      // 画一个宽高都为75的圆
      Text('原始尺寸Circle组件')
      Circle({ width: 75, height: 75 }).fill('#E87361')
      Column() {
        // 创建一个宽高都为150的shape组件，背景色为黄色，一个宽高都为75的viewport。用一个蓝色的矩形来填充viewport，在viewport中绘制一个直径为75的圆。
        // 绘制结束，viewport会根据组件宽高放大两倍
        Text('shape内放大的Circle组件')
        Shape() {
          Rect().width('100%').height('100%').fill('#0097D4')
          Circle({ width: 75, height: 75 }).fill('#E87361')
        }
        .viewPort({
          x: 0,
          y: 0,
          width: 75,
          height: 75
        })
        .width(150)
        .height(150)
        .backgroundColor('#F5DC62')
      }

      Column() {
        // 创建一个宽高都为150的shape组件，背景色为黄色，一个宽高都为300的viewport。用一个绿色的矩形来填充viewport，在viewport中绘制一个直径为75的圆。
        // 绘制结束，viewport会根据组件宽高缩小两倍。
        Text('Shape内缩小的Circle组件')
        Shape() {
          Rect().width('100%').height('100%').fill('#BDDB69')
          Circle({ width: 75, height: 75 }).fill('#E87361')
        }
        .viewPort({
          x: 0,
          y: 0,
          width: 300,
          height: 300
        })
        .width(150)
        .height(150)
        .backgroundColor('#F5DC62')
      }

      Column() {
        // 创建一个宽高都为150的shape组件，背景色为黄色，一个宽高都为300的viewport。用一个绿色的矩形来填充viewport，在viewport中绘制一个直径为75的圆。
        // 绘制结束，viewport会根据组件宽高缩小两倍。
        Text('创建一个宽高都为300的shape组件，背景色为黄色，一个宽高都为300的viewport。用一个蓝色的矩形来填充viewport，在viewport中绘制一个半径为75的圆。')
        Shape() {
          Rect().width("100%").height("100%").fill("#0097D4")
          Circle({ width: 150, height: 150 }).fill("#E87361")
        }
        .viewPort({ x: 0, y: 0, width: 300, height: 300 } )
        .width(300)
        .height(300)
        .backgroundColor("#F5DC62")
      }

      Column() {
        // 创建一个宽高都为150的shape组件，背景色为黄色，一个宽高都为300的viewport。用一个绿色的矩形来填充viewport，在viewport中绘制一个直径为75的圆。
        // 绘制结束，viewport会根据组件宽高缩小两倍。
        Text('创建一个宽高都为300的shape组件，背景色为黄色，创建一个宽高都为300的viewport。用一个蓝色的矩形来填充viewport，在viewport中绘制一个半径为75的圆，将viewport向右方和下方各平移150。')
        Shape() {
          Rect().width("100%").height("100%").fill("#0097D4")
          Circle({ width: 150, height: 150 }).fill("#E87361")
        }
        .viewPort({x: -150, y: -150, width: 300, height: 300})
        .width(300)
        .height(300)
        .backgroundColor("#F5DC62")
      }

      Column() {
        Text('自定义样式')
        Path()
          .width(100)
          .height(100)
          .commands('M150 0 L300 300 L0 300 Z')
          .fill("#E87361")
          .strokeWidth(0)
      }

      Column() {
        Text('通过stroke可以设置组件边框颜色')
        Path()
          .width(100)
          .height(100)
          .fillOpacity(0)
          .commands('M150 0 L300 300 L0 300 Z')
          .stroke(Color.Red)
      }


      Column() {
        Text('通过strokeOpacity可以设置边框透明度')
        Path()
          .width(100)
          .height(100)
          .fillOpacity(0)
          .commands('M150 0 L300 300 L0 300 Z')
          .stroke(Color.Red)
          .strokeWidth(10)
          .strokeOpacity(0.2)
      }

      Column() {
        Text('通过strokeLineJoin可以设置线条拐角绘制样式。拐角绘制样式分为Bevel(使用斜角连接路径段)、Miter(使用尖角连接路径段)、Round(使用圆角连接路径段)')
        Polyline()
          .width(100)
          .height(100)
          .fillOpacity(0)
          .stroke(Color.Red)
          .strokeWidth(8)
          .points([[20, 0], [0, 100], [100, 90]])
            // 设置折线拐角处为圆弧
          .strokeLineJoin(LineJoinStyle.Round)
      }

      Column() {
        Text('开启抗锯齿')
        //开启抗锯齿
        Circle()
          .width(150)
          .height(200)
          .fillOpacity(0)
          .strokeWidth(5)
          .stroke(Color.Black)
      }

      Column() {
        Text('关闭抗锯齿')
        //关闭抗锯齿
        Circle()
          .width(150)
          .height(200)
          .fillOpacity(0)
          .strokeWidth(5)
          .stroke(Color.Black)
          .antiAlias(false)
      }

      Column() {
        Text('绘制封闭路径')
        //关闭抗锯齿
        Shape() {
          Path().width(200).height(60).commands('M0 0 L400 0 L400 150 Z')
        }
        .viewPort({ x: -80, y: -5, width: 500, height: 300 })
        .fill(0x317AF7)
        .stroke(Color.Red)
        .strokeWidth(3)
        .strokeLineJoin(LineJoinStyle.Miter)
        .strokeMiterLimit(5)
      }

      Column() {
        Text('绘制圆和圆环')
        //绘制一个直径为150的圆
        Circle({ width: 150, height: 150 })
        //绘制一个直径为150、线条为红色虚线的圆环
        Circle()
          .width(150)
          .height(200)
          .fillOpacity(0)
          .strokeWidth(3)
          .stroke(Color.Red)
          .strokeDashArray([1, 2])
      }

      Text('通过strokeMiterLimit设置斜接长度与边框宽度比值的极限值')
      Polyline()
        .width(100)
        .height(100)
        .fillOpacity(0)
        .stroke(Color.Red)
        .strokeWidth(10)
        .points([[20, 0], [20, 100], [100, 100]])
          // 设置折线拐角处为尖角
        .strokeLineJoin(LineJoinStyle.Miter)
        // 设置斜接长度与线宽的比值
        .strokeMiterLimit(1/Math.sin(45))
      Polyline()
        .width(100)
        .height(100)
        .fillOpacity(0)
        .stroke(Color.Red)
        .strokeWidth(10)
        .points([[20, 0], [20, 100], [100, 100]])
        .strokeLineJoin(LineJoinStyle.Miter)
        .strokeMiterLimit(1.42)
    }
    .margin({bottom: 100})
  }
}