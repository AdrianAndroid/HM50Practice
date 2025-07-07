import { BusinessError } from "@kit.BasicServicesKit";
import { JSON } from "@kit.ArkTS";
import { promptAction, uiObserver } from "@kit.ArkUI";

const PAGE_ONE = 'PAGE_ONE'
const PAGE_TWO = 'PAGE_TWO'
const PAGE_THREE = 'PAGE_THREE'

@Entry
@Component
struct NavigationParamsPage {
  @State TooTmp: ToolbarItem = {
    'value': "func", 'icon': "./image/ic_public_highlights.svg", 'action': () => {
    }
  }
  @Provide('pageInfos') pageInfos: NavPathStack = new NavPathStack()

  aboutToAppear(): void {
    uiObserver.on('navDestinationSwitch', this.getUIContext(), (data: uiObserver.NavDestinationSwitchInfo) => {
      console.info('navDestinationSwitch', JSON.stringify(data));
    })
    uiObserver.on('navDestinationUpdate', (info) => {
      console.info('NavDestination state update', JSON.stringify(info));
    })
  }

  aboutToDisappear(): void {
    uiObserver.off('navDestinationUpdate')
    // uiObserver.off('navDestinationSwitch')
  }

  @Builder
  PageMap(name: string) {
    if (name === PAGE_ONE) {
      pageOneTmp();
    } else if (name === PAGE_TWO) {
      pageTwoTmp();
    } else if (name === PAGE_THREE) {
      pageThreeTmp();
    }
  }

  onBackPress(): boolean | void {
    if (this.pageInfos.size() > 0) {
      this.pageInfos.pop()
      return true
    }
    return false
  }

  build() {
    Column() {
      Navigation(this.pageInfos) {
        Scroll() {
          Column() {
            jumpToPage(this.pageInfos, PAGE_ONE)
            jumpToPage(this.pageInfos, PAGE_TWO)
            jumpToPage(this.pageInfos, PAGE_THREE)
            jumpToPage(this.pageInfos, 'NO_PAGE')
          }
        }
        .width("90%")
        .height('100%')
      }
      .title("主标题")
      .mode(NavigationMode.Auto)
      .navDestination(this.PageMap)
      .menus([])
      // .toolbarConfiguration([this.TooTmp, this.TooTmp, this.TooTmp])
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
        Text("PageOne")
        popColumn(this.pageInfos, PAGE_ONE)
      }.width('100%').height('100%')
    }
    .onAppear(() => {})
    .onWillShow(() => {})
    .onShown(() => {})
    .onActive(() => {})
    .onWillHide(() => {})
    .onInactive(() => {})
    .onHidden(() => {})
    .onWillDisappear(() => {})
    .onDisAppear(() => {})
    .title(PAGE_ONE)
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
  pageInfos: NavPathStack = new NavPathStack();
  pageParam: string = ''

  build() {
    NavDestination() {
      Column() {
        Text("PageTwo")
        Text(this.pageParam)
      }.width('100%').height('100%')
    }.title(PAGE_TWO)
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop({backParams: PAGE_ONE}); // 弹出路由栈栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo));
      return true;
    })
    .onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack
      this.pageParam = JSON.stringify(context.pathInfo.param ?? 'error')
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
        Text("PageThree")
      }.width('100%').height('100%')
    }.title(PAGE_THREE)
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo));
      return true;
    })
  }
}

@Extend(Text)
function titleStyle() {
  .fontColor(Color.Gray).opacity(0.5)
}

@Extend(Text)
function textButtonStyle() {
  .borderWidth(2)
  .margin({bottom: 10})
}

