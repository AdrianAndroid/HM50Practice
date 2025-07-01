import { NodeController, Size, UIContext } from '@kit.ArkUI';
import { getOrCreateNode } from './common';

const TEST_TAG: string = "NodeContainer";

class MyNodeController extends NodeController {
  private isShow: boolean = false

  constructor(isShow: boolean) {
    super()
    this.isShow = isShow
  }

  makeNode(uiContext: UIContext): FrameNode | null {
    if (!this.isShow) {
      return null
    }
    let frameNode = getOrCreateNode(uiContext)?.getFrameNode()
    return frameNode ? frameNode : null
  }

  aboutToResize(size: Size): void {
    console.log(TEST_TAG + " aboutToResize width : " + size.width + " height : " + size.height)
  }

  aboutToAppear() {
    console.log(TEST_TAG + " aboutToAppear")
  }

  aboutToDisappear() {
    console.log(TEST_TAG + " aboutToDisappear");
  }

  onTouchEvent(event: TouchEvent) {
    console.log(TEST_TAG + " onTouchEvent");
  }

  toShow() {
    this.isShow = true
    this.rebuild()
  }

  toHide() {
    this.isShow = false
    this.rebuild()
  }
}

@Entry
@Component
struct NodeContainerPage {
  @State message: string = 'Hello World';
  private myNodeController1: MyNodeController = new MyNodeController(true)
  private myNodeController2: MyNodeController = new MyNodeController(false)

  build() {
    Column() {
      NodeContainer(this.myNodeController1)
        .width('100%')
        .height('40%')
        .backgroundColor(Color.Brown)
      NodeContainer(this.myNodeController2)
        .width('100%')
        .height('40%')
        .backgroundColor(Color.Gray)
      Button('Change the place of button')
        .onClick(() => {
          // 先在原始占位节点中下树
          // 后在新的占位节点中上树
          // 保证自定义节点仅作为一个节点的子节点存在
          this.myNodeController1.toHide()
          this.myNodeController2.toShow()
        })
    }
    .padding({ left: 35, right: 35, top: 35 })
    .height('100%')
    .width('100%')
  }
}