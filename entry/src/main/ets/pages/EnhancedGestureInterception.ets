@Entry
@Component
struct EnhancedGestureInterception {
  build() {
    Stack() {
      MultiTabsPageGesture()
      // MultiTabsPage()
      // EnhancedGestureInterception111()
      // TabsExample()
      // ScrollControlExample()
      //   .borderWidth(2)
      //   .width(300)
      //   .height(300)
    }
    .alignContent(Alignment.Center)

  }
}


@Component
struct MultiTabsPageGesture {
  @State currentIndex: number = 0;
  @State selectedIndex: number = 0;
  @State fontColor: string = '#182431';
  @State selectedFontColor: string = '#007DFF';
  controller?: TabsController = new TabsController();

  @Builder
  tabBuilder(index: number, name: string) {
    Column() {
      Text(name)
        .fontColor(this.selectedIndex === index ? this.selectedFontColor : this.fontColor)
        .fontSize(16)
        .fontWeight(this.selectedIndex === index ? 500 : 400)
        .lineHeight(22)
        .margin({ top: 17, bottom: 7 })
      Divider()
        .strokeWidth(2)
        .color('#007DFF')
        .opacity(this.selectedIndex === index ? 1 : 0)
    }.width('100%')
  }

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.Start, index: this.currentIndex, controller: this.controller }) {
        TabContent() {
          Column().width('100%').height('100%').backgroundColor(Color.Green)
        }.tabBar(this.tabBuilder(0, 'green'))

        TabContent() {
          InnerTabs()
        }.tabBar(this.tabBuilder(1, 'blue and pink'))

        TabContent() {
          Column().width('100%').height('100%').backgroundColor(Color.Brown)
        }.tabBar(this.tabBuilder(2, 'brown'))
      }
      .onAnimationStart((index: number, targetIndex: number, event: TabsAnimationEvent) => {
        // 切换动画开始时触发该回调。目标页签显示下划线。
        this.selectedIndex = targetIndex
      })
    }
  }
}

@Component
struct InnerTabs {
  innerSelectedIndex: number = 0; // 记录内层Tabs的索引

  build() {
    Tabs() {
      TabContent() {
        Column().width('100%').height('100%').backgroundColor(Color.Blue)
      }.tabBar(new SubTabBarStyle('blue'))

      TabContent() {
        InnerTabs2()
      }.tabBar(new SubTabBarStyle('blue'))

      TabContent() {
        Column().width('100%').height('100%').backgroundColor(Color.Pink)
      }.tabBar(new SubTabBarStyle('pink'))
    }
    .onAnimationStart((index: number, targetIndex: number) => {
      console.info('ets onGestureRecognizerJudgeBegin child:' + targetIndex)
      this.innerSelectedIndex = targetIndex
    })
    .onGestureRecognizerJudgeBegin((event: BaseGestureEvent, current: GestureRecognizer,
      others: Array<GestureRecognizer>): GestureJudgeResult => { // 在识别器即将要成功时，根据当前组件状态，设置识别器使能状态
      console.info('ets onGestureRecognizerJudgeBegin child')
      if (current) {
        let target = current.getEventTargetInfo();
        if (target && current.isBuiltIn() && current.getType() == GestureControl.GestureType.PAN_GESTURE) {
          console.info('ets onGestureRecognizerJudgeBegin child PAN_GESTURE')
          let panEvent = event as PanGestureEvent;
          if (panEvent && panEvent.velocityX < 0 && this.innerSelectedIndex === 2) { // 内层Tabs滑动到尽头
            console.info('ets onGestureRecognizerJudgeBegin child reject end')
            return GestureJudgeResult.REJECT;
          }
          if (panEvent && panEvent.velocityX > 0 && this.innerSelectedIndex === 0) { // 内层Tabs滑动到开头
            console.info('ets onGestureRecognizerJudgeBegin child reject begin')
            return GestureJudgeResult.REJECT;
          }
        }
      }
      return GestureJudgeResult.CONTINUE;
    }, true)
  }
}

