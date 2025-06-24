import { promptAction, uiObserver } from '@kit.ArkUI';
import Constants from '../../common/Constants';
import { BusinessError } from '@kit.BasicServicesKit';
import { JSON } from '@kit.ArkTS';

const PAGE_ONE = 'NavDestinationTitle1'
const PAGE_TWO = 'NavDestinationTitle2'
const PAGE_THREE = 'NavDestinationTitle3'
const PAGE_FOUR = 'NavDestinationTitle4'
const PAGE_DIALOG = 'DialogPage'
const PAGE_SHARE = 'PageShare'

@Entry
@Component
struct NavigationExamplePage1 {
  @State message: string = 'Hello World';
  @Provide('pageStack') pageStack: NavPathStack = new NavPathStack()
  private arr: number[] = [1, 2, 3];
  private toolbars: Array<ToolbarItem> = [
    {
      'value': "func",
      'icon': $r('app.media.ic_public_highlights'),
      'action': () => {
        promptAction.showToast({ message: 'ic_public_highlights' })
        this.pageStack.pushPath({ name: "NavDestinationTitle1" })
      }
    },
    {
      'value': "func",
      'icon': $r('app.media.ic_public_highlights'),
      'action': () => {
        promptAction.showToast({ message: 'ic_public_highlights' })
        this.pageStack.pushPath({ name: "NavDestinationTitle2" })
      }
    },
    {
      'value': "func",
      'icon': $r('app.media.ic_public_highlights'),
      'action': () => {
        promptAction.showToast({ message: 'ic_public_highlights' })
        this.pageStack.pushPath({ name: "NavDestinationTitle3" })
      }
    }
  ]
  private menusArray: Array<NavigationMenuItem> = [
    {
      value: "111",
      icon: $r('app.media.ic_public_search'),
      action: () => {
        promptAction.showToast({ message: "ic_public_search" })
      }
    },
    {
      value: "222",
      icon: $r('app.media.ic_public_add'),
      action: () => {
        promptAction.showToast({ message: "ic_public_add" })
      }
    },
    {
      value: "333",
      icon: $r('app.media.ic_public_add'),
      action: () => {
        promptAction.showToast({ message: "ic_public_add" })
      }
    },
    {
      value: "444",
      icon: $r('app.media.ic_public_add'),
      action: () => {
        promptAction.showToast({ message: "ic_public_add" })
      }
    },
    {
      value: "555",
      icon: $r('app.media.ic_public_add'),
      action: () => {
        promptAction.showToast({ message: "ic_public_add" })
      }
    }
  ]

  aboutToAppear(): void {
    this.pageStack.setInterception({
      willShow: (
        from: NavDestinationContext | "navBar",
        to: NavDestinationContext | "navBar",
        operation: NavigationOperation,
        animated: boolean) => {
        console.debug(`from=>${JSON.stringify(from)}, to=>${JSON.stringify(to)}, animated=>${animated}, operation=>${JSON.stringify(operation)}`)
        promptAction.showToast({
          message: `from=>${JSON.stringify(from)}, to=>${JSON.stringify(to)}, animated=>${animated}, operation=>${JSON.stringify(operation)}`
        })
        if (typeof to === "string") {
          console.log("target page is navigation home page.");
          return;
        }
        // 将跳转到PageTwo的路由重定向到PageOne
        let target: NavDestinationContext = to as NavDestinationContext;
        if (target.pathInfo.name === 'PageTwo') {
          target.pathStack.pop();
          target.pathStack.pushPathByName('PageOne', null);
        }
      }
    })
  }

  @Builder
  PageMap(name: string) {
    if (name === PAGE_ONE) {
      pageOneTmp()
    } else if (name === PAGE_TWO) {
      pageTwoTmp()
    } else if (name === PAGE_THREE) {
      pageThreeTmp()
    } else if (name === PAGE_DIALOG) {
      DialogPage()
    } else if (name === PAGE_SHARE) {
      pageShareTmp()
    }
  }

