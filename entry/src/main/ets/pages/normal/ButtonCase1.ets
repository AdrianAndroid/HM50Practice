import Constants from "../../common/Constants";

// xxx.ets
@Entry
@Component
struct ButtonCase1 {
  pathStack: NavPathStack = new NavPathStack();

  @Builder
  PageMap(name: string) {
    if (name === "first_page") {
      pageOneTmp()
    } else if (name === "second_page") {
      pageTwoTmp()
    } else if (name === "third_page") {
      pageThreeTmp()
    }
  }

  build() {
    Navigation(this.pathStack) {
      List({ space: 4 }) {
        ListItem() {
          Button("First").onClick(() => {
            this.pathStack.pushPath({ name: "first_page" })
          })
            .width('100%')
        }


        ListItem() {
          Button("Second").onClick(() => {
            this.pathStack.pushPath({ name: "second_page" })
          })
            .width('100%')
        }


        ListItem() {
          Button("Third").onClick(() => {
            this.pathStack.pushPath({ name: "third_page" })
          })
            .width('100%')
        }
      }
      .width(Constants.FULL_WIDTH)
      .height(Constants.FULL_HEIGHT)
      .listDirection(Axis.Vertical)
      .backgroundColor(0xDCDCDC)
      .padding(20)
    }
    .mode(NavigationMode.Stack)
    .navDestination(this.PageMap)
  }
}


// pageOne
@Component
export struct pageOneTmp {
  pathStack: NavPathStack = new NavPathStack();

  build() {
    NavDestination() {
      Column() {
        Text("first_page")
      }.width('100%').height('100%')
    }.title("pageOne")
    .onBackPressed(() => {
      const popDestinationInfo = this.pathStack.pop() // 弹出路由栈栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true
    })
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
  }
}


// pageTwo
@Component
export struct pageTwoTmp {
  pathStack: NavPathStack = new NavPathStack();

  build() {
    NavDestination() {
      Column() {
        Text("second_page")
      }.width('100%').height('100%')
    }.title("pageTwo")
    .onBackPressed(() => {
      const popDestinationInfo = this.pathStack.pop() // 弹出路由栈栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true
    })
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
  }
}


// pageThree
@Component
export struct pageThreeTmp {
  pathStack: NavPathStack = new NavPathStack();

  build() {
    NavDestination() {
      Column() {
        Text("third_page")
      }.width('100%').height('100%')
    }.title("pageThree")
    .onBackPressed(() => {
      const popDestinationInfo = this.pathStack.pop() // 弹出路由栈栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true
    })
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
  }
}