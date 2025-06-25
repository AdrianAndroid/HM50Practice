@Entry
@Component
struct CanvasExamplePage {
  @State message: string = 'Hello World';
  //用来配置CanvasRenderingContext2D对象的参数，包括是否开启抗锯齿，true表明开启抗锯齿。
  private settings1: RenderingContextSettings = new RenderingContextSettings(true)
  //用来创建CanvasRenderingContext2D对象，通过在canvas中调用CanvasRenderingContext2D对象来绘制。
  private context1: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings1)
  //用来配置CanvasRenderingContext2D对象和OffscreenCanvasRenderingContext2D对象的参数，包括是否开启抗锯齿。true表明开启抗锯齿
  private settings2: RenderingContextSettings = new RenderingContextSettings(true)
  private context2: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings2)
  //用来创建OffscreenCanvas对象，width为离屏画布的宽度，height为离屏画布的高度。通过在canvas中调用OffscreenCanvasRenderingContext2D对象来绘制。
  private offCanvas2: OffscreenCanvas = new OffscreenCanvas(600, 600)
  private settings3: RenderingContextSettings = new RenderingContextSettings(true)
  private context3: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings3)
  private settings4: RenderingContextSettings = new RenderingContextSettings(true)
  private context4: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings4)
  private settings5: RenderingContextSettings = new RenderingContextSettings(true)
  private context5: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings5)
  private settings6: RenderingContextSettings = new RenderingContextSettings(true)
  private context6: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings6)
  private settings7: RenderingContextSettings = new RenderingContextSettings(true)
  private context7: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings7)
  private settings11: RenderingContextSettings = new RenderingContextSettings(true);
  private context11: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings11);
  private settings10: RenderingContextSettings = new RenderingContextSettings(true);
  private context10: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings10);
  private settings9: RenderingContextSettings = new RenderingContextSettings(true)
  private context9: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings9)
  private settings8: RenderingContextSettings = new RenderingContextSettings(true)
  private context8: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings8)
  private offCanvas8: OffscreenCanvas = new OffscreenCanvas(600, 600)
  private img8: ImageBitmap = new ImageBitmap("/common/images/img_5.jpg")

  build() {
    Scroll() {
      Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
        //在canvas中调用CanvasRenderingContext2D对象。
        Column() {
          Text('用CanvasRenderingContext2D对象在Canvas画布上绘制')
          Canvas(this.context1)
            .width(300)
            .height(300)
            .backgroundColor('#F5DC62')
            .onReady(() => {
              //可以在这里绘制内容。
              this.context1.strokeRect(50, 50, 200, 150);
            })
        }

        Column() {
          Text('离屏绘制')
          Canvas(this.context2)
            .width(300)
            .height(300)
            .backgroundColor('#F5DC62')
            .onReady(() => {
              let offContext2 = this.offCanvas2.getContext("2d", this.settings2)
              //可以在这里绘制内容
              offContext2.strokeRect(50, 50, 200, 150);
              //将离屏绘值渲染的图像在普通画布上显示
              let image2 = this.offCanvas2.transferToImageBitmap();
              this.context2.transferFromImageBitmap(image2);
            })
        }

        Column() {
          Text('初始化画布组件')
          Canvas(this.context3)
            .width(300)
            .height(300)
            .backgroundColor('#F5DC62')
            .onReady(() => {
              this.context3.fillStyle = '#0097D4';
              this.context3.fillRect(50, 50, 100, 100);
            })
        }

        Column() {
          Text('通过CanvasRenderingContext2D对象和OffscreenCanvasRenderingContext2D对象直接调用相关API进行绘制。')

          Canvas(this.context4)
            .width(300)
            .height(300)
            .backgroundColor('#F5DC62')
            .onReady(() => {
              this.context4.beginPath();
              this.context4.moveTo(50, 50);
              this.context4.lineTo(280, 160);
              this.context4.stroke();
            })
        }

        Column() {
          Text('先单独定义path2d对象构造理想的路径，再通过调用CanvasRenderingContext2D对象和OffscreenCanvasRenderingContext2D对象的stroke接口或者fill接口进行绘制，具体使用可以参考Path2D对象')

          Canvas(this.context5)
            .width(300)
            .height(300)
            .backgroundColor('#F5DC62')
            .onReady(() => {
              this.context5.beginPath();
              this.context5.moveTo(50, 50);
              this.context5.lineTo(280, 160);
              this.context5.stroke();
            })
        }

        Column() {
          Text('可以通过arc（绘制弧线路径）、 ellipse（绘制一个椭圆）、rect（创建矩形路径）等接口绘制基础形状。')

          Canvas(this.context6)
            .width('100%')
            .height('50%')
            .backgroundColor('#F5DC62')
            .onReady(() => {
              //绘制矩形
              this.context6.beginPath();
              this.context6.rect(100, 50, 100, 100);
              this.context6.stroke();
              //绘制圆形
              this.context6.beginPath();
              this.context6.arc(150, 250, 50, 0, 6.28);
              this.context6.stroke();
              //绘制椭圆
              this.context6.beginPath();
              this.context6.ellipse(150, 450, 50, 100, Math.PI * 0.25, Math.PI * 0, Math.PI * 2);
              this.context6.stroke();
            })
        }


        Column() {
          Text('文本绘制')

          Canvas(this.context7)
            .width('100%')
            .height('50%')
            .backgroundColor('#F5DC62')
            .onReady(() => {
              // 文本填充
              this.context7.font = '50px bolder sans-serif';
              this.context7.fillText("Hello World!", 50, 100);
              // 文本描边
              this.context7.strokeStyle = "#ff0000"
              this.context7.lineWidth = 2
              this.context7.font = '50px bolder sans-serif';
              this.context7.strokeText("Hello World!", 50, 150);
            })
        }

        Column() {
          Text('绘制图片和图像像素信息处理')

          Canvas(this.context8)
            .width('100%')
            .height('50%')
            .backgroundColor('#F5DC62')
            .onReady(() => {
              let offContext = this.offCanvas8.getContext("2d", this.settings8)
              // 使用drawImage接口将图片画在（0，0）为起点，宽高130的区域
              offContext.drawImage(this.img8, 0, 0, 130, 130);
              // 使用getImageData接口，获得canvas组件区域中，（50，50）为起点，宽高130范围内的绘制内容
              let imagedata = offContext.getImageData(50, 50, 130, 130);
              // 使用putImageData接口将得到的ImageData画在起点为（150， 150）的区域中
              offContext.putImageData(imagedata, 150, 150);
              // 将离屏绘制的内容画到canvas组件上
              let image = this.offCanvas8.transferToImageBitmap();
              this.context8.transferFromImageBitmap(image);
            })
        }

        Column() {
          Text('其他方法')

          Canvas(this.context9)
            .width('100%')
            .height('50%')
            .backgroundColor('#F5DC62')
            .onReady(() => {
              //创建一个径向渐变色的CanvasGradient对象
              let grad = this.context9.createRadialGradient(200, 200, 50, 200, 200, 200)
              //为CanvasGradient对象设置渐变断点值，包括偏移和颜色
              grad.addColorStop(0.0, '#E87361');
              grad.addColorStop(0.5, '#FFFFF0');
              grad.addColorStop(1.0, '#BDDB69');
              //用CanvasGradient对象填充矩形
              this.context9.fillStyle = grad;
              this.context9.fillRect(0, 0, 400, 400);
            })
        }

        Column() {
          Text('不规则图形绘制')
          Canvas(this.context11)
            .width('100%')
            .height('100%')
            .backgroundColor('#F5DC62')
            .onReady(() => {
              // 使用Path2D的接口构造一个五边形
              let path = new Path2D();
              path.moveTo(150, 50);
              path.lineTo(50, 150);
              path.lineTo(100, 250);
              path.lineTo(200, 250);
              path.lineTo(250, 150);
              path.closePath();
              // 设定填充色为蓝色
              this.context11.fillStyle = '#0097D4';
              // 使用填充的方式，将Path2D描述的五边形绘制在canvas组件内部
              this.context11.fill(path);
            })
        }
      }
    }
    .height('100%')
    .width('100%')
  }
}