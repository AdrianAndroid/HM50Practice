import Constants from '../../common/Constants';
import { LengthMetrics, LengthUnit, router } from '@kit.ArkUI';

@Builder
export function PageBuilder(name: string, param: Object) {
  SwiperExamplePage()
}

@Component
struct SwiperExamplePage {
  @State message: string = 'Hello World';
  @State backgroundColors: Color[] = [Color.Green, Color.Blue, Color.Yellow, Color.Pink, Color.Gray, Color.Orange]
  @State opacityList: number[] = []
  @State scaleList: number[] = []
  @State translateList: number[] = []
  @State zIndexList: number[] = []
  // 页面切换方式
  private swiperController: SwiperController = new SwiperController();
  private DISPLAY_COUNT: number = 2
  private MIN_SCALE: number = 0.75
  @StorageProp('bottomRectHeight') bottomRectHeight: number = 0;
  @StorageProp('topRectHeight') topRectHeight: number = 0;
  pathStack: NavPathStack = new NavPathStack()
  @State currentIndex: number = 6

  aboutToAppear(): void {
    for (let i = 0; i < this.backgroundColors.length; i++) {
      this.opacityList.push(1.0)
      this.scaleList.push(1.0)
      this.translateList.push(0.0)
      this.zIndexList.push(0)
    }
  }

  @Builder
  private buildTitleRadio(text: string, index: number) {
    Column() {
      Text(text).fontSize('20fp')
      Radio({ value: text, group: 'radioGroup' })
        .checked(this.currentIndex === index)
        .onChange((isCheck) => {
          if (isCheck) {
            this.currentIndex = index
          }
        })
    }
  }

  build() {
    NavDestination() {
      Column() {
        Flex({wrap: FlexWrap.Wrap}) {
          this.buildTitleRadio('1', 1)
          this.buildTitleRadio('2', 2)
          this.buildTitleRadio('3', 3)
          this.buildTitleRadio('4', 4)
          this.buildTitleRadio('5', 5)
          this.buildTitleRadio('6', 6)
          this.buildTitleRadio('7', 7)
        }
        Stack() {
          if (this.currentIndex === 1) {
            this.example1()
          } else if(this.currentIndex === 2) {
            this.example2()
          } else if(this.currentIndex === 3) {
            this.example3()
          } else if(this.currentIndex === 4){
            this.example4()
          } else if(this.currentIndex === 5) {
            this.example5()
          } else if(this.currentIndex === 6) {
            this.example6()
          } else if(this.currentIndex == 7) {
            Button('跳转到ShortVideo')
              .onClick(() => {
                router.pushUrl({ url: 'pages/swiper/SwiperShortVideoPage' });
              })
          }
        }
        .width(Constants.FULL_WIDTH)
        .layoutWeight(1)
      }
      .height('100%')
      .width('100%')
    }
    .margin({
      top: this.getUIContext().px2vp(this.topRectHeight),
      bottom: this.getUIContext().px2vp(this.bottomRectHeight)
    })
    .title(Constants.NavigationListExamplePage)
    .hideTitleBar(false)
    .hideToolBar(false)
    .onReady((pathStack) => {
      this.pathStack = pathStack.pathStack
    })
    .width('100%')
    .height('100%')
  }

  @Builder
  example6() {
    Swiper() {
      Text('0')
        .width('90%')
        .height('100%')
        .backgroundColor(Color.Gray)
        .textAlign(TextAlign.Center)
        .fontSize(30)

      Text('1')
        .width('90%')
        .height('100%')
        .backgroundColor(Color.Green)
        .textAlign(TextAlign.Center)
        .fontSize(30)

      Text('2')
        .width('90%')
        .height('100%')
        .backgroundColor(Color.Pink)
        .textAlign(TextAlign.Center)
        .fontSize(30)
    }
    .indicator(
      Indicator.dot()
        .right(0)
        .itemWidth(15)
        .itemHeight(15)
        .selectedItemWidth(30)
        .selectedItemHeight(15)
        .color(Color.Red)
        .selectedColor(Color.Blue)
    )
    .height(300)
    .loop(true)
    .autoPlay(true)
    .interval(3000)
  }

