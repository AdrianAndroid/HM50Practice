import { RenderNode, FrameNode, NodeController, ShapeMask, ShapeClip } from '@kit.ArkUI';


const TEST_TAG: string = "RenderNode";
const mask = new ShapeMask();
mask.setRectShape({ left: 0, right: 150, top: 0, bottom: 150 });
mask.fillColor = 0X55FF0000;
mask.strokeColor = 0XFFFF0000;
mask.strokeWidth = 24;

const clip = new ShapeClip();
clip.setCommandPath({ commands: "M100 0 L0 100 L50 200 L150 200 L200 100 Z" });

const renderNode = new RenderNode();
renderNode.backgroundColor = 0xffff0000;
renderNode.size = { width: 100, height: 100 };


class MyNodeController extends NodeController {
  private rootNode: FrameNode | null = null;
  makeNode(uiContext: UIContext): FrameNode | null {
    this.rootNode = new FrameNode(uiContext);
    const rootRenderNode = this.rootNode.getRenderNode();
    if (rootRenderNode !== null) {
      rootRenderNode.appendChild(renderNode);
    }
    return this.rootNode;
  }
}

/**
 * 设置和获取渲染相关属性
 */
@Entry
@Component
struct RenderNode2Page {
  private myNodeController: MyNodeController = new MyNodeController();
  build() {
    Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceBetween }) {
      Column() {
        NodeContainer(this.myNodeController)
      }
      Button("position")
        .width(300)
        .onClick(() => {
          renderNode.position = { x: 10, y: 10 };
          console.log(TEST_TAG + " position:" + JSON.stringify(renderNode.position));
        })
      Button("pivot")
        .width(300)
        .onClick(() => {
          renderNode.pivot = { x: 0.5, y: 0.6 };
          console.log(TEST_TAG + " pivot:" + JSON.stringify(renderNode.pivot));
        })
      Button("scale")
        .width(300)
        .onClick(() => {
          renderNode.scale = { x: 0.5, y: 1 };
          console.log(TEST_TAG + " scale:" + JSON.stringify(renderNode.scale));
        })
      Button("translation")
        .width(300)
        .onClick(() => {
          renderNode.translation = { x: 100, y: 0 };
          console.log(TEST_TAG + " translation:" + JSON.stringify(renderNode.translation));
        })
      Button("rotation")
        .width(300)
        .onClick(() => {
          renderNode.rotation = { x: 45, y: 0, z: 0 };
          console.log(TEST_TAG + " rotation:" + JSON.stringify(renderNode.rotation));
        })
      Button("transform")
        .width(300)
        .onClick(() => {
          renderNode.transform = [
            1, 0, 0, 0,
            0, 2, 0, 0,
            0, 0, 1, 0,
            0, 0, 0, 1
          ];
          console.log(TEST_TAG + " transform:" + JSON.stringify(renderNode.transform));
        })
      Button("shadow")
        .width(300)
        .onClick(() => {
          renderNode.shadowElevation = 10;
          renderNode.shadowColor = 0XFF00FF00;
          renderNode.shadowOffset = { x: 10, y: 10 };
          renderNode.shadowAlpha = 0.1;
          console.log(TEST_TAG + " shadowElevation:" + JSON.stringify(renderNode.shadowElevation));
          console.log(TEST_TAG + " shadowColor:" + JSON.stringify(renderNode.shadowColor));
          console.log(TEST_TAG + " shadowOffset:" + JSON.stringify(renderNode.shadowOffset));
          console.log(TEST_TAG + " shadowAlpha:" + JSON.stringify(renderNode.shadowAlpha));
        })
      Button("shadowRadius")
        .width(300)
        .onClick(() => {
          renderNode.shadowOffset = { x: 10, y: 10 };
          renderNode.shadowAlpha = 0.7
          renderNode.shadowRadius = 30;
          console.log(TEST_TAG + " shadowOffset:" + JSON.stringify(renderNode.shadowOffset));
          console.log(TEST_TAG + " shadowAlpha:" + JSON.stringify(renderNode.shadowAlpha));
          console.log(TEST_TAG + " shadowRadius:" + JSON.stringify(renderNode.shadowRadius));
        })
      Button("border")
        .width(300)
        .onClick(() => {
          renderNode.borderWidth = { left: 8, top: 8, right: 8, bottom: 8 };
          renderNode.borderStyle = { left: BorderStyle.Solid, top: BorderStyle.Dotted, right: BorderStyle.Dashed, bottom: BorderStyle.Solid }
          renderNode.borderColor = { left: 0xFF0000FF, top: 0xFF0000FF, right: 0xFF0000FF, bottom: 0xFF0000FF };
          renderNode.borderRadius = { topLeft: 32, topRight: 32, bottomLeft: 32, bottomRight: 32 };
          console.log(TEST_TAG + " borderWidth:" + JSON.stringify(renderNode.borderWidth));
          console.log(TEST_TAG + " borderStyle:" + JSON.stringify(renderNode.borderStyle));
          console.log(TEST_TAG + " borderColor:" + JSON.stringify(renderNode.borderColor));
          console.log(TEST_TAG + " borderRadius:" + JSON.stringify(renderNode.borderRadius));
        })
      Button("shapeMask")
        .width(300)
        .onClick(() => {
          renderNode.shapeMask = mask;
          console.log(TEST_TAG + " shapeMask:" + JSON.stringify(renderNode.shapeMask));
        })
      Button("shapeClip")
        .width(300)
        .onClick(() => {
          renderNode.shapeClip = clip;
          console.log(TEST_TAG + " shapeMask:" + JSON.stringify(renderNode.shapeMask));
        })
    }
    .padding({ left: 35, right: 35, top: 35, bottom: 35 })
    .width("100%")
    .height("100%")
  }
}