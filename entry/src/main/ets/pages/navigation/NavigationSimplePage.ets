@Entry
@Component
struct NavigationSimplePage {
  @State TooTmp: ToolbarItem = {
    'value': "func", 'icon': "./image/ic_public_highlights.svg", 'action': () => {
    }
  }
  @Provide('pageInfos') pageInfos: NavPathStack = new NavPathStack()
  private mode = NavigationMode.Split
  private titleMode = NavigationTitleMode.Full
  private arr: number[] = [1, 2, 3];
  @StorageProp('bottomRectHeight') bottomRectHeight: number = 0;
  @StorageProp('topRectHeight') topRectHeight: number = 0;
  @Builder
  PageMap(name: string) {
    if (name === "NavDestinationTitle1") {
      pageOneTmp();
    } else if (name === "NavDestinationTitle2") {
      pageTwoTmp();
    } else if (name === "NavDestinationTitle3") {
      pageThreeTmp();
    }
  }

  onPageShow(): void {
    const params = this.getUIContext().getRouter().getParams() as Record<string, string>
    if (params) {
      const mode: number = parseInt(params.mode)
      switch (mode) {
        case NavigationMode.Stack.valueOf():
          this.mode = NavigationMode.Stack
          break;
        case NavigationMode.Split.valueOf():
          this.mode = NavigationMode.Split
          break
        case NavigationMode.Auto.valueOf():
          this.mode = NavigationMode.Auto
          break
      }
      const titleMode: number = parseInt(params.titleMode)
      switch (titleMode) {
        case NavigationTitleMode.Free.valueOf():
          this.titleMode = NavigationTitleMode.Free
          break;
        case NavigationTitleMode.Mini.valueOf():
          this.titleMode = NavigationTitleMode.Mini
          break
        case NavigationTitleMode.Mini.valueOf():
          this.titleMode = NavigationTitleMode.Mini
          break
      }
    }
  }


  build() {
    Column() {
      Navigation(this.pageInfos) {
        TextInput({ placeholder: 'search...' })
          .width("90%")
          .height(40)
          .backgroundColor(Color.White)

        List({ space: 12 }) {
          ForEach(this.arr, (item: number) => {
            ListItem() {
              Text("Page" + item)
                .width("100%")
                .height(72)
                .backgroundColor(Color.White)
                .borderRadius(24)
                .fontSize(16)
                .fontWeight(500)
                .textAlign(TextAlign.Center)
                .onClick(() => {
                  this.pageInfos.pushPath({ name: "NavDestinationTitle" + item });
                })
            }
          }, (item: number) => item.toString())
        }
        .width("90%")
        .height('100%')
        .margin({ top: 12 })
      }
      .title("主标题")
      .mode(this.mode)
      .titleMode(this.titleMode)
      .navDestination(this.PageMap)
      .menus([
        {
          value: "1", icon: $r('sys.media.ohos_ic_public_search_filled'), action: () => {
        }
        },
        {
          value: "2", icon: $r('sys.media.ohos_ic_public_add'), action: () => {
        }
        },
        {
          value: "3", icon: $r('sys.media.ohos_ic_public_add'), action: () => {
        }
        },
        {
          value: "4", icon: $r('sys.media.ohos_ic_public_add'), action: () => {
        }
        },
        {
          value: "5", icon:$r('sys.media.ohos_ic_public_add'), action: () => {
        }
        }
      ])
      .toolbarConfiguration([this.TooTmp, this.TooTmp, this.TooTmp])
      .margin({
        top: this.getUIContext().px2vp(this.topRectHeight),
        bottom: this.getUIContext().px2vp(this.bottomRectHeight)
      })
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#F1F3F5')
  }
}


// PageOne.ets
@Component
export struct pageOneTmp {
  @Consume('pageInfos') pageInfos: NavPathStack;


  build() {
    NavDestination() {
      Column() {
        Text("NavDestinationContent1")
      }.width('100%').height('100%')
    }.title("NavDestinationTitle1")
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo));
      return true;
    })
  }
}


// PageTwo.ets
@Component
export struct pageTwoTmp {
  @Consume('pageInfos') pageInfos: NavPathStack;


  build() {
    NavDestination() {
      Column() {
        Text("NavDestinationContent2")
      }.width('100%').height('100%')
    }.title("NavDestinationTitle2")
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo));
      return true;
    })
  }
}


// PageThree.ets
@Component
export struct pageThreeTmp {
  @Consume('pageInfos') pageInfos: NavPathStack;


  build() {
    NavDestination() {
      Column() {
        Text("NavDestinationContent3")
      }.width('100%').height('100%')
    }.title("NavDestinationTitle3")
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo));
      return true;
    })
  }
}