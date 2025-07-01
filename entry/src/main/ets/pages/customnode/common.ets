import { BuilderNode, UIContext } from '@kit.ArkUI'


class Params {
  text: string = "this is a text"
}

let buttonNode: BuilderNode<[Params]> | null = null

@Builder
function buttonBuilder(params: Params) {
  Column() {
    Button(params.text)
      .fontSize(12)
      .borderRadius(8)
      .borderWidth(2)
      .backgroundColor(Color.Orange)
  }
}

export function createNode(uiContext: UIContext) {
  buttonNode = new BuilderNode<[Params]>(uiContext)
  buttonNode.build(wrapBuilder(buttonBuilder), {text: "This is a Button"})
  return buttonNode
}

export function getOrCreateNode(uiContext: UIContext): BuilderNode<[Params]> | null {
  if (buttonNode?.getFrameNode() && buttonNode?.getFrameNode()?.getUniqueId() != -1) {
    return buttonNode
  } else {
    return createNode(uiContext)
  }
}