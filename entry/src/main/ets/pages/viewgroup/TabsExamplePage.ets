import Constants from '../../common/Constants';

@Entry
@Component
struct TabsExamplePage {
  @State message: string = 'Hello World';
  @State currentIndex: number = 0;
  private controller: TabsController = new TabsController()

  build() {
    Stack() {
      this.example5()
    }
    .height('100%')
    .width('100%')
  }

  // 通过TabsController的changeIndex方法来实现跳转至指定索引值对应的TabContent内容。
  @Builder
  example5() {
    Column() {
      Tabs({ barPosition: BarPosition.End, index: this.currentIndex, controller: this.controller }) {
        TabContent() {
          Text('首页').fontSize(30)
        }.tabBar(this.example4TabBuilder('首页', 0))

        TabContent() {
          Text('发现').fontSize(30)
        }.tabBar(this.example4TabBuilder('发现', 1))

        TabContent() {
          Text('推荐').fontSize(30)
        }.tabBar(this.example4TabBuilder('推荐', 2))

        TabContent() {
          Text('我的').fontSize(30)
        }.tabBar(this.example4TabBuilder('我的', 3))
      }
      .height(600)
      .onChange((index: number) => {
        this.currentIndex = index
      })
      // 设置自定义拦截毁掉函数
      .onContentWillChange((curindex, toIndex) => {
        if (toIndex == 2) {
          return false
        } else {
          return true
        }
      })

      Button('动态修改index').width('50%').margin({ top: 20 })
        .onClick(() => {
          this.currentIndex = (this.currentIndex + 1) % 4
        })

      Button('changeIndex').width('50%').margin({ top: 20 })
        .onClick(() => {
          let index = (this.currentIndex + 1) % 4
          this.controller.changeIndex(index)
        })

    }
  }

  @Builder
  example4TabBuilder(title: string, targetIndex: number) {
    Column() {
      Text(title)
        .fontColor(this.currentIndex === targetIndex ? '#1698CE' : '#6B6B6B')
    }
  }

  @Builder
  example4() {
    Column() {
      Tabs({ barPosition: BarPosition.End }) {
        TabContent() {
          Text('首页').fontSize(30)
        }.tabBar(this.example4TabBuilder('首页', 0))

        TabContent() {
          Text('发现').fontSize(30)
        }.tabBar(this.example4TabBuilder('发现', 1))

        TabContent() {
          Text('推荐').fontSize(30)
        }.tabBar(this.example4TabBuilder('推荐', 2))

        TabContent() {
          Text('我的').fontSize(30)
        }.tabBar(this.example4TabBuilder('我的', 3))
      }
      .animationDuration(0)
      .backgroundColor('#F1F3F5')
      .onChange((index: number) => {
        this.currentIndex = index
      })
    }.width('100%')
  }

  @Builder
  example3TabBuilder(title: string, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectedImg : normalImg)
        .size({ width: 25, height: 25 })
      Text(title)
        .fontColor(this.currentIndex === targetIndex ? '#1698CE' : '#6B6B6B')
    }
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.Center)
  }

  // 自定义导航栏
  @Builder
  example3() {
    Tabs({ barPosition: BarPosition.End }) {
      TabContent() {
        Column() {
          Text('我的内容')
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#007DFF')
      }
      .tabBar(this.example3TabBuilder('我的', 0, $r('app.media.mine_selected'), $r('app.media.mine_normal')))
    }
  }

  @Builder
  example2() {
    Tabs({ barPosition: BarPosition.Start }) {
      TabContent() {
        Text('首页的内容').fontSize(30)
      }
      .backgroundColor(Color.Red)
      .tabBar('首页')


      TabContent() {
        Text('推荐的内容').fontSize(30)
      }
      .backgroundColor(Color.Green)
      .tabBar('推荐')


      TabContent() {
        Text('发现的内容').fontSize(30)
      }
      .backgroundColor(Color.Blue)
      .tabBar('发现')

      TabContent() {
        Text('我的内容').fontSize(30)
      }
      .backgroundColor(Color.Yellow)
      .tabBar("我的")

      TabContent() {
        Text('我的内容').fontSize(30)
      }
      .backgroundColor(Color.Yellow)
      .tabBar("我的")

      TabContent() {
        Text('我的内容').fontSize(30)
      }
      .backgroundColor(Color.Yellow)
      .tabBar("我的")

      TabContent() {
        Text('我的内容').fontSize(30)
      }
      .backgroundColor(Color.Yellow)
      .tabBar("我的")

      TabContent() {
        Text('我的内容').fontSize(30)
      }
      .backgroundColor(Color.Yellow)
      .tabBar("我的")

      TabContent() {
        Text('我的内容').fontSize(30)
      }
      .backgroundColor(Color.Yellow)
      .tabBar("我的")

      TabContent() {
        Text('我的内容').fontSize(30)
      }
      .backgroundColor(Color.Yellow)
      .tabBar("我的")

      TabContent() {
        Text('我的内容').fontSize(30)
      }
      .backgroundColor(Color.Yellow)
      .tabBar("我的")
    }
    .scrollable(false) // 限制导航栏的滑动切换
    //.barMode(BarMode.Fixed) // 固定导航栏
    .barMode(BarMode.Scrollable) // 滚动导航栏
    .vertical(false) // 导航栏的方向
    // .barWidth(100)
    // .barHeight(200)
    .margin({ top: 56 })
    .width(Constants.FULL_PERCENT)
    .height(Constants.FULL_PERCENT)
  }

  @Builder
  example1() {
    TabContent() {
      Text('首页的内容').fontSize(30)
    }
    .tabBar('首页')
  }
}