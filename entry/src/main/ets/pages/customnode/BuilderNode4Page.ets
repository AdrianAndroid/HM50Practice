// ets/pages/Index.ets
import { BuilderNode, FrameNode, NodeController, UIContext } from '@kit.ArkUI';


@Builder
function buildText() {
  // @Builder中使用语法节点生成BuilderProxyNode
  if (true) {
    MyComponent()
  }
}


@Component
struct MyComponent {
  @StorageLink("isShowText") isShowText: boolean = true;

  build() {
    if (this.isShowText) {
      Column() {
        Text("BuilderNode Reuse")
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
          .padding(16)
      }
    }
  }
}


class TextNodeController extends NodeController {
  private rootNode: FrameNode | null = null;
  private textNode: BuilderNode<[]> | null = null;

  makeNode(context: UIContext): FrameNode | null {
    this.rootNode = new FrameNode(context);

    if (AppStorage.has("textNode")) {
      // 复用AppStorage中的BuilderNode
      this.textNode = AppStorage.get<BuilderNode<[]>>("textNode") as BuilderNode<[]>;
      const parent = this.textNode.getFrameNode()?.getParent();
      if (parent) {
        parent.removeChild(this.textNode.getFrameNode());
      }
    } else {
      this.textNode = new BuilderNode(context);
      this.textNode.build(wrapBuilder<[]>(buildText));
      // 将创建的BuilderNode存入AppStorage
      AppStorage.setOrCreate<BuilderNode<[]>>("textNode", this.textNode);
    }
    this.rootNode.appendChild(this.textNode.getFrameNode());


    return this.rootNode;
  }
}


@Entry({ routeName: "myIndex" })
@Component
struct BuilderNode4Page {
  aboutToAppear(): void {
    AppStorage.setOrCreate<boolean>("isShowText", true);
  }

  build() {
    Row() {
      Column() {
        NodeContainer(new TextNodeController())
          .width('100%')
          .backgroundColor('#FFF0F0F0')
        Button('Router pageTwo')
          .onClick(() => {
            // 改变AppStorage中的状态变量触发Text节点的重新创建
            AppStorage.setOrCreate<boolean>("isShowText", false);


            this.getUIContext().getRouter().replaceNamedRoute({ name: "BuilderNode4PageTwo" });
          })
          .margin({ top: 16 })
      }
      .width('100%')
      .height('100%')
      .padding(16)
    }
    .height('100%')
  }
}