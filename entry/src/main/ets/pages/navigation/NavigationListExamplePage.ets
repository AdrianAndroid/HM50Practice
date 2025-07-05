import { router } from "@kit.ArkUI";
import Constants from "../../common/Constants";

class Item {
  title: string = ''
  constructor(title: string) {
    this.title = title
  }
}

@Builder
export function PageBuilder(name: string, param: Object) {
  NavigationListExamplePage()
}

@Component
struct NavigationListExamplePage {
  @State message: string = 'Hello World';
  @StorageProp('bottomRectHeight') bottomRectHeight: number = 0;
  @StorageProp('topRectHeight') topRectHeight: number = 0;
  pathStack: NavPathStack = new NavPathStack()
  mode = NavigationMode.Stack
  titleMode = NavigationTitleMode.Free
  list: Item[] = [
    new Item('设置页面显示模式')
  ]

  @Builder
  buildModeRadio(text: string, mode: NavigationMode, onChange: () => void) {
    Row() {
      Text(text)
      Radio({ value: text, group: 'mode' })
        .checked(this.mode == mode)
        .width(this.radioSize)
        .height(this.radioSize)
        .onChange((isCheck) => {
          if (isCheck) {
            onChange()
          }
        })
    }
  }

  @Builder
  buildTitleModeRadio(text: string, titleMode: NavigationTitleMode, onChange: () => void) {
    Row() {
      Text(text)
      Radio({ value: text, group: 'titleMode' })
        .checked(this.titleMode == titleMode)
        .width(this.radioSize)
        .height(this.radioSize)
        .onChange((isCheck) => {
          if (isCheck) {
            onChange()
          }
        })
    }
  }

  private radioSize = '30vp'

  @Builder
  buildModeItem(title: string) {
    Column() {
      Text(title)
      Row() {
        Text('页面模式:')
        this.buildModeRadio('Stack', NavigationMode.Stack, () => {
          this.mode = NavigationMode.Stack
        })
        this.buildModeRadio('Split', NavigationMode.Split, () => {
          this.mode = NavigationMode.Split
        })
        this.buildModeRadio('Auto', NavigationMode.Auto, () => {
          this.mode = NavigationMode.Auto
        })
      }
      Row() {
        Text('标题模式:')
        this.buildTitleModeRadio('Free', NavigationTitleMode.Free, () => {
          this.titleMode = NavigationTitleMode.Free
        })
        this.buildTitleModeRadio('Full', NavigationTitleMode.Full, () => {
          this.titleMode = NavigationTitleMode.Full
        })
        this.buildTitleModeRadio('Mini', NavigationTitleMode.Mini, () => {
          this.titleMode = NavigationTitleMode.Mini
        })
      }
      Button('点击跳转' + Constants.NavigationSimplePage)
        .onClick(() => {
          router.pushUrl({
            url: Constants.PATH_navigation + Constants.NavigationSimplePage,
            params: {
              mode: this.mode.valueOf(),
              titleMode: this.titleMode.valueOf()
            }
          })
        })
      Divider()
    }
    .width('100%')
  }

  build() {
    NavDestination() {
      List({ space: 12, initialIndex: 0 }) {
        // Navigation的模式
        ListItem() {
          this.buildModeItem('Navigation的模式')
        }

        ListItem() {
          Text('SystemRouterMapPage')
        }

        ListItem() {
          Button('点击跳转' + Constants.SystemRouterMapPage)
            .onClick(() => {
              router.pushUrl({
                url: Constants.PATH_navigation + Constants.SystemRouterMapPage,
                params: {
                  mode: this.mode.valueOf(),
                  titleMode: this.titleMode.valueOf()
                }
              })
            })
        }

        ListItem() {
          Divider()
        }

        ListItem() {
          Text('复杂的页面')
        }

        ListItem() {
          Button('MainPage')
            .onClick(() => {
              this.pathStack.pushPathByName(Constants.MainPage, '')
            })
        }

        ListItem() {
          Divider()
        }

        ListItem() {
          Text('通过Navigation弹出Dialog')
        }

        ListItem() {
          Button('NavigationDialogExample')
            .onClick(() => {
              this.pathStack.pushPathByName(Constants.NavigationDialogExample, '')
            })
        }


        ForEach(this.list,
          (item: Item, index) => {
            ListItem() {
              this.builderItem(item)
            }
          },
          (item: Item, index) => {
            return JSON.stringify(item)
          }
        )
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
  builderItem(item: Item) {
    Text(item.title)
      .width('90%')
      .height(72)
      .borderRadius(24)
      .fontSize(16)
      .fontWeight(500)
      .textAlign(TextAlign.Center)
  }
}