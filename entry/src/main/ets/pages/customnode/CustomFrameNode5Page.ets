import { NodeController, FrameNode, UIContext, BuilderNode, typeNode } from '@kit.ArkUI';

let ID_BUILD_TEXT = 'buildText'
let ID_TEXT_TYPE_NODE = 'textTypeNode'

class Params {
  text: string = "";


  constructor(text: string) {
    this.text = text;
  }
}


@Builder
function buildText(params: Params) {
  Column() {
    Text(params.text)
      .id(ID_BUILD_TEXT)
      .border({ width: 1 })
      .padding(1)
      .fontSize(25)
      .fontWeight(FontWeight.Bold)
      .margin({ top: 10 })
      .visibility(Visibility.Visible)
      .opacity(0.7)
      .customProperty("key1", "value1")
      .width(300)
  }
}


const TEST_TAG: string = "FrameNode"


class MyNodeController extends NodeController {
  public frameNode: typeNode.Column | null = null;
  public uiContext: UIContext | undefined = undefined;
  private rootNode: FrameNode | null = null;
  private textNode: BuilderNode<[Params]> | null = null;
  public textTypeNode: typeNode.Text | null = null;
  private message: string = "DEFAULT";


  makeNode(uiContext: UIContext): FrameNode | null {
    this.uiContext = uiContext;

    this.rootNode = new FrameNode(uiContext);

    this.frameNode = typeNode.createNode(uiContext, "Column")
    this.frameNode.attribute
      .width("100%")
      .height("100%")
    this.rootNode.appendChild(this.frameNode);

    this.textNode = new BuilderNode(uiContext);
    this.textNode.build(wrapBuilder<[Params]>(buildText), new Params(this.message));
    this.frameNode.appendChild(this.textNode.getFrameNode());

    this.textTypeNode = typeNode.createNode(uiContext, "Text");
    this.textTypeNode.initialize("textTypeNode")
      .fontSize(25)
      .visibility(Visibility.Visible)
      .id(ID_TEXT_TYPE_NODE)
    this.frameNode.appendChild(this.textTypeNode);
    return this.rootNode;
  }


  removeChild(frameNode: FrameNode) {
    let parent = frameNode.getParent();
    if (parent) {
      parent.removeChild(frameNode);
    }
  }


  getUserConfigBorderWidth(frameNode: FrameNode) {
    let userConfigBorderWidth = frameNode?.getUserConfigBorderWidth(); // 获取用户设置的边框宽度
    console.log(`${TEST_TAG} ${JSON.stringify(userConfigBorderWidth)}`);
  }


  getUserConfigPadding(frameNode: FrameNode) {
    let userConfigPadding = frameNode?.getUserConfigPadding(); // 获取用户设置的内边距
    console.log(`${TEST_TAG} ${JSON.stringify(userConfigPadding)}`);
  }


  getUserConfigMargin(frameNode: FrameNode) {
    let userConfigMargin = frameNode?.getUserConfigMargin(); // 获取用户设置的外边距
    console.log(`${TEST_TAG} ${JSON.stringify(userConfigMargin)}`);
  }


  getUserConfigSize(frameNode: FrameNode) {
    let userConfigSize = frameNode?.getUserConfigSize(); // 获取用户设置的宽高
    console.log(`${TEST_TAG} ${JSON.stringify(userConfigSize)}`);
  }


  getId(frameNode: FrameNode) {
    let id = frameNode?.getId(); // 获取用户设置的节点ID
    console.log(`${TEST_TAG} ${id}`);
  }


  getUniqueId(frameNode: FrameNode) {
    let uniqueId = frameNode?.getUniqueId(); // 获取系统分配的唯一标识的节点UniqueID
    console.log(`${TEST_TAG} ${uniqueId}`);
  }


  getNodeType(frameNode: FrameNode) {
    let nodeType = frameNode?.getNodeType(); // 获取节点的类型
    console.log(`${TEST_TAG} ${nodeType}`);
  }


  getOpacity(frameNode: FrameNode) {
    let opacity = frameNode?.getOpacity(); // 获取节点的不透明度
    console.log(`${TEST_TAG} ${JSON.stringify(opacity)}`);
  }


  isVisible(frameNode: FrameNode) {
    let visible = frameNode?.isVisible(); // 获取节点是否可见
    console.log(`${TEST_TAG} ${JSON.stringify(visible)}`);
  }


  isClipToFrame(frameNode: FrameNode) {
    let clipToFrame = frameNode?.isClipToFrame(); // 获取节点是否是剪裁到组件区域
    console.log(`${TEST_TAG} ${JSON.stringify(clipToFrame)}`);
  }


  isAttached(frameNode: FrameNode) {
    let attached = frameNode?.isAttached(); // 获取节点是否被挂载到主节点树上
    console.log(`${TEST_TAG} ${JSON.stringify(attached)}`);
  }


  getInspectorInfo(frameNode: FrameNode) {
    let inspectorInfo = frameNode?.getInspectorInfo(); // 获取节点的结构信息
    console.log(`${TEST_TAG} ${JSON.stringify(inspectorInfo)}`);
  }
}


@Entry
@Component
struct CustomFrameNode5Page {
  private myNodeController: MyNodeController = new MyNodeController();
  @State index: number = 0;


