import Logger from '../../common/Logger';
import { UIObserver, uiObserver } from '@kit.ArkUI';

@Entry
@Component
struct LifecyclePages {
  @State showChild: boolean = true;
  @State btnColor: string = "#FF007DFF";
  listener: (info: uiObserver.RouterPageInfo) => void = (info: uiObserver.RouterPageInfo) => {
    let routerInfo: uiObserver.RouterPageInfo | undefined = this.queryRouterPageInfo();
    if (info.pageId == routerInfo?.pageId) {
      if (info.state == uiObserver.RouterPageState.ON_PAGE_SHOW) {
        console.log(`Index onPageShow`);
      } else if (info.state == uiObserver.RouterPageState.ON_PAGE_HIDE) {
        console.log(`Index onPageHide`);
      }
    }
  }

  // 只有被@Entry装饰的组件才可以调用页面的生命周期
  onPageShow() {
    Logger.debug('[LifecyclePages]', 'Index onPageShow');
  }

  // 只有被@Entry装饰的组件才可以调用页面的生命周期
  onPageHide() {
    Logger.debug('[LifecyclePages]', 'Index onPageHide');
  }

  // 只有被@Entry装饰的组件才可以调用页面的生命周期
  onBackPress() {
    Logger.debug('[LifecyclePages]', 'Index onBackPress');
    this.btnColor = "#FFEE0606";
    return true; // 返回true表示页面自己处理返回逻辑，不进行页面路由；返回false表示使用默认的路由返回逻辑，不设置返回值按照false处理
  }

  // 组件生命周期
  aboutToAppear() {
    Logger.debug('[LifecyclePages]', 'MyComponent aboutToAppear');
    this.getUIContext().getUIObserver().on('routerPageUpdate', this.listener);
  }

  // 组件生命周期
  onDidBuild() {
    Logger.debug('[LifecyclePages]', 'MyComponent onDidBuild');
  }

  // 组件生命周期
  aboutToDisappear() {
    Logger.debug('[LifecyclePages]', ' MyComponent aboutToDisappear');
    this.getUIContext().getUIObserver().off('routerPageUpdate', this.listener);
  }

  build() {
    Column() {
      Text(`this page is ${this.queryRouterPageInfo()?.pageId}`).fontSize(25)
      // this.showChild为true，创建Child子组件，执行Child aboutToAppear
      Column() {
        SubComponent()
      }

      if (this.showChild) {
        LifecycleChild()
      }
      Button('delete Child')
        .margin(20)
        .backgroundColor(this.btnColor)
        .onClick(() => {
          // 更改this.showChild为false，删除Child子组件，执行Child aboutToDisappear
          this.showChild = false;
        })
      // push到Page页面，执行onPageHide
      Button('push to next page')
        .onClick(() => {
          // router.pushUrl({ url: 'pages/Page' });
        })
    }
  }
}

@Component
struct LifecycleChild {
  @State title: string = 'Hello World';

  // 组件生命周期
  aboutToDisappear() {
    Logger.debug('[LifecyclePages]', '[LifecycleChild] Child aboutToDisappear');
  }

  onPageShow(): void {
    Logger.debug('[LifecyclePages]', '[LifecycleChild] Child onPageShow');
  }

  onPageHide(): void {
    Logger.debug('[LifecyclePages]', '[LifecycleChild] Child onPageHide');
  }

  // 组件生命周期
  onDidBuild() {
    Logger.debug('[LifecyclePages]', '[LifecycleChild] Child onDidBuild');
  }

  // 组件生命周期
  aboutToAppear() {
    Logger.debug('[LifecyclePages]', '[LifecycleChild] Child aboutToAppear');
  }

  build() {
    Text(this.title)
      .fontSize(50)
      .margin(20)
      .onClick(() => {
        this.title = 'Hello ArkUI';
      })
  }
}

@Component
struct SubComponent {
  listener: (info: uiObserver.RouterPageInfo) => void = (info: uiObserver.RouterPageInfo) => {
    let routerInfo: uiObserver.RouterPageInfo | undefined = this.queryRouterPageInfo();
    if (info.pageId == routerInfo?.pageId) {
      if (info.state == uiObserver.RouterPageState.ON_PAGE_SHOW) {
        console.log(`SubComponent onPageShow`);
      } else if (info.state == uiObserver.RouterPageState.ON_PAGE_HIDE) {
        console.log(`SubComponent onPageHide`);
      }
    }
  }

  aboutToAppear(): void {
    let uiObserver: UIObserver = this.getUIContext().getUIObserver();
    uiObserver.on('routerPageUpdate', this.listener);
  }

  aboutToDisappear(): void {
    let uiObserver: UIObserver = this.getUIContext().getUIObserver();
    uiObserver.off('routerPageUpdate', this.listener);
  }

  build() {
    Column() {
      Text(`SubComponent`)
    }
  }
}

@Component
struct CustomLayout {
  @Builder
  doNothingBuilder() {
  }

  @BuilderParam builder: (() => void) = this.doNothingBuilder
  @State startSize: number = 100;
  result: SizeResult = {
    width: 0,
    height: 0
  }

  // 第一步：计算各子组件的大小
  onMeasureSize(selfLayoutInfo: GeometryInfo, children: Measurable[], constraint: ConstraintSizeOptions): SizeResult {
    let size = 100;
    children.forEach((child) => {
      let result: MeasureResult = child.measure({
        minHeight: size,
        minWidth: size,
        maxWidth: size,
        maxHeight: size
      })
      size += result.width / 2;
    })
    this.result.width = 100;
    this.result.height = 400;
    return this.result;
  }

  // 第二步：放置各子组件的位置
  onPlaceChildren(selfLayoutInfo: GeometryInfo, children: Array<Layoutable>, constraint: ConstraintSizeOptions) {
    let startPos = 300;
    children.forEach((child) => {
      let pos = startPos - child.measureResult.height;
      child.layout({ x: pos, y: pos })
    })
  }

  build() {
    this.builder()
  }
}