  build() {
    Column() {
      Navigation(this.pageStack) {
        TextInput({ placeholder: 'search...' })
          .width("90%")
          .height(40)
          .backgroundColor($r('sys.color.comp_background_list_card'))

        List({ space: 12 }) {
          ListItem() {
            Image($r('app.media.startIcon'))
              .geometryTransition('sharedId')
              .width(100)
              .height(100)
              .onClick(() => {
                let pageItem = PAGE_SHARE
                let params = 'PageOne Param'
                let animated = true
                this.pageStack.pushDestinationByName(pageItem, params, animated)
                  .catch((error: BusinessError) => {
                    console.error(`Push destination failed, error code = ${error.code}, error.message = ${error.message}.`);
                    promptAction.showToast({
                      message: `Push destination failed, error code = ${error.code}, error.message = ${error.message}.`
                    })
                  })
                  .then(() => {
                    console.info('Push destination succeed.');
                    promptAction.showToast({ message: 'Push destination succeed.' })
                  });
              })
          }

          ListItem() {
            Text('跳转到' + PAGE_SHARE)
              .width("100%")
              .height(72)
              .backgroundColor($r('sys.color.comp_background_list_card'))
              .borderRadius(24)
              .fontSize(16)
              .fontWeight(500)
              .textAlign(TextAlign.Center)
              .onClick(() => {
                this.getUIContext()?.animateTo({duration: 1000}, () => {
                  this.pageStack.pushPath({ name: PAGE_SHARE }, false)
                })
              })
          }


          ListItem() {
            Text(PAGE_TWO + '=页面查询')
              .width("100%")
              .height(72)
              .backgroundColor($r('sys.color.comp_background_list_card'))
              .borderRadius(24)
              .fontSize(16)
              .fontWeight(500)
              .textAlign(TextAlign.Center)
              .onClick(() => {
                let pageItem = PAGE_TWO
                let params = 'PageOne Param'
                let animated = true
                this.pageStack.pushDestinationByName(pageItem, params, animated)
                  .catch((error: BusinessError) => {
                    console.error(`Push destination failed, error code = ${error.code}, error.message = ${error.message}.`);
                    promptAction.showToast({
                      message: `Push destination failed, error code = ${error.code}, error.message = ${error.message}.`
                    })
                  })
                  .then(() => {
                    console.info('Push destination succeed.');
                    promptAction.showToast({ message: 'Push destination succeed.' })
                  });
              })
          }

          ListItem() {
            Text(PAGE_DIALOG)
              .width("100%")
              .height(72)
              .backgroundColor($r('sys.color.comp_background_list_card'))
              .borderRadius(24)
              .fontSize(16)
              .fontWeight(500)
              .textAlign(TextAlign.Center)
              .onClick(() => {
                let pageItem = PAGE_DIALOG
                let params = 'PageOne Param'
                let animated = true
                // this.pageStack.pushPath({ name: pageItem, param: params }, animated)
                // this.pageStack.pushPathByName(pageItem, params, animated)
                // this.pageStack.pushPathByName(pageItem, params, (popInfo) => {
                //   console.log('Pop page name is: ' + popInfo.info.name + ', result: ' +
                //   JSON.stringify(popInfo.result))
                // }, animated);
                // this.pageStack.pushDestination({ name: pageItem, param: params }, animated)
                //   .catch((error: BusinessError) => {
                //     console.error(`Push destination failed, error code = ${error.code}, error.message = ${error.message}.`);
                //     promptAction.showToast({message: `Push destination failed, error code = ${error.code}, error.message = ${error.message}.`})
                //   })
                //   .then(() => {
                //     console.info('Push destination succeed.');
                //     promptAction.showToast({message: 'Push destination succeed.'})
                //   });
                this.pageStack.pushDestinationByName(pageItem, params, animated)
                  .catch((error: BusinessError) => {
                    console.error(`Push destination failed, error code = ${error.code}, error.message = ${error.message}.`);
                    promptAction.showToast({
                      message: `Push destination failed, error code = ${error.code}, error.message = ${error.message}.`
                    })
                  })
                  .then(() => {
                    console.info('Push destination succeed.');
                    promptAction.showToast({ message: 'Push destination succeed.' })
                  });
              })
          }

          ForEach(this.arr, (item: number) => {
            ListItem() {
              Text("Page" + item)
                .width("100%")
                .height(72)
                .backgroundColor($r('sys.color.comp_background_list_card'))
                .borderRadius(24)
                .fontSize(16)
                .fontWeight(500)
                .textAlign(TextAlign.Center)
                .onClick(() => {
                  let pageItem = "NavDestinationTitle" + item
                  let params = 'PageOne Param'
                  let animated = true
                  this.pageStack.pushPath({ name: pageItem, param: params }, animated)
                  this.pageStack.pushPathByName(pageItem, params, animated)
                  this.pageStack.pushPathByName(pageItem, params, (popInfo) => {
                    console.log('Pop page name is: ' + popInfo.info.name + ', result: ' +
                    JSON.stringify(popInfo.result))
                  }, animated);
                  this.pageStack.pushDestination({ name: pageItem, param: params }, animated)
                    .catch((error: BusinessError) => {
                      console.error(`Push destination failed, error code = ${error.code}, error.message = ${error.message}.`);
                    })
                    .then(() => {
                      console.info('Push destination succeed.');
                    });
                  this.pageStack.pushDestinationByName(pageItem, params, animated)
                    .catch((error: BusinessError) => {
                      console.error(`Push destination failed, error code = ${error.code}, error.message = ${error.message}.`);
                    })
                    .then(() => {
                      console.info('Push destination succeed.');
                    });
                })
            }
          }, (item: number) => item.toString())
        }
        .width("90%")
        .height(Constants.FULL_PERCENT)
        .margin({ top: 12 })
      }
      .title("主标题")
      .mode(NavigationMode.Stack)
      .navDestination(this.PageMap)
      //.titleMode(NavigationTitleMode.Mini)
      //.titleMode(NavigationTitleMode.Full)
      .titleMode(NavigationTitleMode.Free)
      .menus(this.menusArray)
      .toolbarConfiguration(this.toolbars)
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#F1F3F5')
  }
}


// PageOne.ets
@Component
export struct pageOneTmp {
  @Consume('pageStack') pageStack: NavPathStack;