  @State five_space: LengthMetrics = LengthMetrics.vp(0);
  @State five_spacePool: LengthMetrics[] = [LengthMetrics.vp(0), LengthMetrics.px(3), LengthMetrics.vp(10)];
  @State five_spaceIndex: number = 0;
  @State five_ignoreSize: boolean = false;
  @State five_ignoreSizePool: boolean[] = [false, true];
  @State five_ignoreSizeIndex: number = 0;
  private five_swiperController1: SwiperController = new SwiperController();
  private five_data1: MyDataSource = new MyDataSource();


  // 保持可见内容位置不变
  @Builder
  example5() {
    Scroll() {
      Column({ space: 20 }) {
        Swiper(this.five_swiperController1) {
          LazyForEach(this.five_data1, (item: string) => {
            Text(item.toString())
              .width('90%')
              .height(120)
              .backgroundColor(0xAFEEEE)
              .textAlign(TextAlign.Center)
              .fontSize(30)
          }, (item: string) => item)
        }
        .indicator(
          new DotIndicator()
            // .space('this.space')
            .bottom(0)
            .itemWidth(15)
            .itemHeight(15)
            .selectedItemWidth(15)
            .selectedItemHeight(15)
            .color(Color.Gray)
            .selectedColor(Color.Blue)
        )
        .displayArrow({
          showBackground: true,
          isSidebarMiddle: true,
          backgroundSize: 24,
          backgroundColor: Color.White,
          arrowSize: 18,
          arrowColor: Color.Blue
        }, false)

        Column({ space: 4 }) {
          Button('spaceIndex:' + this.five_spaceIndex).onClick(() => {
            this.five_spaceIndex = (this.five_spaceIndex + 1) % this.five_spacePool.length;
            this.five_space = this.five_spacePool[this.five_spaceIndex];
          }).margin(10)

          Button('ignoreSizeIndex:' + this.five_ignoreSizeIndex).onClick(() => {
            this.five_ignoreSizeIndex = (this.five_ignoreSizeIndex + 1) % this.five_ignoreSizePool.length;
            this.five_ignoreSize = this.five_ignoreSizePool[this.five_ignoreSizeIndex];
          }).margin(10)
        }.margin(2)
      }.width('100%')
    }
  }

  // 自定义切换动画
  @Builder
  example4() {
    Column() {
      Swiper() {
        ForEach(this.backgroundColors, (backgroundColor: Color, index: number) => {
          Text(index.toString())
            .width('100%')
            .height('100%')
            .fontSize(50)
            .textAlign(TextAlign.Center)
            .backgroundColor(backgroundColor)
            .opacity(this.opacityList[index])
            .scale({ x: this.scaleList[index], y: this.scaleList[index] })
            .translate({ x: this.translateList[index] })
            .zIndex(this.zIndexList[index])
        })
      }
      .height(300)
      .indicator(false)
      .displayCount(this.DISPLAY_COUNT, true)
      .loop(true)
      .autoPlay(true)
      .customContentTransition({
        timeout: 1000,
        transition: (proxy: SwiperContentTransitionProxy) => {
          if (proxy.position <= proxy.index % this.DISPLAY_COUNT ||
            proxy.position >= this.DISPLAY_COUNT + proxy.index % this.DISPLAY_COUNT) {
            // 同组页面完全滑出视窗外时，重置属性值
            this.opacityList[proxy.index] = 1.0
            this.scaleList[proxy.index] = 1.0
            this.translateList[proxy.index] = 0.0
            this.zIndexList[proxy.index] = 0
          } else {
            // 同组页面未滑出视窗外时，对同组中左右两个页面，逐帧根据position修改属性值
            if (proxy.index % this.DISPLAY_COUNT === 0) {
              this.opacityList[proxy.index] = 1 - proxy.position / this.DISPLAY_COUNT
              this.scaleList[proxy.index] = this.MIN_SCALE + (1 - this.MIN_SCALE) * (1 - proxy.position / this.DISPLAY_COUNT)
              this.translateList[proxy.index] = -proxy.position * proxy.mainAxisLength + (1 - this.scaleList[proxy.index]) * proxy.mainAxisLength / 2.0
            } else {
              this.opacityList[proxy.index] = 1 - (proxy.position - 1) / this.DISPLAY_COUNT
              this.scaleList[proxy.index] = this.MIN_SCALE + (1 - this.MIN_SCALE) * (1 - (proxy.position - 1) / this.DISPLAY_COUNT)
              this.translateList[proxy.index] = -(proxy.position - 1) * proxy.mainAxisLength - (1 - this.scaleList[proxy.index]) * proxy.mainAxisLength / 2.0
            }
            this.zIndexList[proxy.index] = -1
          }
        }
      })
    }.width('100%')
  }

