import { FrameNode, NodeController, RenderNode } from '@kit.ArkUI';


const TEST_TAG: string = "RenderNode";
const renderNode = new RenderNode();
renderNode.frame = { x: 0, y: 0, width: 200, height: 350 };
renderNode.backgroundColor = 0xffff0000;
for (let i = 0; i < 5; i++) {
  const node = new RenderNode();
  // 设置node节点的Frame大小
  node.frame = { x: 10, y: 10 + 60 * i, width: 50, height: 50 };
  // 设置node节点的背景颜色
  node.backgroundColor = 0xff00ff00;
  // 将新增节点挂载在renderNode上
  renderNode.appendChild(node);
}


class MyNodeController extends NodeController {
  private rootNode: FrameNode | null = null;

  makeNode(uiContext: UIContext): FrameNode | null {
    this.rootNode = new FrameNode(uiContext);
    const rootRenderNode = this.rootNode?.getRenderNode();
    if (rootRenderNode) {
      rootRenderNode.appendChild(renderNode);
    }
    return this.rootNode;
  }
}


/**
 * 操作节点树
 */
@Entry
@Component
struct RenderNode1Page {
  private myNodeController: MyNodeController = new MyNodeController();

  build() {
    Row() {
      NodeContainer(this.myNodeController)
        .width(200)
        .height(350)
      Button('getNextSibling')
        .onClick(() => {
          const child = renderNode.getChild(1);
          const nextSibling = child!.getNextSibling()
          if (child === null || nextSibling === null) {
            console.log(TEST_TAG + ' the child or nextChild is null');
          } else {
            // 获取子节点的位置信息
            console.log(`${TEST_TAG} the position of child is x: ${child.position.x}, y: ${child.position.y}, ` + `the position of nextSibling is x: ${nextSibling.position.x}, y: ${nextSibling.position.y}`);
          }
        })
    }
  }
}