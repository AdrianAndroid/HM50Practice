import Constants from '../common/Constants'

@Entry
@Component
struct MyComponent {
  scroller: Scroller = new Scroller()
  @State widthValue: number = 0
  @State heightValue: number = 0
  @State componentWidth: number = 0
  @State componentHeight: number = 0

  build() {
    Scroll(this.scroller) {
      Column() {
        // 事件调用
        Row() {
          Image($r('app.media.ic_img_2'))
            .width(200)
            .height(150)
            .margin(15)
            .onComplete(msg => {
              if(msg){
                this.widthValue = msg.width
                this.heightValue = msg.height
                this.componentWidth = msg.componentWidth
                this.componentHeight = msg.componentHeight
              }
            })
              // 图片获取失败，打印结果
            .onError(() => {
              console.info('load image fail')
            })
            .overlay('\nwidth: ' + String(this.widthValue) + ', height: ' + String(this.heightValue) +
              '\ncomponentWidth: ' + String(this.componentWidth) + '\ncomponentHeight: ' + String(this.componentHeight),
              {
                align: Alignment.Bottom,
                offset: { x: 0, y: 60 }
              })
        }.margin({bottom:100})

        // 为图片添加滤镜效果
        Row() {
          Image($r('app.media.example'))
            .width('40%')
            .margin(10)
          Image($r('app.media.example'))
            .width('40%')
            .colorFilter(
              [1, 1, 0, 0, 0,
                0, 1, 0, 0, 0,
                0, 0, 1, 0, 0,
                0, 0, 0, 1, 0])
            .margin(10)
        }.width('100%')
        .justifyContent(FlexAlign.Center)
        Scroll() {
          Row() {
            Image($r('app.media.img_2'))
              .width(200)
              .height(150)
              .border({ width: 1 })// 保持宽高比进行缩小或者放大，使得图片完全显示在显示边界内。
              .objectFit(ImageFit.Contain)
              .margin(15)
              .overlay('Contain', { align: Alignment.Bottom, offset: { x: 0, y: 20 } })
            Image($r('app.media.ic_img_2'))
              .width(200)
              .height(150)
              .border({ width: 1 })// 保持宽高比进行缩小或者放大，使得图片两边都大于或等于显示边界。
              .objectFit(ImageFit.Cover)
              .margin(15)
              .overlay('Cover', { align: Alignment.Bottom, offset: { x: 0, y: 20 } })
            Image($r('app.media.img_2'))
              .width(200)
              .height(150)
              .border({ width: 1 })// 自适应显示。
              .objectFit(ImageFit.Auto)
              .margin(15)
              .overlay('Auto', { align: Alignment.Bottom, offset: { x: 0, y: 20 } })
          }
        }
        .scrollable(ScrollDirection.Horizontal)
        .width(Constants.FULL_WIDTH)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)


        Scroll() {
          Row() {
            Image($r('app.media.img_2'))
              .width(200)
              .height(150)
              .border({ width: 1 })// 不保持宽高比进行放大缩小，使得图片充满显示边界。
              .objectFit(ImageFit.Fill)
              .margin(15)
              .overlay('Fill', { align: Alignment.Bottom, offset: { x: 0, y: 20 } })
            Image($r('app.media.img_2'))
              .width(200)
              .height(150)
              .border({ width: 1 })// 保持宽高比显示，图片缩小或者保持不变。
              .objectFit(ImageFit.ScaleDown)
              .margin(15)
              .overlay('ScaleDown', { align: Alignment.Bottom, offset: { x: 0, y: 20 } })
            Image($r('app.media.img_2'))
              .width(200)
              .height(150)
              .border({ width: 1 })// 保持原有尺寸显示。
              .objectFit(ImageFit.None)
              .margin(15)
              .overlay('None', { align: Alignment.Bottom, offset: { x: 0, y: 20 } })
          }

        }
        .scrollable(ScrollDirection.Horizontal)
        .width(Constants.FULL_WIDTH)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)



        Row({ space: 50 }) {
          Image($r('app.media.example'))
            .sourceSize({
              width: 40,
              height: 40
            })
            .objectFit(ImageFit.ScaleDown)
            .aspectRatio(1)
            .width('25%')
            .border({ width: 1 })
            .overlay('width:40 height:40', { align: Alignment.Bottom, offset: { x: 0, y: 40 } })
          Image($r('app.media.example'))
            .sourceSize({
              width: 90,
              height: 90
            })
            .objectFit(ImageFit.ScaleDown)
            .width('25%')
            .aspectRatio(1)
            .border({ width: 1 })
            .overlay('width:90 height:90', { align: Alignment.Bottom, offset: { x: 0, y: 40 } })
        }.height(150).width('100%').padding(20)

        Row({ space: 50 }) {
          Image($r('app.media.example'))
            // 设置图片的渲染模式为原色
            .renderMode(ImageRenderMode.Original)
            .width(100)
            .height(100)
            .border({ width: 1 })
              // overlay是通用属性，用于在组件上显示说明文字
            .overlay('Original', { align: Alignment.Bottom, offset: { x: 0, y: 20 } })
          Image($r('app.media.example'))
            // 设置图片的渲染模式为黑白
            .renderMode(ImageRenderMode.Template)
            .width(100)
            .height(100)
            .border({ width: 1 })
            .overlay('Template', { align: Alignment.Bottom, offset: { x: 0, y: 20 } })
        }

        Row({ space: 5 }) {
          Image($r('app.media.ic_public_favor_filled_1'))
            .width(110)
            .height(115)
            .border({ width: 1 })
            .objectRepeat(ImageRepeat.XY)
            .objectFit(ImageFit.ScaleDown)
              // 在水平轴和竖直轴上同时重复绘制图片
            .overlay('ImageRepeat.XY', { align: Alignment.Bottom, offset: { x: 0, y: 20 } })
          Image($r('app.media.ic_public_favor_filled_1'))
            .width(110)
            .height(115)
            .border({ width: 1 })
            .objectRepeat(ImageRepeat.Y)
            .objectFit(ImageFit.ScaleDown)
              // 只在竖直轴上重复绘制图片
            .overlay('ImageRepeat.Y', { align: Alignment.Bottom, offset: { x: 0, y: 20 } })
          Image($r('app.media.ic_public_favor_filled_1'))
            .width(110)
            .height(115)
            .border({ width: 1 })
            .objectRepeat(ImageRepeat.X)
            .objectFit(ImageFit.ScaleDown)
              // 只在水平轴上重复绘制图片
            .overlay('ImageRepeat.X', { align: Alignment.Bottom, offset: { x: 0, y: 20 } })
        }

        Row() {
          Image($r('app.media.grass'))
            .width('40%')
            .interpolation(ImageInterpolation.None)
            .borderWidth(1)
            .overlay("Interpolation.None", { align: Alignment.Bottom, offset: { x: 0, y: 20 } })
            .margin(10)
          Image($r('app.media.grass'))
            .width('40%')
            .interpolation(ImageInterpolation.Low)
            .borderWidth(1)
            .overlay("Interpolation.Low", { align: Alignment.Bottom, offset: { x: 0, y: 20 } })
            .margin(10)
        }.width('100%')
        .justifyContent(FlexAlign.Center)

        Row() {
          Image($r('app.media.grass'))
            .width('40%')
            .interpolation(ImageInterpolation.Medium)
            .borderWidth(1)
            .overlay("Interpolation.Medium", { align: Alignment.Bottom, offset: { x: 0, y: 20 } })
            .margin(10)
          Image($r('app.media.grass'))
            .width('40%')
            .interpolation(ImageInterpolation.High)
            .borderWidth(1)
            .overlay("Interpolation.High", { align: Alignment.Bottom, offset: { x: 0, y: 20 } })
            .margin(10)
        }.width('100%')
      }
    }
  }
}