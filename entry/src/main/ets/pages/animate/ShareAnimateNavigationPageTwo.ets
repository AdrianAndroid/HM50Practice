// PageTwo.ets
import { CustomTransition } from '../../CustomTransition/CustomNavigationUtils';
import { AnimationProperties } from '../../CustomTransition/AnimationProperties';
import { RectInfoInPx } from '../../utils/NavigationComponentAttrUtils';
import { getMyNode, MyNodeController } from '../../NodeContainer/NavigationCustomComponent';


@Builder
export function PageTwoBuilder() {
  ShareAnimateNavigationPageTwo();
}


@Component
export struct ShareAnimateNavigationPageTwo {
  @State pageInfos: NavPathStack = new NavPathStack();
  @State AnimationProperties: AnimationProperties = new AnimationProperties();
  @State myNodeController: MyNodeController | undefined = new MyNodeController(false);


  private pageId: number = -1;


  private shouldDoDefaultTransition: boolean = false;
  private prePageDoFinishTransition: () => void = () => {};
  private cardItemInfo: RectInfoInPx = new RectInfoInPx();


  @StorageProp('windowSizeChanged') @Watch('unRegisterNavParam') windowSizeChangedTime: number = 0;
  @StorageProp('onConfigurationUpdate') @Watch('unRegisterNavParam') onConfigurationUpdateTime: number = 0;


  aboutToAppear(): void {
    // 迁移自定义节点至当前页面
    this.myNodeController = getMyNode();
  }


  private unRegisterNavParam(): void {
    this.shouldDoDefaultTransition = true;
  }


  private onBackPressed(): boolean {
    if (this.shouldDoDefaultTransition) {
      CustomTransition.getInstance().unRegisterNavParam(this.pageId);
      this.pageInfos.pop();
      this.prePageDoFinishTransition();
      this.shouldDoDefaultTransition = false;
      return true;
    }
    this.pageInfos.pop();
    return true;
  }


  build() {
    NavDestination() {
      // Stack需要设置alignContent为TopStart，否则在高度变化过程中，截图和内容都会随高度重新布局位置
      Stack({ alignContent: Alignment.TopStart }) {
        Stack({ alignContent: Alignment.TopStart }) {
          Column({space: 20}) {
            NodeContainer(this.myNodeController)
            if (this.AnimationProperties.showDetailContent)
              Text('展开态内容')
                .fontSize(20)
                .transition(TransitionEffect.OPACITY)
                .margin(30)
          }
          .alignItems(HorizontalAlign.Start)
        }
        .position({ y: this.AnimationProperties.positionValue })
      }
      .scale({ x: this.AnimationProperties.scaleValue, y: this.AnimationProperties.scaleValue })
      .translate({ x: this.AnimationProperties.translateX, y: this.AnimationProperties.translateY })
      .width(this.AnimationProperties.clipWidth)
      .height(this.AnimationProperties.clipHeight)
      .borderRadius(this.AnimationProperties.radius)
      // expandSafeArea使得Stack做沉浸式效果，向上扩到状态栏，向下扩到导航条
      .expandSafeArea([SafeAreaType.SYSTEM])
      // 对高度进行裁切
      .clip(true)
    }
    .backgroundColor(this.AnimationProperties.navDestinationBgColor)
    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack;
      this.pageId = this.pageInfos.getAllPathName().length - 1;
      let param = context.pathInfo?.param as Record<string, Object>;
      this.prePageDoFinishTransition = param['doDefaultTransition'] as () => void;
      this.cardItemInfo = param['cardItemInfo'] as RectInfoInPx;
      CustomTransition.getInstance().registerNavParam(
        this.pageId,
        (isPush: boolean, isExit: boolean, transitionProxy: NavigationTransitionProxy) => {
          this.AnimationProperties.doAnimation(this.cardItemInfo, isPush, isExit, transitionProxy, 0, this.prePageDoFinishTransition, this.myNodeController);
        },
        500
      );
    })
    .onBackPressed(() => {
      return this.onBackPressed();
    })
    .onDisAppear(() => {
      CustomTransition.getInstance().unRegisterNavParam(this.pageId);
    })
  }
}