import { FrameNode, NodeContent, NodeController, typeNode, UIContext } from '@kit.ArkUI';


class NodeContentCtrl {
  content: NodeContent
  textNode: Array<typeNode.Text> = new Array();
  uiContext: UIContext
  width: number

  constructor(uiContext: UIContext) {
    this.content = new NodeContent()
    this.uiContext = uiContext
    this.width = Infinity
  }

  AddNode() {
    let node = typeNode.createNode(this.uiContext, "Text")
    node.initialize("ContentText:" + this.textNode.length).fontSize(20)
    this.textNode.push(node)
    this.content.addFrameNode(node)
  }

  RemoveNode() {
    let node = this.textNode.pop()
    this.content.removeFrameNode(node)
  }

  RemoveFront() {
    let node = this.textNode.shift()
    this.content.removeFrameNode(node)
  }

  GetContent(): NodeContent {
    return this.content
  }
}


class MyNodeController extends NodeController {
  public rootNode: FrameNode | null = null;
  textNode: Array<typeNode.Text> = new Array();

  makeNode(uiContext: UIContext): FrameNode {
    this.rootNode = new FrameNode(uiContext);
    return this.rootNode;
  }

  AddNode(frameNode: FrameNode | null, uiContext: UIContext) {
    let node = typeNode.createNode(uiContext, "Text")
    node.initialize("ControllerText:" + this.textNode.length).fontSize(20)
    this.textNode.push(node)
    frameNode?.appendChild(node)
  }

  RemoveNode(frameNode: FrameNode | null) {
    let node = this.textNode.pop()
    frameNode?.removeChild(node)
  }

  RemoveFront(frameNode: FrameNode | null) {
    let node = this.textNode.shift()
    frameNode?.removeChild(node)
  }
}


@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  controller = new NodeContentCtrl(this.getUIContext());
  myNodeController = new MyNodeController();

  build() {
    Row() {
      Column() {
        ContentSlot(this.controller.GetContent())
        Button("AddToSlot")
          .onClick(() => {
            this.controller.AddNode()
          })
          .margin(10)
        Button("RemoveBack")
          .onClick(() => {
            this.controller.RemoveNode()
          })
          .margin(10)
        Button("RemoveFront")
          .onClick(() => {
            this.controller.RemoveFront()
          })
          .margin(10)
      }
      .width('50%')


      Column() {
        NodeContainer(this.myNodeController)
        Button("AddToNodeContainer")
          .onClick(() => {
            this.myNodeController.AddNode(this.myNodeController.rootNode, this.getUIContext())
          })
          .margin(10)
        Button("RemoveBack")
          .onClick(() => {
            this.myNodeController.RemoveNode(this.myNodeController.rootNode)
          })
          .margin(10)
        Button("RemoveFront")
          .onClick(() => {
            this.myNodeController.RemoveFront(this.myNodeController.rootNode)
          })
          .margin(10)
      }
      .width('50%')
    }
    .height('100%')
  }
}