@Component
struct InnerTabs2 {
  innerSelectedIndex: number = 0; // 记录内层Tabs的索引

  build() {
    Tabs() {
      TabContent() {
        Column().width('100%').height('100%').backgroundColor(Color.Blue)
      }.tabBar(new SubTabBarStyle('blue'))

      TabContent() {
        Column().width('100%').height('100%').backgroundColor(Color.Pink)
      }.tabBar(new SubTabBarStyle('pink'))
    }
    .onAnimationStart((index: number, targetIndex: number) => {
      console.info('ets onGestureRecognizerJudgeBegin child:' + targetIndex)
      this.innerSelectedIndex = targetIndex
    })
    .onGestureRecognizerJudgeBegin((event: BaseGestureEvent, current: GestureRecognizer,
      others: Array<GestureRecognizer>): GestureJudgeResult => { // 在识别器即将要成功时，根据当前组件状态，设置识别器使能状态
      console.info('ets onGestureRecognizerJudgeBegin child')
      if (current) {
        let target = current.getEventTargetInfo();
        if (target && current.isBuiltIn() && current.getType() == GestureControl.GestureType.PAN_GESTURE) {
          console.info('ets onGestureRecognizerJudgeBegin child PAN_GESTURE')
          let panEvent = event as PanGestureEvent;
          if (panEvent && panEvent.velocityX < 0 && this.innerSelectedIndex === 1) { // 内层Tabs滑动到尽头
            console.info('ets onGestureRecognizerJudgeBegin child reject end')
            return GestureJudgeResult.REJECT;
          }
          if (panEvent && panEvent.velocityX > 0 && this.innerSelectedIndex === 0) { // 内层Tabs滑动到开头
            console.info('ets onGestureRecognizerJudgeBegin child reject begin')
            return GestureJudgeResult.REJECT;
          }
        }
      }
      return GestureJudgeResult.CONTINUE;
    }, true)
  }
}


@Component
struct MultiTabsPage {
  @State currentIndex: number = 1;
  @State subCurrentIndex: number = 0;
  private fontColor: string = '#182431';
  private selectedFontColor: string = '#007DFF';
  private controller: TabsController = new TabsController();
  private subController: TabsController = new TabsController();
  private panOptionLeft: PanGestureOptions = new PanGestureOptions({ direction: PanDirection.Left });
  private panOptionRight: PanGestureOptions = new PanGestureOptions({ direction: PanDirection.Right });
  @Builder
  tabBuilder(index: number, name: string) {
    Column() {
      Text(name)
        .fontColor(this.currentIndex === index ? this.selectedFontColor : this.fontColor)
        .fontSize(16)
        .fontWeight(this.currentIndex === index ? 500 : 400)
        .lineHeight(22)
        .margin({ top: 17, bottom: 7 })
      Divider()
        .strokeWidth(2)
        .color('#007DFF')
        .opacity(this.currentIndex === index ? 1 : 0)
    }.width('100%')
  }
  @Builder
  subTabBuilder(index: number, name: string) {
    Column() {
      Text(name)
        .fontColor(this.subCurrentIndex === index ? this.selectedFontColor : this.fontColor)
        .fontSize(16)
        .fontWeight(this.subCurrentIndex === index ? 500 : 400)
        .lineHeight(22)
        .margin({ top: 17, bottom: 7 })
      Divider()
        .strokeWidth(2)
        .color('#007DFF')
        .opacity(this.subCurrentIndex === index ? 1 : 0)
    }.width('100%')
  }
  build() {
    Column() {
      // 一级Tab
      Tabs({ barPosition: BarPosition.Start, index: this.currentIndex, controller: this.controller }) {
        TabContent() {
          Column() {
            Text('首页内容')
          }
          .width('100%')
          .height('100%')
          .backgroundColor('#ffb554d7')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        }.tabBar(this.tabBuilder(0, '首页'))
        TabContent() {
          Column() {
            Tabs({ barPosition: BarPosition.Start, controller: this.subController }) {
              TabContent() {
                Column().width('100%').height('100%').backgroundColor('#00CB87')
              }.tabBar(this.subTabBuilder(0, 'green'))
              // 关键代码
              // .gesture(
              //   PanGesture(this.panOptionRight)
              //     .onActionEnd(() => {
              //       this.controller.changeIndex(0)
              //     })
              // )
              TabContent() {
                Column().width('100%').height('100%').backgroundColor('#007DFF')
              }.tabBar(this.subTabBuilder(1, 'blue'))
              TabContent() {
                Column().width('100%').height('100%').backgroundColor('#FFBF00')
              }.tabBar(this.subTabBuilder(2, 'yellow'))
              TabContent() {
                Column().width('100%').height('100%').backgroundColor('#E67C92')
              }.tabBar(this.subTabBuilder(3, 'pink'))
              // 关键代码
              // .gesture(
              //   PanGesture(this.panOptionLeft)
              //     .onActionEnd(() => {
              //       this.controller.changeIndex(2)
              //     })
              // )
            }
            .animationDuration(400)
            .onChange((index: number) => {
              this.subCurrentIndex = index;
            })
            .width(360)
            .backgroundColor('#F1F3F5')
          }
          .width('100%').height('100%').backgroundColor('#00CB87')
        }.tabBar(this.tabBuilder(1, '详情'))
        TabContent() {
          Column() {
            Text('我的内容')
          }
          .width('100%')
          .height('100%')
          .backgroundColor('#ffc19757')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        }.tabBar(this.tabBuilder(2, '我的'))
      }
      .onChange((index: number) => {
        this.currentIndex = index
      })
      .width(360)
      .height(296)
      .backgroundColor('#F1F3F5')
    }.width('100%')
  }
}

