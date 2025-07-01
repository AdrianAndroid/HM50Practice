import { NodeController, FrameNode, BuilderNode } from '@kit.ArkUI';
const TEST_TAG: string = "FrameNode";
@Component
struct TestComponent {
  build() {
    Column() {
      Text('This is a BuilderNode.')
        .fontSize(16)
        .fontWeight(FontWeight.Bold)
    }
    .width('100%')
    .backgroundColor(Color.Gray)
  }

  aboutToAppear() {
    console.error(TEST_TAG + ' aboutToAppear');
  }

  aboutToDisappear() {
    console.error(TEST_TAG + ' aboutToDisappear');
  }
}

@Builder
function buildComponent() {
  TestComponent()
}

class MyNodeController extends NodeController {
  private rootNode: FrameNode | null = null;
  private builderNode: BuilderNode<[]> | null = null;

  makeNode(uiContext: UIContext): FrameNode | null {
    this.rootNode = new FrameNode(uiContext);
    this.builderNode = new BuilderNode(uiContext, { selfIdealSize: { width: 200, height: 100 } });
    this.builderNode.build(new WrappedBuilder(buildComponent));
    const rootRenderNode = this.rootNode.getRenderNode();
    if (rootRenderNode !== null) {
      rootRenderNode.size = { width: 200, height: 200 };
      rootRenderNode.backgroundColor = 0xff00ff00;
      rootRenderNode.appendChild(this.builderNode!.getFrameNode()!.getRenderNode());
    }
    return this.rootNode;
  }

  printUniqueId(): void {
    if (this.rootNode !== null && this.builderNode !== null) {
      console.log(`${TEST_TAG} rootNode's uniqueId: ${this.rootNode.getUniqueId()}`);
      const frameNode = this.builderNode.getFrameNode();
      if (frameNode) {
        console.log(`${TEST_TAG} the uniqueId of builderNode's framenode: ${frameNode.getUniqueId()}`);
      } else {
        console.log(`${TEST_TAG} builderNode's framenode is undefined`);
      }
    }
  }

  disposeFrameNode(): void {
    if (this.rootNode !== null && this.builderNode !== null) {
      console.log(`${TEST_TAG} disposeFrameNode`);
      this.rootNode.removeChild(this.builderNode.getFrameNode());
      this.builderNode.dispose();
      this.rootNode.dispose();
    }
  }

  removeBuilderNode(): void {
    const rootRenderNode = this.rootNode!.getRenderNode();
    if (rootRenderNode !== null && this.builderNode !== null && this.builderNode.getFrameNode() !== null) {
      rootRenderNode.removeChild(this.builderNode!.getFrameNode()!.getRenderNode());
    }
  }
}

/**
 * 解除当前FrameNode对象对实体FrameNode节点的引用关系
 */
@Entry
@Component
struct CustomFrameNode6Page {
  private myNodeController: MyNodeController = new MyNodeController();
  build() {
    Column({ space: 4 }) {
      NodeContainer(this.myNodeController)
      Button('FrameNode dispose')
        .onClick(() => {
          this.myNodeController.printUniqueId();
          this.myNodeController.disposeFrameNode();
          this.myNodeController.printUniqueId();
        })
        .width('100%')
    }.expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}