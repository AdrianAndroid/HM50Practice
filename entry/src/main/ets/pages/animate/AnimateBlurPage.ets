import { curves } from '@kit.ArkUI';

@Entry
@Component
struct AnimateBlurPage {
  @State message: string = 'Hello World';
  @State radius: number = 0;
  @State text: string = '';
  @State y: string = '手指不在屏幕上';
  @State enableScroll: boolean = true

  gridSize: number = 100

  aboutToAppear() {
    this.text = "按住屏幕上下滑动\n" + "当前手指所在y轴位置 ： " + this.y + "\n" + "当前图片模糊程度为 : " + this.radius;
  }

  build() {
    Scroll() {
      Column() {
        Text('使用backdropBlur为组件添加背景模糊')
        Text('backdropBlur')
          .width(200)
          .height(200)
          .fontSize(20)
          .fontColor(Color.White)
          .textAlign(TextAlign.Center)
          .backdropBlur(10)// 对背景进行模糊
          .backgroundImage($r('app.media.img_9'))
          .backgroundImageSize({ width: 200, height: 200 })

        Text('使用blur为组件添加内容模糊')
        Flex({
          direction: FlexDirection.Column,
          alignItems: ItemAlign.Center,
          justifyContent: FlexAlign.SpaceBetween
        }) {
          Text(this.text)
            .height(200)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontFamily("cursive")
            .fontStyle(FontStyle.Italic)
          Image($r("app.media.img_9"))
            .blur(this.radius)// 使用blur接口为照片组件添加内容模糊效果
            .height('100%')
            .width("100%")
            .objectFit(ImageFit.Cover)
            .onTouch((event?: TouchEvent) => {
              if (event) {
                if (event.type === TouchType.Move) {
                  if (this.enableScroll === true) {
                    this.enableScroll = false
                  }
                  this.y = Number(event.touches[0].y.toString()).toString();
                  this.radius = Number(this.y) / 10; // 根据跟手过程中的滑动距离修改模糊半径，配合模糊接口，形成跟手模糊效果
                } else if (event.type === TouchType.Up) {
                  this.radius = 0;
                  this.y = '手指离开屏幕';
                  if (this.enableScroll === false) {
                    this.enableScroll = true
                  }
                }
              }
              this.text = "按住屏幕上下滑动\n" + "当前手指所在y轴位置 ： " + this.y +
                "\n" + "当前图片模糊程度为 : " + this.radius;
            })
        }.height('50%')
        .width("80%")

        Text('使用backgroundBlurStyle为组件添加背景模糊效果')
        Grid() {
          GridItem() {
            Column() {
              Column() {
                Text('原图')
                  .fontSize(6)
                  .fontColor(Color.White)
                  .textAlign(TextAlign.Center)
                  .width('100%')
                  .height('100%')
              }
              .height(this.gridSize)
              .aspectRatio(1)
              .borderRadius(10)
              .backgroundImage($r('app.media.ic_scene_2'))

              Text('原图')
                .fontSize(12)
                .fontColor(Color.Black)
            }
            .width(this.gridSize)
            .height(this.gridSize)
            .justifyContent(FlexAlign.Start)
          }
          GridItem() {
            this.gridCellItem('NONE', BlurStyle.NONE)
          }
          GridItem() {
            this.gridCellItem('Thin', BlurStyle.Thin)
          }
          GridItem() {
            this.gridCellItem('Regular', BlurStyle.Regular)
          }
          GridItem() {
            this.gridCellItem('Thick', BlurStyle.Thick)
          }
          GridItem() {
            this.gridCellItem('BACKGROUND_THIN', BlurStyle.BACKGROUND_THIN)
          }
          GridItem() {
            this.gridCellItem('BACKGROUND_REGULAR', BlurStyle.BACKGROUND_REGULAR)
          }
          GridItem() {
            this.gridCellItem('BACKGROUND_THICK', BlurStyle.BACKGROUND_THICK)
          }
          GridItem() {
            this.gridCellItem('BACKGROUND_ULTRA_THICK', BlurStyle.BACKGROUND_ULTRA_THICK)
          }
        }
        .columnsTemplate('1fr 1fr 1fr')
        // .rowsTemplate('1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr 1fr')
        .width('100%')

        Text('使用foregroundBlurStyle为组件添加内容模糊效果')
        Grid() {
          GridItem() {
            Column() {
              Text('原图')
                .fontSize(20)
                .fontColor(Color.White)
                .textAlign(TextAlign.Center)
                .width('100%')
                .height('100%')
            }
            .height(100)
            .width(100)
            .aspectRatio(1)
            .borderRadius(10)
            .backgroundImage($r('app.media.ic_scene_1'))
          }
          this.foregroundBlurStyleCellItem('NONE', BlurStyle.NONE)
          this.foregroundBlurStyleCellItem('Thin', BlurStyle.Thin)
          this.foregroundBlurStyleCellItem('Thin', BlurStyle.Thin)
          this.foregroundBlurStyleCellItem('Regular', BlurStyle.Regular)
          this.foregroundBlurStyleCellItem('Thick', BlurStyle.Thick)
          this.foregroundBlurStyleCellItem('BACKGROUND_THIN', BlurStyle.BACKGROUND_THIN)
          this.foregroundBlurStyleCellItem('BACKGROUND_REGULAR', BlurStyle.BACKGROUND_REGULAR)
          this.foregroundBlurStyleCellItem('BACKGROUND_THICK', BlurStyle.BACKGROUND_THICK)
          this.foregroundBlurStyleCellItem('BACKGROUND_ULTRA_THICK', BlurStyle.BACKGROUND_ULTRA_THICK)
        }
        .columnsTemplate('1fr 1fr 1fr')
        // .rowsTemplate('1fr 1fr 1fr 1fr')
        .width('100%')
        .height('100%')
        .margin({ top: 40 })

        Text('使用motionBlur为组件添加运动模糊效果')
        Column() {
          Column() {
            Image($r('app.media.ic_scene_1'))
              .width(this.widthSize)
              .height(this.heightSize)
              .onClick(() => {
                this.radius = 5;
                this.x1 = 0.5;
                this.y1 = 0.5;
                if (this.flag) {
                  this.widthSize = 100;
                  this.heightSize = 80;
                } else {
                  this.widthSize = 400;
                  this.heightSize = 320;
                }
                this.flag = !this.flag;
              })
              .animation({
                duration: 2000,
                curve: curves.springCurve(10, 1, 228, 30),
                onFinish: () => {
                  this.radius = 0;
                }
              })
              .motionBlur({ radius: this.radius, anchor: { x: this.x1, y: this.y1 } })
          }
        }
        .width('100%')
        .height(400)
        .margin({ top: 5 })
      }
    }
    .enableScrollInteraction(this.enableScroll)
    .align(Alignment.Top)
    .height('100%')
    .width('100%')
  }

