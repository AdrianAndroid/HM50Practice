import { NodeController, FrameNode, UIContext } from '@kit.ArkUI';


const TEST_TAG: string = "FrameNode"


class MyNodeController extends NodeController {
  public frameNode: FrameNode | null = null;
  private rootNode: FrameNode | null = null;


  makeNode(uiContext: UIContext): FrameNode | null {
    this.rootNode = new FrameNode(uiContext);
    this.frameNode = new FrameNode(uiContext);
    this.rootNode.appendChild(this.frameNode);
    return this.rootNode;
  }


  getPositionToWindow() {
    let positionToWindow = this.rootNode?.getPositionToWindow(); // 获取FrameNode相对于窗口的位置偏移
    console.log(`${TEST_TAG} ${JSON.stringify(positionToWindow)}`);
  }


  getPositionToParent() {
    let positionToParent = this.rootNode?.getPositionToParent(); // 获取FrameNode相对于父组件的位置偏移
    console.log(`${TEST_TAG} ${JSON.stringify(positionToParent)}`);
  }


  getPositionToScreen() {
    let positionToScreen = this.rootNode?.getPositionToScreen(); // 获取FrameNode相对于屏幕的位置偏移
    console.log(`${TEST_TAG} ${JSON.stringify(positionToScreen)}`);
  }


  getPositionToWindowWithTransform() {
    let positionToWindowWithTransform = this.rootNode?.getPositionToWindowWithTransform(); // 获取FrameNode相对于窗口带有绘制属性的位置偏移
    console.log(`${TEST_TAG} ${JSON.stringify(positionToWindowWithTransform)}`);
  }


  getPositionToParentWithTransform() {
    let positionToParentWithTransform = this.rootNode?.getPositionToParentWithTransform(); // 获取FrameNode相对于父组件带有绘制属性的位置偏移
    console.log(`${TEST_TAG} ${JSON.stringify(positionToParentWithTransform)}`);
  }


  getPositionToScreenWithTransform() {
    let positionToScreenWithTransform = this.rootNode?.getPositionToScreenWithTransform(); // 获取FrameNode相对于屏幕带有绘制属性的位置偏移
    console.log(`${TEST_TAG} ${JSON.stringify(positionToScreenWithTransform)}`);
  }
}


/**
 * 获取节点位置偏移信息
 */
@Entry
@Component
struct CustomFrameNode4Page {
  private myNodeController: MyNodeController = new MyNodeController();


  build() {
    Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceBetween }) {
      Button("getPositionToWindow")
        .width(300)
        .onClick(() => {
          this.myNodeController.getPositionToWindow();
        })
      Button("getPositionToParent")
        .width(300)
        .onClick(() => {
          this.myNodeController.getPositionToParent();
        })
      Button("getPositionToScreen")
        .width(300)
        .onClick(() => {
          this.myNodeController.getPositionToScreen();
        })
      Button("getPositionToParentWithTransform")
        .width(300)
        .onClick(() => {
          this.myNodeController.getPositionToParentWithTransform();
        })
      Button("getPositionToWindowWithTransform")
        .width(300)
        .onClick(() => {
          this.myNodeController.getPositionToWindowWithTransform();
        })
      Button("getPositionToScreenWithTransform")
        .width(300)
        .onClick(() => {
          this.myNodeController.getPositionToScreenWithTransform();
        })
      Column() {
        Text("This is a NodeContainer.")
          .textAlign(TextAlign.Center)
          .borderRadius(10)
          .backgroundColor(0xFFFFFF)
          .width('100%')
          .fontSize(16)
        NodeContainer(this.myNodeController)
          .borderWidth(1)
          .width(300)
          .height(100)
      }
    }
    .padding({ left: 35, right: 35, top: 35, bottom: 35 })
    .width("100%")
    .height("100%")
  }
}