import { promptAction } from '@kit.ArkUI';
import Constants from '../../common/Constants';

@Entry
@Component
struct ButtonExamplePage {
  @State message: string = 'Hello World';
  private pathStack: NavPathStack = new NavPathStack();
  private arr: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
  private scroller: Scroller = new Scroller()
  private pageIndex: number = 0

  build() {
    Flex({ justifyContent: FlexAlign.Start, wrap: FlexWrap.Wrap, alignContent: FlexAlign.Start }) {
      Button('普通按钮', { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .backgroundColor(0x317aff)
        .width(90)
        .height(40)
      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Row() {
          Image($r('app.media.loading')).width(20).height(40).margin({ left: 12 })
          Text('loading').fontSize(12).fontColor(0xffffff).margin({ left: 5, right: 12 })
        }.alignItems(VerticalAlign.Center)
      }.borderRadius(8).backgroundColor(0x317aff).width(90).height(40)

      // 胶囊类型
      Button('胶囊类型', { type: ButtonType.Capsule, stateEffect: false })
        .backgroundColor(0x317aff)
        .width(90)
        .height(40)
        .onClick(() => {
          promptAction.showToast({ message: 'Hello' })
        })

      // 圆角
      Button('圆形按钮', { type: ButtonType.Circle, stateEffect: true })
        .backgroundColor(0x317aff)
        .width(90)
        .height(90)

      Button('普通按钮', { type: ButtonType.Normal, stateEffect: true })
        .borderRadius(8)
        .backgroundColor(0x317aff)
        .width(90)
        .height(40)

      Button('设置边框弧度', { type: ButtonType.Normal })
        .borderRadius(20)
        .height(40)

      Button('设置文本样式', { type: ButtonType.Normal })
        .fontSize(20)
        .fontColor(Color.Pink)
        .fontWeight(800)

      Button('设置背景颜色')
        .backgroundColor(0xF55A42)

      // 创建功能型按钮
      Button({ type: ButtonType.Circle, stateEffect: true }) {
        Image($r('app.media.ic_public_delete_filled')).width(30).height(30)
      }.width(55).height(55).margin({ left: 20 }).backgroundColor(0xF55A42)

      Button('添加事件', { type: ButtonType.Normal, stateEffect: true })
        .onClick(() => {
          console.info('Button onClick')
        })

      Column() {
        TextInput({ placeholder: 'input your username' }).margin({ top: 20 })
        TextInput({ placeholder: 'input your password' }).type(InputType.Password).margin({ top: 20 })
        Button('Register').width(300).margin({ top: 20 })
          .onClick(() => {
            // 需要执行的操作
          })
      }.padding(20)

      Navigation(this.pathStack) {
        Flex({ justifyContent: FlexAlign.Start, wrap: FlexWrap.Wrap, alignContent: FlexAlign.Start }) {
          Button("first_page").onClick(() => {
            this.pathStack.pushPath({ name: "first_page" })
          }).width('30%')

          Button("second_page").onClick(() => {
            this.pathStack.pushPath({ name: "second_page" })
          }).width('30%')

          Button("third_page").onClick(() => {
            this.pathStack.pushPath({ name: "third_page" })
          }).width('30%')
        }
      }
      .navDestination(this.PageMap)
      .mode(NavigationMode.Stack)
      .height(100)

      Stack() {
        List({ scroller: this.scroller, space: 20, initialIndex: 0 }) {
          ForEach(this.arr, (item:number) => {
            ListItem() {
              Text('' + item)
                .width('100%').height(100).fontSize(16)
                .textAlign(TextAlign.Center).borderRadius(10).backgroundColor(0xFFFFFF)
            }.onClick(() => {
              this.pageIndex = item
              this.scroller.scrollToIndex(item)
            })
          }, (item:number) => item.toString())
        }
        .width('90%')
        .height(Constants.FULL_PERCENT)
        Button() {
          Image($r('app.media.ic_public_add'))
            .width(50)
            .height(50)
        }
        .width(60)
        .height(60)
        .position({x: '80%', y: 100})
        .shadow({radius: 10})
        .onClick(() => {
          // 需要执行的操作
          this.scroller.scrollToIndex(this.pageIndex++)
        })
      }
      .width('100%')
      .height(200)
      .backgroundColor(0xDCDCDC)
      .padding({ top: 5 })
    }
    // .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM, SafeAreaEdge.START, SafeAreaEdge.END])
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
    .height('100%')
    .width('100%')
  }

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
}

// pageOne
@Component
struct pageOneTmp {
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
struct pageTwoTmp {
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
struct pageThreeTmp {
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