  build() {
    Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceBetween }) {
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


      Button("getUserConfigBorderWidth")
        .width(300)
        .onClick(() => {
          const uiContext: UIContext = this.getUIContext();
          if (uiContext) {
            const node: FrameNode | null = uiContext.getFrameNodeById(ID_BUILD_TEXT) || null;
            if (node) {
              this.myNodeController.getUserConfigBorderWidth(node);
            }
          }
        })
      Button("getUserConfigPadding")
        .width(300)
        .onClick(() => {
          const uiContext: UIContext = this.getUIContext();
          if (uiContext) {
            const node: FrameNode | null = uiContext.getFrameNodeById(ID_BUILD_TEXT) || null;
            if (node) {
              this.myNodeController.getUserConfigPadding(node);
            }
          }
        })
      Button("getUserConfigMargin")
        .width(300)
        .onClick(() => {
          const uiContext: UIContext = this.getUIContext();
          if (uiContext) {
            const node: FrameNode | null = uiContext.getFrameNodeById(ID_BUILD_TEXT) || null;
            if (node) {
              this.myNodeController.getUserConfigMargin(node);
            }
          }
        })
      Button("getUserConfigSize")
        .width(300)
        .onClick(() => {
          const uiContext: UIContext = this.getUIContext();
          if (uiContext) {
            const node: FrameNode | null = uiContext.getFrameNodeById(ID_BUILD_TEXT) || null;
            if (node) {
              this.myNodeController.getUserConfigSize(node);
            }
          }
        })
      Button("getId")
        .width(300)
        .onClick(() => {
          const uiContext: UIContext = this.getUIContext();
          if (uiContext) {
            const node: FrameNode | null = uiContext.getFrameNodeById(ID_BUILD_TEXT) || null;
            if (node) {
              this.myNodeController.getId(node);
            }
          }
        })
      Button("getUniqueId")
        .width(300)
        .onClick(() => {
          const uiContext: UIContext = this.getUIContext();
          if (uiContext) {
            const node: FrameNode | null = uiContext.getFrameNodeById(ID_BUILD_TEXT) || null;
            if (node) {
              this.myNodeController.getUniqueId(node);
            }
          }
        })
      Button("getNodeType")
        .width(300)
        .onClick(() => {
          const uiContext: UIContext = this.getUIContext();
          if (uiContext) {
            const node: FrameNode | null = uiContext.getFrameNodeById(ID_BUILD_TEXT) || null;
            if (node) {
              this.myNodeController.getNodeType(node);
            }
          }
        })
      Button("getOpacity")
        .width(300)
        .onClick(() => {
          const uiContext: UIContext = this.getUIContext();
          if (uiContext) {
            const node: FrameNode | null = uiContext.getFrameNodeById(ID_BUILD_TEXT) || null;
            if (node) {
              this.myNodeController.getOpacity(node);
            }
          }
        })
      Button("isVisible")
        .width(300)
        .onClick(() => {
          const uiContext: UIContext = this.getUIContext();
          if (uiContext) {
            const node: FrameNode | null = uiContext.getFrameNodeById(ID_BUILD_TEXT) || null;
            if (node) {
              this.myNodeController.isVisible(node);
            }
          }
        })
      Button("isClipToFrame")
        .width(300)
        .onClick(() => {
          const uiContext: UIContext = this.getUIContext();
          if (uiContext) {
            const node: FrameNode | null = uiContext.getFrameNodeById(ID_BUILD_TEXT) || null;
            if (node) {
              this.myNodeController.isClipToFrame(node);
            }
          }
        })
      Button("isAttached")
        .width(300)
        .onClick(() => {
          const uiContext: UIContext = this.getUIContext();
          if (uiContext) {
            const node: FrameNode | null = uiContext.getFrameNodeById(ID_BUILD_TEXT) || null;
            if (node) {
              this.myNodeController.isAttached(node);
            }
          }
        })
      Button("remove Text")
        .width(300)
        .onClick(() => {
          const uiContext: UIContext = this.getUIContext();
          if (uiContext) {
            const node: FrameNode | null = uiContext.getFrameNodeById(ID_TEXT_TYPE_NODE) || null;
            if (node) {
              this.myNodeController.removeChild(node);
              this.myNodeController.isAttached(node);
            }
          }
        })
      Button("getInspectorInfo")
        .width(300)
        .onClick(() => {
          const uiContext: UIContext = this.getUIContext();
          if (uiContext) {
            const node: FrameNode | null = uiContext.getFrameNodeById(ID_BUILD_TEXT) || null;
            if (node) {
              this.myNodeController.getInspectorInfo(node);
            }
          }
        })
      Button("getCustomProperty")
        .width(300)
        .onClick(() => {
          const uiContext: UIContext = this.getUIContext();
          if (uiContext) {
            const node: FrameNode | null = uiContext.getFrameNodeById(ID_BUILD_TEXT) || null;
            if (node) {
              const property = node.getCustomProperty("key1");
              console.log(TEST_TAG, JSON.stringify(property));
            }
          }
        })
    }
    .padding({
      left: 35,
      right: 35,
      top: 35,
      bottom: 35
    })
    .width("100%")
    .height("100%")
  }
}