@Component
struct ScrollControlExample {
  private canScroll: boolean = true; // 滚动控制标志位
  private lastX: number = 0; // 触摸位置记录
  private scroller: Scroller = new Scroller(); // 滚动控制器

  build() {
    Column() {
      // Tabs组件配置
      Tabs({ barPosition: BarPosition.Start }) {
        TabContent() {
          Text('内容区域1').fontSize(20)
        }.tabBar('Tab1')

        TabContent() {
          Text('内容区域2').fontSize(20)
        }.tabBar('Tab2')
      }
      .edgeEffect(EdgeEffect.None) // 禁用边缘弹性
      .animationDuration(0) // 关闭切换动画
      // .enableScrollInteraction(this.canScroll) // 动态控制滚动
      .scrollable(this.canScroll)
      // .onWillScroll((offset: number, state: ScrollState) => { // 滚动前回调
      //   if (offset < -vp2px(100) && !this.canScroll) {
      //     this.scroller.scrollTo({ x: 0, y: 0 }); // 强制复位
      //   }
      // })
      .onTouch((event: TouchEvent) => { // 触摸事件处理
        if (event.type === TouchType.Move) {
          const deltaX = event.touches[0].x - this.lastX;

          // 左滑超过阈值时停止滚动
          if (deltaX < -vp2px(50)) {
            this.canScroll = false;
            event.stopPropagation();
            this.scroller.scrollEdge(Edge.End); // 消除惯性
          }
          this.lastX = event.touches[0].x; // 更新位置
        }
      })
      // .nestedScroll({
      //   scrollForward: NestedScrollMode.PARENT_FIRST,
      //   scrollBackward: NestedScrollMode.SELF_FIRST
      // })
    }
  }
}

@Component
struct TabsExample {
  @State currentIndex: number = 0
  private tabsController: TabsController = new TabsController()
  private tabData: string[] = ['Tab1', 'Tab2', 'Tab3', 'Tab4', 'Tab5']

