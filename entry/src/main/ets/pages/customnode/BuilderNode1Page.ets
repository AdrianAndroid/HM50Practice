import { BuilderNode, FrameNode, NodeController, RenderNode, UIContext } from '@kit.ArkUI';


class Params {
  text: string = "";


  constructor(text: string) {
    this.text = text;
  }
}


@Builder
function buildText1(params: Params) {
  Column() {
    Text(params.text)
      .fontSize(50)
      .fontWeight(FontWeight.Bold)
      .margin({ bottom: 36 })
  }
}

@Builder
function buildText2(params: Params) {
  Column() {
    Text(params.text)
      .fontSize(50)
      .fontWeight(FontWeight.Bold)
      .margin({ bottom: 36 })
  }
}

@Builder
function buildText3(params: Params) {
  Column() {
    Text(params.text)
      .fontSize(50)
      .fontWeight(FontWeight.Bold)
      .margin({ bottom: 36 })
    TextBuilder({ message: params.text }) // 自定义组件
  }
}

class TextNodeController1 extends NodeController {
  private textNode: BuilderNode<[Params]> | null = null;
  private message: string = "DEFAULT";


  constructor(message: string) {
    super();
    this.message = message;
  }


  makeNode(context: UIContext): FrameNode | null {
    this.textNode = new BuilderNode(context);
    this.textNode.build(wrapBuilder<[Params]>(buildText1), new Params(this.message))
    return this.textNode.getFrameNode();
  }
}


class TextNodeController2 extends NodeController {
  private rootNode: FrameNode | null = null;
  private textNode: BuilderNode<[Params]> | null = null;
  private message: string = "DEFAULT";

  constructor(message: string) {
    super();
    this.message = message;
  }

  makeNode(context: UIContext): FrameNode | null {
    this.rootNode = new FrameNode(context);
    let renderNode = new RenderNode();
    renderNode.clipToFrame = false;

    this.textNode = new BuilderNode(context, { selfIdealSize: { width: 150, height: 150 } });
    this.textNode.build(wrapBuilder<[Params]>(buildText2), new Params(this.message));

    const textRenderNode = this.textNode?.getFrameNode()?.getRenderNode();

    const rootRenderNode = this.rootNode.getRenderNode();
    if (rootRenderNode !== null) {
      rootRenderNode.appendChild(renderNode);
      renderNode.appendChild(textRenderNode);
    }

    return this.rootNode;
  }
}

class TextNodeController3 extends NodeController {
  private textNode: BuilderNode<[Params]> | null = null;
  private message: string = "";

  constructor(message: string) {
    super()
    this.message = message
  }

  makeNode(context: UIContext): FrameNode | null {
    this.textNode = new BuilderNode(context);
    this.textNode.build(wrapBuilder<[Params]>(buildText3), new Params(this.message))
    return this.textNode.getFrameNode();
  }

  update(message: string) {
    if (this.textNode !== null) {
      // 调用update进行更新。
      this.textNode.update(new Params(message));
    }
  }
}

// 自定义组件
@Component
struct TextBuilder {
  // 作为自定义组件中需要更新的属性，数据类型为基础属性，定义为@Prop
  @Prop message: string = "TextBuilder";

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 36 })
          .backgroundColor(Color.Gray)
      }
    }
  }
}

@Builder
function ButtonBuilder(params: Params) {
  Column() {
    Button(`button ` + params.text)
      .borderWidth(2)
      .backgroundColor(Color.Orange)
      .width("100%")
      .height("100%")
      .gesture(
        TapGesture()
          .onAction((event: GestureEvent) => {
            console.log("TapGesture");
          })
      )
  }
  .width(500)
  .height(300)
  .backgroundColor(Color.Gray)
}

class MyNodeController extends NodeController {
  private rootNode: BuilderNode<[Params]> | null = null;
  private wrapBuilder: WrappedBuilder<[Params]> = wrapBuilder(ButtonBuilder);

  makeNode(uiContext: UIContext): FrameNode | null {
    this.rootNode = new BuilderNode(uiContext);
    this.rootNode.build(this.wrapBuilder, { text: "this is a string" })
    return this.rootNode.getFrameNode();
  }

  postTouchEvent(touchEvent: TouchEvent): void {
    if (this.rootNode == null) {
      return;
    }
    let result = this.rootNode.postTouchEvent(touchEvent);
    console.log("result " + result);
  }
}

/**
 * BuilderNode的根节点直接作为NodeController的makeNode返回值。
 */
@Entry
@Component
struct BuilderNode1Page {
  @State message: string = "hello";
  private textNodeController3: TextNodeController3 = new TextNodeController3(this.message);
  private nodeController: MyNodeController = new MyNodeController();
  private count = 0;

  build() {
    Scroll() {
      Column() {
        Text('BuilderNode的根节点直接作为NodeController的makeNode返回值')
        NodeContainer(new TextNodeController1(this.message))
          .width('100%')
          .height(100)
          .backgroundColor('#FFF0F0F0')
        Text('BuilderNode的RenderNode挂载其它RenderNode下时，需要明确定义selfIdeaSize的大小作为BuilderNode的布局约束。不推荐通过该方式挂载节点')
        NodeContainer(new TextNodeController2(this.message))
          .width('100%')
          .height(100)
          .backgroundColor('#FFF0F0F0')
        Text('更新原生组件树')
        NodeContainer(this.textNodeController3)
          .width('100%')
          .height(200)
          .backgroundColor('#FFF0F0F0')
        Button('Update')
          .onClick(() => {
            this.count += 1;
            const message = "Update " + this.count.toString();
            this.textNodeController3.update(message);
          })
        Text('通过postTouchEvent向BuilderNode对应的节点树中注入触摸事件')
        NodeContainer(this.nodeController)
          .height(300)
          .width(500)
        Column()
          .width(500)
          .height(300)
          .borderWidth(5)
          .backgroundColor(Color.Pink)
          .onTouch((event) => {
            if (event != undefined) {
              this.nodeController.postTouchEvent(event);
            }
          })
      }
    }
    .width('100%')
    .height('100%')
  }
}