@Builder
function jumpToPage(pageInfos: NavPathStack, path: string) {
  Column() {
    Text(path).fontColor(Color.Red).fontWeight(FontWeight.Bold)
    Text('普通跳转，通过页面的name去跳转，并可以携带param。').titleStyle()
    Text(`pushPath({ name: ${path}, param: "${path} Param" });`).textButtonStyle()
      .onClick(() => {
        pageInfos.pushPath({ name: path, param: `${path} Param` });
      })
    Text('pushPathByName(path, "PageOne Param")').textButtonStyle()
      .onClick(() => {
        pageInfos.pushPathByName(path, `${path} Param`);
      })
    Text('带返回回调的跳转，跳转时添加onPop回调，能在页面出栈时获取返回信息，并进行处理。')
    Text(`pushPathByName(${path}, ${path} Param", (popInfo) => {}`).textButtonStyle()
      .onClick(() => {
        pageInfos.pushPathByName(path, `${path} Param`, (popInfo) => {
          promptAction.showToast({message: 'Pop page name is: ' + popInfo.info.name + ', result: ' + JSON.stringify(popInfo.result)})
        })
      })
    Text('带错误码的跳转，跳转结束会触发异步回调，返回错误码信息。')
    Text(`pushDestination({name: ${path}, param: "${path} Param"}).catch().then()`).textButtonStyle()
      .onClick(() => {
        pageInfos.pushDestination({ name: path, param: `${path} Param` })
          .catch((error: BusinessError) => {
            console.error(`Push destination failed, error code = ${error.code}, error.message = ${error.message}.`);
          }).then(() => {
          console.info('Push destination succeed.');
        });
      })
    Text(`pushDestinationByName(${path}, "${path} Param").catch().then()`).textButtonStyle()
      .onClick(() => {
        pageInfos.pushDestinationByName(path, `${path} Param`)
          .catch((error: BusinessError) => {
            console.error(`Push destination failed, error code = ${error.code}, error.message = ${error.message}.`);
          }).then(() => {
          console.info('Push destination succeed.');
        });
      })
  }.alignItems(HorizontalAlign.Start)
}

@Builder
function popColumn(pageInfos: NavPathStack, path: string) {
  Column() {
    Text(path).fontColor(Color.Red).fontWeight(FontWeight.Bold)
    Text('pageInfos.pop()').textButtonStyle()
      .onClick(() => {
        // 返回到上一页
        pageInfos.pop({backParam: path});
      })
    Text(`pageInfos.popToName(${path})`).textButtonStyle()
      .onClick(() => {
        // 返回到上一个PageOne页面
        pageInfos.popToName(path);
      })
    Text('pageInfos.popToIndex(1)').textButtonStyle()
      .onClick(() => {
        // 返回到索引为1的页面
        pageInfos.popToIndex(1);
      })
    Text('pageInfos.clear()').textButtonStyle()
      .onClick(() => {
        // 返回到根首页（清除栈中所有页面）
        pageInfos.clear();
      })
  }
  .alignItems(HorizontalAlign.Start)
}

@Builder
function replacePage(pageInfo: NavPathStack, path: string) {
  Column() {
    Text(path).fontColor(Color.Red).fontWeight(FontWeight.Bold)
    Text(`replacePath({ name: path, param: ${path} Param })`).textButtonStyle()
      .onClick(() => {
        // 将栈顶页面替换为PageOne
        pageInfo.replacePath({ name: path, param: `${path} Param` });
      })
    Text(`pageInfo.replacePathByName(path, '${path} Param')`).textButtonStyle()
      .onClick(() => {
        pageInfo.replacePathByName(path, `${path} Param`);
      })
  }
}

@Builder
function removePage(pageInfo: NavPathStack, path: string) {
  Column() {
    Text(path).fontColor(Color.Red).fontWeight(FontWeight.Bold)
    Text(`pageInfo.removeByName(path)`).textButtonStyle()
      .onClick(() => {
        // 删除栈中name为PageOne的所有页面
        pageInfo.removeByName(path);
      })
    Text(`pageInfo.removeByIndexes([1, 3, 5])`).textButtonStyle()
      .onClick(() => {
        // 删除指定索引的页面
        pageInfo.removeByIndexes([1, 3, 5]);
      })
    Text(`removeByNavDestinationId("1")`).textButtonStyle()
      .onClick(() => {
        // 删除指定id的页面
        pageInfo.removeByNavDestinationId("1");
      })
  }
}

@Builder
function movePage(pageInfo: NavPathStack, path: string) {
  Column() {
    Text(path).fontColor(Color.Red).fontWeight(FontWeight.Bold)
    Text(`moveToTop(path)`).textButtonStyle()
      .onClick(() => {
        // 移动栈中name为PageOne的页面到栈顶
        pageInfo.moveToTop(path);
      })
    Text(`moveIndexToTop(1)`).textButtonStyle()
      .onClick(() => {
        // 移动栈中索引为1的页面到栈顶
        pageInfo.moveIndexToTop(1);
      })
  }
}