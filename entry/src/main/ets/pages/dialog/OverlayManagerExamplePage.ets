import { ComponentContent, OverlayManager, router } from '@kit.ArkUI';

class Params2 {
  text: string = ""
  offset: Position

  constructor(text: string, offset: Position) {
    this.text = text
    this.offset = offset
  }
}

class Params {
  context: UIContext
  offset: Position
  constructor(context: UIContext, offset: Position) {
    this.context = context
    this.offset = offset
  }
}

@Builder
function builderOverlay(params: Params) {
  Column() {
    Stack(){
    }.width(50).height(50).backgroundColor(Color.Yellow).position(params.offset).borderRadius(50)
    .onClick(() => {
      params.context.showAlertDialog(
        {
          title: 'title',
          message: 'Text',
          autoCancel: true,
          alignment: DialogAlignment.Center,
          gridCount: 3,
          confirm: {
            value: 'Button',
            action: () => {}
          },
          cancel: () => {}
        }
      )
    })
  }.focusable(false).width('100%').height('100%').hitTestBehavior(HitTestMode.Transparent)
}

@Builder
function builderText(params: Params2) {
  Column() {
    Text(params.text)
      .fontSize(30)
      .fontWeight(FontWeight.Bold)
  }.offset(params.offset)
}

@Entry
@Component
struct OverlayManagerExamplePage {
  @State message: string = 'ComponentContent';
  @StorageLink('contentArray') contentArray: ComponentContent<Params2>[] = []
  @StorageLink('componentContentIndex') componentContentIndex: number = 0
  @StorageLink('arrayIndex') arrayIndex: number = 0
  @StorageLink("componentOffset") componentOffset: Position = { x: 0, y: 80 }
  private uiContext: UIContext = this.getUIContext()
  private overlayNode: OverlayManager = this.uiContext.getOverlayManager()
  private overlayContent:ComponentContent<Params>[] = []
  controller: TextInputController = new TextInputController()


  aboutToAppear(): void {
    let uiContext = this.getUIContext();
    let componentContent = new ComponentContent(
      this.uiContext, wrapBuilder<[Params]>(builderOverlay),
      new Params(uiContext, {x:0, y: 100})
    )
    this.overlayNode.addComponentContent(componentContent, 0)
    this.overlayContent.push(componentContent)
  }

  aboutToDisappear(): void {
    let componentContent = this.overlayContent.pop()
    this.overlayNode.removeComponentContent(componentContent)
  }


  build() {
    Column({ space: 10 }) {
      Button("递增componentContentIndex: " + this.componentContentIndex).onClick(() => {
        ++this.componentContentIndex
      })
      Button("递减componentContentIndex: " + this.componentContentIndex).onClick(() => {
        --this.componentContentIndex
      })
      Button("增加ComponentContent" + this.contentArray.length).onClick(() => {
        let componentContent = new ComponentContent(
          this.uiContext, wrapBuilder<[Params2]>(builderText),
          new Params2(this.message + (this.contentArray.length), this.componentOffset)
        )
        this.contentArray.push(componentContent)
        this.overlayNode.addComponentContent(componentContent, this.componentContentIndex)
      })
      Button("递增arrayIndex: " + this.arrayIndex).onClick(() => {
        ++this.arrayIndex
      })
      Button("递减arrayIndex: " + this.arrayIndex).onClick(() => {
        --this.arrayIndex
      })
      Button("删除ComponentContent" + this.arrayIndex).onClick(() => {
        if (this.arrayIndex >= 0 && this.arrayIndex < this.contentArray.length) {
          let componentContent = this.contentArray.splice(this.arrayIndex, 1)
          this.overlayNode.removeComponentContent(componentContent.pop())
        } else {
          console.info("arrayIndex有误")
        }
      })
      Button("显示ComponentContent" + this.arrayIndex).onClick(() => {
        if (this.arrayIndex >= 0 && this.arrayIndex < this.contentArray.length) {
          let componentContent = this.contentArray[this.arrayIndex]
          this.overlayNode.showComponentContent(componentContent)
        } else {
          console.info("arrayIndex有误")
        }
      })
      Button("隐藏ComponentContent" + this.arrayIndex).onClick(() => {
        if (this.arrayIndex >= 0 && this.arrayIndex < this.contentArray.length) {
          let componentContent = this.contentArray[this.arrayIndex]
          this.overlayNode.hideComponentContent(componentContent)
        } else {
          console.info("arrayIndex有误")
        }
      })
      Button("显示所有ComponentContent").onClick(() => {
        this.overlayNode.showAllComponentContents()
      })
      Button("隐藏所有ComponentContent").onClick(() => {
        this.overlayNode.hideAllComponentContents()
      })

      Button("跳转页面").onClick(() => {
        router.pushUrl({
          url: 'pages/Second'
        })
      })
    }
    .width('100%')
    .height('100%')
  }
}