  aboutToAppear(): void {

  }

  build() {
    NavDestination() {
      Column() {
        Text(PAGE_ONE)
          .fontColor(Color.Red)
          .fontSize(50)
          .onClick(() => {
            // this.pageStack.NavDestinationTitle3
            // 将栈顶页面替换为PageOne
            this.pageStack.replacePath({ name: PAGE_THREE, param: "PageOne Param" })
            // this.pageStack.replacePathByName("NavDestinationTitle3", "PageOne Param")
            // 带错误码的替换，跳转结束会触发异步回调，返回错误码信息
            // this.pageStack.replaceDestination({name: "PageOne", param: "PageOne Param"})
            //   .catch((error: BusinessError) => {
            //     console.error(`Replace destination failed, error code = ${error.code}, error.message = ${error.message}.`);
            //   }).then(() => {
            //   console.info('Replace destination succeed.');
            // })
          })
        Text("NavDestinationContent2")
          .fontColor(Color.Red)
          .fontSize(50)
          .onClick(() => {
            // this.pageStack.NavDestinationTitle3
            // 将栈顶页面替换为PageOne
            this.pageStack.replacePath({ name: PAGE_TWO, param: "PageOne Param" })
            // this.pageStack.replacePathByName("NavDestinationTitle3", "PageOne Param")
            // 带错误码的替换，跳转结束会触发异步回调，返回错误码信息
            // this.pageStack.replaceDestination({name: "PageOne", param: "PageOne Param"})
            //   .catch((error: BusinessError) => {
            //     console.error(`Replace destination failed, error code = ${error.code}, error.message = ${error.message}.`);
            //   }).then(() => {
            //   console.info('Replace destination succeed.');
            // })
          })
        Text("获取所有页面参数")
          .fontColor(Color.Red)
          .fontSize(50)
          .onClick(() => {
            // // 获取栈中所有页面name集合
            // let res = this.pageStack.getAllPathName()
            // promptAction.showToast({ message: JSON.stringify(res) })
            // // 获取索引为1的页面参数
            // this.pageStack.getParamByIndex(1)
            // 获取PageOne页面的参数
            // let res: Object = this.pageStack.getParamByName("NavDestinationTitle1")
            // promptAction.showToast({message: JSON.stringify(res)})
            // 获取PageOne页面的索引集合
            let res = this.pageStack.getIndexByName(PAGE_ONE)
            promptAction.showToast({ message: JSON.stringify(res) })
          })
      }.width('100%').height('100%')
    }.title("NavDestinationTitle1")
    .onBackPressed(() => {
      const popDestinationInfo = this.pageStack.pop() // 弹出路由栈栈顶元素

      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true
    })
  }
}

@Component
struct DialogPage {
  @Consume('pageStack') pageStack: NavPathStack;