  build() {
    Column() {
      Tabs({
        barPosition: BarPosition.Start,
        controller: this.tabsController
      }) {
        ForEach(this.tabData, (item: string, index: number) => {
          TabContent() {
            Column() {
              Text(`${item} Content`)
                .fontSize(20)
                .fontColor('#333')
              Text('这是内容区域')
                .fontSize(16)
                .margin({ top: 20 })
            }
            .width('100%')
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .backgroundColor(index % 2 === 0 ? '#f0f0f0' : '#e0e0e0')
          }
          .tabBar(item)
          .width(index === this.tabData.length - 1 ? '33.33%' : '100%') // 最后一个只显示1/3
        })
      }
      .vertical(false)
      .scrollable(true)
      .barMode(BarMode.Scrollable)
      .onChange((index: number) => {
        this.currentIndex = index
      })
      .width('100%')
      .height('100%')
    }
  }
}

@Component
struct EnhancedGestureInterception111 {
  @State currentIndex: number = 0;
  @State selectedIndex: number = 0;
  @State fontColor: string = '#182431';
  @State selectedFontColor: string = '#007DFF';
  innerSelectedIndex: number = 0; // 记录内层Tabs的索引
  controller?: TabsController = new TabsController();

  @Builder
  tabBuilder(index: number, name: string) {
    Column() {
      Text(name)
        .fontColor(this.selectedIndex === index ? this.selectedFontColor : this.fontColor)
        .fontSize(16)
        .fontWeight(this.selectedIndex === index ? 500 : 400)
        .lineHeight(22)
        .margin({ top: 17, bottom: 7 })
      Divider()
        .strokeWidth(2)
        .color('#007DFF')
        .opacity(this.selectedIndex === index ? 1 : 0)
    }.width('100%')
  }

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.Start, index: this.currentIndex, controller: this.controller }) {
        TabContent() {
          Column().width('100%').height('100%').backgroundColor(Color.Green)
        }.tabBar(this.tabBuilder(0, 'green'))

        TabContent() {
          Tabs() {
            TabContent() {
              Column().width('100%').height('100%').backgroundColor(Color.Blue)
            }.tabBar(new SubTabBarStyle('blue'))

            TabContent() {
              Column().width('100%').height('100%').backgroundColor(Color.Pink)
            }.tabBar(new SubTabBarStyle('pink'))
          }
          .onAnimationStart((index: number, targetIndex: number) => {
            console.info('ets onGestureRecognizerJudgeBegin child:' + targetIndex)
            this.innerSelectedIndex = targetIndex
          })
          .onGestureRecognizerJudgeBegin((event: BaseGestureEvent, current: GestureRecognizer,
            others: Array<GestureRecognizer>): GestureJudgeResult => { // 在识别器即将要成功时，根据当前组件状态，设置识别器使能状态
            console.info('ets onGestureRecognizerJudgeBegin child')
            if (current) {
              let target = current.getEventTargetInfo();
              if (target && current.isBuiltIn() && current.getType() == GestureControl.GestureType.PAN_GESTURE) {
                console.info('ets onGestureRecognizerJudgeBegin child PAN_GESTURE')
                let panEvent = event as PanGestureEvent;
                if (panEvent && panEvent.velocityX < 0 && this.innerSelectedIndex === 1) { // 内层Tabs滑动到尽头
                  console.info('ets onGestureRecognizerJudgeBegin child reject end')
                  return GestureJudgeResult.REJECT;
                }
                if (panEvent && panEvent.velocityX > 0 && this.innerSelectedIndex === 0) { // 内层Tabs滑动到开头
                  console.info('ets onGestureRecognizerJudgeBegin child reject begin')
                  return GestureJudgeResult.REJECT;
                }
              }
            }
            return GestureJudgeResult.CONTINUE;
          }, true)
        }.tabBar(this.tabBuilder(1, 'blue and pink'))

        TabContent() {
          Column().width('100%').height('100%').backgroundColor(Color.Brown)
        }.tabBar(this.tabBuilder(2, 'brown'))
      }
      .onAnimationStart((index: number, targetIndex: number, event: TabsAnimationEvent) => {
        // 切换动画开始时触发该回调。目标页签显示下划线。
        this.selectedIndex = targetIndex
      })
    }
  }
}