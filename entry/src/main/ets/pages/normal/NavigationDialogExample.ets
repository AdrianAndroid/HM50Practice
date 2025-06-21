import { uiObserver } from "@kit.ArkUI"

// Dialog NavDestination
@Entry
@Component
struct NavigationDialogExample {
  @Provide('NavPathStack') pageStack: NavPathStack = new NavPathStack()
  // navDesInfo: uiObserver.NavDestinationInfo | undefined

  aboutToAppear(): void {
    // this.navDesInfo = this.queryNavDestinationInfo()
    uiObserver.on('navDestinationUpdate', (info) => {
      console.info('NavDestination state update', JSON.stringify(info));
    })
  }

  aboutToDisappear(): void {
    uiObserver.off('navDestinationUpdate')
  }

  @Builder
  PagesMap(name: string) {
    if (name == 'DialogPage') {
      DialogPage()
    }
  }

  build() {
    Column() {
      // Text("所属页面Name: " + this.navDesInfo?.name)
      Navigation(this.pageStack) {
        Button('Push DialogPage')
          .margin(20)
          .width('80%')
          .onClick(() => {
            this.pageStack.pushPathByName('DialogPage', '');
          })
      }
      .mode(NavigationMode.Stack)
      .title('Main')
      .navDestination(this.PagesMap)
    }
  }
}


@Component
export struct DialogPage {
  @Consume('NavPathStack') pageStack: NavPathStack;


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

  // 组件挂载前执行
  aboutToAppear() {
    console.info('11111组件即将挂载');
  }

  // 组件挂载后执行（相当于 componentDidMount）
  aboutToDisappear() {
    console.info('11111组件即将卸载');
  }

  // 页面显示时触发（类似 onResume）
  onPageShow() {
    console.info('11111页面显示');
  }

  // 页面隐藏时触发（类似 onPause）
  onPageHide() {
    console.info('11111页面隐藏');
  }

  // 组件状态更新前
  onBeforeUpdate() {
    console.info('11111组件即将更新');
  }

  // 组件状态更新后
  onAfterUpdate() {
    console.info('11111组件更新完成');
  }

  // 组件销毁前
  onDestroy() {
    console.info('11111组件即将销毁');
    // 清理资源、取消订阅等操作
  }
}