  // 每页显示多个子页面
  @Builder
  example3() {
    Swiper() {
      Text('0')
        .width(250)
        .height(250)
        .backgroundColor(Color.Gray)
        .textAlign(TextAlign.Center)
        .fontSize(30)
      Text('1')
        .width(250)
        .height(250)
        .backgroundColor(Color.Green)
        .textAlign(TextAlign.Center)
        .fontSize(30)
      Text('2')
        .width(250)
        .height(250)
        .backgroundColor(Color.Pink)
        .textAlign(TextAlign.Center)
        .fontSize(30)
      Text('3')
        .width(250)
        .height(250)
        .backgroundColor(Color.Blue)
        .textAlign(TextAlign.Center)
        .fontSize(30)
    }
    .indicator(true)
    .displayArrow(true)
    .displayCount(2)
  }

  @Builder
  example2() {
    Column({ space: 5 }) {
      Swiper(this.swiperController) {
        Text('0')
          .width(Constants.FULL_PERCENT)
          .height(Constants.FULL_PERCENT)
          .height(250)
          .backgroundColor(Color.Gray)
          .textAlign(TextAlign.Center)
          .fontSize(30)
        Text('1')
          .width(Constants.FULL_PERCENT)
          .height(Constants.FULL_PERCENT)
          .backgroundColor(Color.Green)
          .textAlign(TextAlign.Center)
          .fontSize(30)
        Text('2')
          .width(Constants.FULL_PERCENT)
          .height(Constants.FULL_PERCENT)
          .backgroundColor(Color.Pink)
          .textAlign(TextAlign.Center)
          .fontSize(30)
      }
      .width(250)
      .height(250)
      .indicator(true)
      .displayArrow({ isSidebarMiddle: true }, false)
      // 轮播芳香
      .vertical(true)

      Row({ space: 12 }) {
        Button('showNext')
          .onClick(() => {
            this.swiperController.showNext(); // 通过controller切换到后一页
          })
        Button('showPrevious')
          .onClick(() => {
            this.swiperController.showPrevious(); // 通过controller切换到前一页
          })
      }.margin(5)
    }.width('100%')
    .margin({ top: 5 })
  }

  // 循环播放
  @Builder
  example1() {
    Swiper() {
      Text('0')
        .width('90%')
        .height('100%')
        .backgroundColor(Color.Gray)
        .textAlign(TextAlign.Center)
        .fontSize(30)


      Text('1')
        .width('90%')
        .height('100%')
        .backgroundColor(Color.Green)
        .textAlign(TextAlign.Center)
        .fontSize(30)


      Text('2')
        .width('90%')
        .height('100%')
        .backgroundColor(Color.Pink)
        .textAlign(TextAlign.Center)
        .fontSize(30)
    }
    .loop(true)
    // 自动轮播
    .autoPlay(true)
    .interval(1000) // 默认3秒
    // 自定义导航样式
    .indicator(
      Indicator.dot()
        .left(0)
        .itemWidth(15)
        .itemHeight(15)
        .selectedItemWidth(30)
        .selectedItemHeight(15)
        .color(Color.Red)
        .selectedColor(Color.Blue)
    )
    // 箭头使用样式
    .displayArrow(
      {
        showBackground: true,
        isSidebarMiddle: true, // 是否显示在中间部分
        backgroundSize: 24,
        backgroundColor: Color.White,
        arrowSize: 18,
        arrowColor: Color.Blue
      },
      false)
  }
}

class MyDataSource implements IDataSource {
  private list: number[] = [];

  constructor() {
    let list1: number[] = [];
    for (let i = 1; i <= 10; i++) {
      list1.push(i);
    }
    this.list = list1
  }

  totalCount(): number {
    return this.list.length;
  }

  getData(index: number): number {
    return this.list[index];
  }

  registerDataChangeListener(listener: DataChangeListener): void {
  }

  unregisterDataChangeListener() {
  }
}