  build() {
    NavDestination() {
      Stack({ alignContent: Alignment.Center }) {
        Column() {
          Text("Dialog NavDestination")
            .fontSize(20)
            .margin({ bottom: 100 })
          Button("Close").onClick(() => {
            this.pageStack.pop()
          }).width('30%')
        }
        .justifyContent(FlexAlign.Center)
        .backgroundColor(Color.White)
        .borderRadius(10)
        .height('30%')
        .width('80%')
      }.height("100%").width('100%')
    }
    .backgroundColor('rgba(0,0,0,0.5)')
    .hideTitleBar(true)
    .mode(NavDestinationMode.DIALOG)
  }
}

// PageTwo.ets
@Component
struct pageTwoTmp {
  @Consume('pageStack') pageStack: NavPathStack;
  navDesInfo: uiObserver.NavDestinationInfo | undefined

  aboutToAppear(): void {
    this.navDesInfo = this.queryNavDestinationInfo()
    uiObserver.on('navDestinationUpdate', (info) => {
      console.info('NavDestination state update', JSON.stringify(info));
      promptAction.showToast({ message: 'NavDestination state update => ' + JSON.stringify(info) })
    })
  }

  build() {
    NavDestination() {
      Column() {
        Text(PAGE_TWO + this.navDesInfo?.name)
          .fontColor(Color.Blue)
          .onClick(() => {
            // 移动栈中name为PageOne的页面到栈顶
            let res = this.pageStack.moveToTop(PAGE_ONE);
            promptAction.showToast({ message: `${res}` })
            // 移动栈中索引为1的页面到栈顶
            // this.pageStack.moveIndexToTop(1);
          })
      }.width('100%').height('100%')
    }.title(PAGE_TWO)
    .onBackPressed(() => {
      const popDestinationInfo = this.pageStack.pop() // 弹出路由栈栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true
    })
  }
}

// PageThree.ets
@Component
struct pageThreeTmp {
  @Consume('pageStack') pageStack: NavPathStack;

  build() {
    NavDestination() {
      Column() {
        Text(PAGE_THREE)
          .fontColor(Color.Green)
          .onClick(() => {
            // 删除栈中name为PageOne的所有页面
            let res = this.pageStack.removeByName(PAGE_ONE)
            promptAction.showToast({ message: `${res}` })
            // 删除指定索引的页面
            // this.pageStack.removeByIndexes([1,3,5])
            // 删除指定id的页面
            this.pageStack.removeByNavDestinationId("1");
          })
      }.width('100%').height('100%')
    }.title(PAGE_THREE)
    .onBackPressed(() => {
      const popDestinationInfo = this.pageStack.pop() // 弹出路由栈栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true
    })
  }
}

@Component
struct pageShareTmp {
  @Consume('pageStack') pageStack: NavPathStack;

  build() {
    NavDestination() {
      Image($r('app.media.startIcon'))
        .geometryTransition('sharedId')
        .width(200)
        .height(200)
    }
    .title(PAGE_SHARE)
    .onBackPressed(() => {
      const popDestinationInfo = this.pageStack.pop() // 弹出路由栈栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true
    })
  }
}