  @State widthSize: number = 400
  @State heightSize: number = 320
  @State flag: boolean = true
  // @State radius: number = 0
  @State x1: number = 0
  @State y1: number = 0

  @Builder
  private foregroundBlurStyleCellItem(title: string, style: BlurStyle) {
    GridItem() {
      Column() {
        Text(title)
          .fontSize(8)
          .fontColor(Color.Black)
          .textAlign(TextAlign.Center)
          .width('100%')
          .height('100%')
      }
      .width(100)
      .height(100)
      .aspectRatio(1)
      .borderRadius(10)
      .backgroundImage($r('app.media.ic_scene_1'))
      .foregroundBlurStyle(style, {
        colorMode: ThemeColorMode.LIGHT,
        adaptiveColor: AdaptiveColor.DEFAULT,
        scale: 0.1
      })
    }
  }

  @Builder
  private gridCellItem(title: string, style: BlurStyle) {
    Column() {
      Text(title)
        .fontSize(11)
        .fontColor(Color.White)
        .textAlign(TextAlign.Center)
        .width(this.gridSize)
        .height(this.gridSize)
    }
    .width(this.gridSize)
    .height(this.gridSize)
    .aspectRatio(1)
    .borderRadius(10)
    .backgroundImage($r('app.media.ic_scene_2'))
    .backgroundBlurStyle(style, {
      colorMode: ThemeColorMode.LIGHT,
      adaptiveColor: AdaptiveColor.DEFAULT,
      scale: 0.1
    })
    // Column() {
    //   Column() {
    //     Text(title)
    //       .fontSize(6)
    //       .fontColor(Color.White)
    //       .textAlign(TextAlign.Center)
    //       .width('100%')
    //       .height('100%')
    //   }
    //   .height(this.gridSize)
    //   // .aspectRatio(1)
    //   .borderRadius(10)
    //   .backgroundImage($r('app.media.img_8'))
    //   // .backgroundBlurStyle(style, {
    //   //   colorMode: ThemeColorMode.LIGHT,
    //   //   adaptiveColor: AdaptiveColor.DEFAULT,
    //   //   scale: 0.1
    //   // })
    //
    //   Text(title)
    //     .fontSize(6)
    //     .fontColor(Color.Black)
    // }
    // .width(this.gridSize)
    // .height(this.gridSize)
    // .justifyContent(FlexAlign.Start)
  }
}