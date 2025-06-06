import Constants from '../common/constants/Constants'

@Entry
@Component
struct MyComponent {
  scroller: Scroller = new Scroller()

  build() {
    Scroll(this.scroller) {
      Column() {
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
      }
    }
  }
}