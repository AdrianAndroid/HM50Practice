// PageOne.ets
import { CustomTransition } from '../../CustomTransition/CustomNavigationUtils';
import { MyNodeController, createMyNode, getMyNode } from '../../NodeContainer/NavigationCustomComponent';
import { ComponentAttrUtils, RectInfoInPx } from '../../utils/NavigationComponentAttrUtils';
import { WindowUtils } from '../../utils/WindowUtils';


@Builder
export function PageOneBuilder() {
  ShareAnimateNavigationPageOne();
}


@Component
export struct ShareAnimateNavigationPageOne {
  private pageInfos: NavPathStack = new NavPathStack();
  private pageId: number = -1;
  @State myNodeController: MyNodeController | undefined = new MyNodeController(false);


  aboutToAppear(): void {
    let node = getMyNode();
    if (node == undefined) {
      // 新建自定义节点
      createMyNode(this.getUIContext());
    }
    this.myNodeController = getMyNode();
  }


  private doFinishTransition(): void {
    // PageTwo结束转场时将节点从PageTwo迁移回PageOne
    this.myNodeController = getMyNode();
  }


  private registerCustomTransition(): void {
    // 注册自定义动画协议
    CustomTransition.getInstance().registerNavParam(
      this.pageId,
      (isPush: boolean, isExit: boolean, transitionProxy: NavigationTransitionProxy) => {

      },
      500
    );
  }


  private onCardClicked(): void {
    let cardItemInfo: RectInfoInPx =
      ComponentAttrUtils.getRectInfoById(WindowUtils.window.getUIContext(), 'card');
    let param: Record<string, Object> = {};
    param['cardItemInfo'] = cardItemInfo;
    param['doDefaultTransition'] = (myController: MyNodeController) => {
      this.doFinishTransition()
    };
    this.pageInfos.pushPath({ name: 'PageTwo', param: param });
    // 自定义节点从PageOne下树
    if (this.myNodeController != undefined) {
      (this.myNodeController as MyNodeController).onRemove();
    }
  }


  build() {
    NavDestination() {
      Stack() {
        Column({ space: 20 }) {
          Row({ space: 10 }) {
            Image($r("app.media.ic_user_portrait"))
              .size({ width: 50, height: 50 })
              .borderRadius(25)
              .clip(true)


            Text('Alice')
          }
          .justifyContent(FlexAlign.Start)


          Text('你好世界')


          NodeContainer(this.myNodeController)
            .size({ width: 320, height: 250 })
            .onClick(() => {
              this.onCardClicked()
            })
        }
        .alignItems(HorizontalAlign.Start)
        .margin(30)
      }
    }
    .onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack;
      this.pageId = this.pageInfos.getAllPathName().length - 1;
      this.registerCustomTransition();
    })
    .onDisAppear(() => {
      CustomTransition.getInstance().unRegisterNavParam(this.pageId);
      // 自定义节点从PageOne下树
      if (this.myNodeController != undefined) {
        (this.myNodeController as MyNodeController).onRemove();
      }
    })
  }
}