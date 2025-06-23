import { LengthMetrics, PixelMapDrawableDescriptor } from '@kit.ArkUI';
import { photoAccessHelper } from '@kit.MediaLibraryKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { http } from '@kit.NetworkKit';
import { image } from '@kit.ImageKit';
import Constants from '../../common/Constants';


@Entry
@Component
struct ImageExamplePage {
  @State message: string = 'Hello World';
  @State w: number = 100
  @State imgDatas: string[] = [];
  @State drawablePixelMap: PixelMapDrawableDescriptor = new PixelMapDrawableDescriptor()
  // 获取照片url集
  private scroller: Scroller = new Scroller()

  build() {
    Scroll(this.scroller) {
      Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(5), cross: LengthMetrics.vp(5) } }) {
        Button('++++++5').onClick(() => {this.w = (this.w + 10) % 100}).width('100%')
        Image('images/view.png').width(this.w).height(this.w)
        Image('https://www.baidu.com/img/flexible/logo/pc/peak-result.png').height(this.w).width(this.w) // 实际使用时请替换为真实地址
        Image($r('app.media.icon')).height(this.w).width(this.w) // 实际使用时请替换为真实地址
        Image($rawfile('view.png')).height(this.w).width(this.w)

        List() {
          ListItem() { Button('+图片').onClick(() => {this.getAllImg()}) }

          ForEach(this.imgDatas, (item: string) => {
            ListItem() {
              Image(item).width(this.w).height(this.w)
            }
          }, (item: string): string => JSON.stringify(item))
        }.listDirection(Axis.Horizontal).alignListItem(ListItemAlign.Center).width('100%').height(100)

        Image('file://media/Photo/29/IMG_1750614705_027/screenshot_20250623_015004.jpg').width(this.w).height(this.w)
        Image($r('app.media.activeHome')).width(this.w).height(this.w).fillColor(Color.Blue)

        Button("获取网络图片").onClick(() => {this.httpGetImg()})
        Image(this.drawablePixelMap).height(100).width(100)

        // Image加载的Svg图源路径设置方法如下所示
        Image("images/icon.svg").width(this.w).height(this.w)

        // 设置图片缩放类型
        Column() {
          Row() {
            Image($r('app.media.img_2'))
              .width(this.w)
              .height(this.w - 50)
              .border({ width: 1 })// 保持宽高比进行缩小或者放大，使得图片完全显示在显示边界内。
              .objectFit(ImageFit.Contain)
              .margin({ bottom: 15 })
              .overlay('Contain', { align: Alignment.Bottom, offset: { x: 0, y: 15 } })
            Image($r('app.media.ic_img_2'))
              .width(this.w)
              .height(this.w - 50)
              .border({ width: 1 })// 保持宽高比进行缩小或者放大，使得图片两边都大于或等于显示边界。
              .objectFit(ImageFit.Cover)
              .margin({ bottom: 15 })
              .overlay('Cover', { align: Alignment.Bottom, offset: { x: 0, y: 15 } })
            Image($r('app.media.img_2'))
              .width(this.w)
              .height(this.w - 50)
              .border({ width: 1 })// 自适应显示。
              .objectFit(ImageFit.Auto)
              .margin({ bottom: 15 })
              .overlay('Auto', { align: Alignment.Bottom, offset: { x: 0, y: 15 } })
          }
          .width(Constants.FULL_PERCENT)

          Row() {
            Image($r('app.media.img_2'))
              .width(this.w)
              .height(this.w - 50)
              .border({ width: 1 })// 不保持宽高比进行放大缩小，使得图片充满显示边界。
              .objectFit(ImageFit.Fill)
              .overlay('Fill', { align: Alignment.Bottom, offset: { x: 0, y: 15 } })
            Image($r('app.media.img_2'))
              .width(this.w)
              .height(this.w - 50)
              .border({ width: 1 })// 保持宽高比显示，图片缩小或者保持不变。
              .objectFit(ImageFit.ScaleDown)
              .overlay('ScaleDown', { align: Alignment.Bottom, offset: { x: 0, y: 15 } })
            Image($r('app.media.img_2'))
              .width(this.w)
              .height(this.w - 50)
              .border({ width: 1 })// 保持原有尺寸显示。
              .objectFit(ImageFit.None)
              .overlay('None', { align: Alignment.Bottom, offset: { x: 0, y: 15 } })
          }
          .width(Constants.FULL_PERCENT)
        }.width(Constants.FULL_PERCENT)

        // 图片插值
        Column() {
          Row() {
            Image($r('app.media.grass'))
              .width(this.w)
              .interpolation(ImageInterpolation.None)
              .borderWidth(1)
              .overlay("Interpolation.None", { align: Alignment.Bottom, offset: { x: 0, y: 20 } })
              .margin(10)
            Image($r('app.media.grass'))
              .width(this.w)
              .interpolation(ImageInterpolation.Low)
              .borderWidth(1)
              .overlay("Interpolation.Low", { align: Alignment.Bottom, offset: { x: 0, y: 20 } })
              .margin(10)
          }.width('100%')
          .justifyContent(FlexAlign.Center)

          Row() {
            Image($r('app.media.grass'))
              .width(this.w)
              .interpolation(ImageInterpolation.Medium)
              .borderWidth(1)
              .overlay("Interpolation.Medium", { align: Alignment.Bottom, offset: { x: 0, y: 20 } })
              .margin(10)
            Image($r('app.media.grass'))
              .width(this.w)
              .interpolation(ImageInterpolation.High)
              .borderWidth(1)
              .overlay("Interpolation.High", { align: Alignment.Bottom, offset: { x: 0, y: 20 } })
              .margin(10)
          }.width('100%')
          .justifyContent(FlexAlign.Center)
        }.width('100%')

        // 设置图片重复样式
        Column({ space: 10 }) {
          Row({ space: 5 }) {
            Image($r('app.media.ic_public_favor_filled_1'))
              .width(this.w)
              .height(this.w)
              .border({ width: 1 })
              .objectRepeat(ImageRepeat.XY)
              .objectFit(ImageFit.ScaleDown)// 在水平轴和竖直轴上同时重复绘制图片
              .overlay('ImageRepeat.XY', { align: Alignment.Bottom, offset: { x: 0, y: 20 } })
            Image($r('app.media.ic_public_favor_filled_1'))
              .width(this.w)
              .height(this.w)
              .border({ width: 1 })
              .objectRepeat(ImageRepeat.Y)
              .objectFit(ImageFit.ScaleDown)// 只在竖直轴上重复绘制图片
              .overlay('ImageRepeat.Y', { align: Alignment.Bottom, offset: { x: 0, y: 20 } })
            Image($r('app.media.ic_public_favor_filled_1'))
              .width(this.w)
              .height(this.w)
              .border({ width: 1 })
              .objectRepeat(ImageRepeat.X)
              .objectFit(ImageFit.ScaleDown)// 只在水平轴上重复绘制图片
              .overlay('ImageRepeat.X', { align: Alignment.Bottom, offset: { x: 0, y: 20 } })
          }
        }.height(this.w).width('100%').padding(8)

        // 设置图片渲染模式
        Column({ space: 10 }) {
          Row({ space: 50 }) {
            Image($r('app.media.example'))// 设置图片的渲染模式为原色
              .renderMode(ImageRenderMode.Original)
              .width(100)
              .height(100)
              .border({ width: 1 })// overlay是通用属性，用于在组件上显示说明文字
              .overlay('Original', { align: Alignment.Bottom, offset: { x: 0, y: 20 } })
            Image($r('app.media.example'))// 设置图片的渲染模式为黑白
              .renderMode(ImageRenderMode.Template)
              .width(100)
              .height(100)
              .border({ width: 1 })
              .overlay('Template', { align: Alignment.Bottom, offset: { x: 0, y: 20 } })
          }
        }.height(150).width('100%').padding({ top: 20, right: 10 })

        // 设置图片解码尺寸
        Column() {
          Row({ space: 50 }) {
            Image($r('app.media.example'))
              .sourceSize({
                width: 40,
                height: 40
              })
              .objectFit(ImageFit.ScaleDown)
              .aspectRatio(1)
              .width(this.w)
              .border({ width: 1 })
              .overlay('width:40 height:40', { align: Alignment.Bottom, offset: { x: 0, y: 40 } })
            Image($r('app.media.example'))
              .sourceSize({
                width: 90,
                height: 90
              })
              .objectFit(ImageFit.ScaleDown)
              .width(this.w)
              .aspectRatio(1)
              .border({ width: 1 })
              .overlay('width:90 height:90', { align: Alignment.Bottom, offset: { x: 0, y: 40 } })
          }.height(150).width('100%').padding(20)
        }

        // 为图片添加滤镜效果
        Column() {
          Row() {
            Image($r('app.media.example'))
              .width(this.w)
              .margin(10)
            Image($r('app.media.example'))
              .width(this.w)
              .colorFilter(
                [1, 1, 0, 0, 0,
                  0, 1, 0, 0, 0,
                  0, 0, 1, 0, 0,
                  0, 0, 0, 1, 0])
              .margin(10)
          }.width('100%')
          .justifyContent(FlexAlign.Center)
        }

        // 同步加载图片
        Image($r('app.media.icon')).width(this.w).height(this.w).syncLoad(true)

        Column() {
          Row() {
            Image($r('app.media.example'))
              .width(Constants.FULL_PERCENT)
              .height(this.w)
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
              .overlay('\nwidth: ' + String(this.widthValue) + ', height: ' + String(this.heightValue) + '\ncomponentWidth: ' + String(this.componentWidth) + '\ncomponentHeight: ' + String(this.componentHeight), {
                align: Alignment.Bottom,
                offset: { x: 0, y: 60 }
              })          }
        }.width(Constants.FULL_PERCENT)
      }
    }
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    .height('100%')
    .width('100%')
  }

  @State widthValue: number = 0
  @State heightValue: number = 0
  @State componentWidth: number = 0
  @State componentHeight: number = 0

  private httpGetImg() {
    let OutData: http.HttpResponse
    http.createHttp()
      .request('https://www.baidu.com/img/flexible/logo/pc/peak-result.png',
        (error: BusinessError, data: http.HttpResponse) => {
          if (error) {
            console.error(`http request failed with. Code: ${error.code}, message: ${error.message}`);
          } else {
            OutData = data
            let code: http.ResponseCode | number = OutData.responseCode
            if (http.ResponseCode.OK === code) {
              let imageData: ArrayBuffer = OutData.result as ArrayBuffer;
              let imageSource: image.ImageSource = image.createImageSource(imageData);

              class tmp {
                height: number = 100
                width: number = 100
              }

              let si: tmp = new tmp()
              let options: Record<string, number | boolean | tmp> = {
                'alphaType': 0, // 透明度
                'editable': false, // 是否可编辑
                'pixelFormat': 3, // 像素格式
                'scaleMode': 1, // 缩略值
                'size': { height: 100, width: 100 }
              } // 创建图片大小

              class imagetmp {
                image: PixelMap | undefined = undefined

                set(val: PixelMap) {
                  this.image = val
                }
              }

              imageSource.createPixelMap(options).then((pixelMap: PixelMap) => {
                let im = new imagetmp()
                im.set(pixelMap)
                this.drawablePixelMap = new PixelMapDrawableDescriptor(im.image)
              })
            }
          }
        })
  }

  getAllImg() {
    try {
      let PhotoSelectOptions: photoAccessHelper.PhotoSelectOptions = new photoAccessHelper.PhotoSelectOptions();
      PhotoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE;
      PhotoSelectOptions.maxSelectNumber = 5;
      let photoPicker: photoAccessHelper.PhotoViewPicker = new photoAccessHelper.PhotoViewPicker();
      photoPicker
        .select(PhotoSelectOptions)
        .then((PhotoSelectResult: photoAccessHelper.PhotoSelectResult) => {
          this.imgDatas = PhotoSelectResult.photoUris;
          console.info('PhotoViewPicker.select successfully, PhotoSelectResult uri: ' +
          JSON.stringify(PhotoSelectResult));
        })
        .catch((err: Error) => {
          let message = (err as BusinessError).message;
          let code = (err as BusinessError).code;
          console.error(`PhotoViewPicker.select failed with. Code: ${code}, message: ${message}`);
        });
    } catch (err) {
      let message = (err as BusinessError).message;
      let code = (err as BusinessError).code;
      console.error(`PhotoViewPicker failed with. Code: ${code}, message: ${message}`);
    }
  }
}