import { FrameNode, NodeController, RenderNode } from '@kit.ArkUI';
import { drawing } from '@kit.ArkGraphics2D';


class MyRenderNode extends RenderNode {
  width: number = 200;
  draw(context: DrawContext) {
    // 获取canvas对象
    const canvas = context.canvas;
    // 创建笔刷
    const brush = new drawing.Brush();
    // 设置笔刷颜色
    brush.setColor({ alpha: 255, red: 255, green: 0, blue: 0 });
    canvas.attachBrush(brush);
    // 绘制矩阵
    canvas.drawRect({ left: 0, right: this.width, top: 0, bottom: 200 });
    canvas.detachBrush();
    console.log(`RenderNode draw width = ${this.width}`);
  }
}


const renderNode = new MyRenderNode();
renderNode.frame = { x: 0, y: 0, width: 300, height: 300 };
renderNode.backgroundColor = 0xff0000ff;
renderNode.opacity = 0.5;


class MyNodeController extends NodeController {
  private rootNode: FrameNode | null = null;
  makeNode(uiContext: UIContext): FrameNode | null {
    this.rootNode = new FrameNode(uiContext);
    const rootRenderNode = this.rootNode?.getRenderNode();
    if (rootRenderNode !== null) {
      rootRenderNode.frame = { x: 0, y: 0, width: 500, height: 500 }
      rootRenderNode.appendChild(renderNode);
    }
    return this.rootNode;
  }
}


@Entry
@Component
struct RenderNode3Page {
  private myNodeController: MyNodeController = new MyNodeController();

  build() {
    Column() {
      NodeContainer(this.myNodeController)
        .width('100%')
      Button('Invalidate')
        .onClick(() => {
          // 同步调用多次，仅触发一次重绘，draw回调中的日志仅打印一次
          renderNode.width += 10;
          renderNode.invalidate();
          renderNode.invalidate();
        })
    }
  }
}