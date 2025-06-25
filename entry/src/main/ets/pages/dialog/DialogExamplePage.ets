// Index.ets
import { ComponentContent } from '@kit.ArkUI';
import { PromptActionClass } from './DialogPromptActionClass';


class Params {
  text: string = ""


  constructor(text: string) {
    this.text = text;
  }
}


@Builder
function buildText(params: Params) {
  Column() {
    Text(params.text)
      .fontSize(50)
      .fontWeight(FontWeight.Bold)
      .margin({ bottom: 36 })
    Button('Close')
      .onClick(() => {
        PromptActionClass.closeDialog()
      })
  }.backgroundColor('#FFF0F0F0')
}


@Entry
@Component
struct DialogExamplePage {
  @State message: string = "hello"
  private ctx: UIContext = this.getUIContext();
  private contentNode: ComponentContent<Object> =
    new ComponentContent(this.ctx, wrapBuilder(buildText), new Params(this.message));


  aboutToAppear(): void {
    PromptActionClass.setContext(this.ctx);
    PromptActionClass.setContentNode(this.contentNode);
    PromptActionClass.setOptions({ alignment: DialogAlignment.Top, offset: { dx: 0, dy: 50 } });
  }


  build() {
    Row() {
      Column() {
        Button("open dialog and update options")
          .margin({ top: 50 })
          .onClick(() => {
            PromptActionClass.openDialog()


            setTimeout(() => {
              PromptActionClass.updateDialog({
                alignment: DialogAlignment.Bottom,
                offset: { dx: 0, dy: -50 }
              })
            }, 1500)
          })
        Button("open dialog and update content")
          .margin({ top: 50 })
          .onClick(() => {
            PromptActionClass.openDialog()


            setTimeout(() => {
              this.contentNode.update(new Params('update'))
            }, 1500)
          })
      }
      .width('100%')
      .height('100%')
    }
    .height('100%')
  }
}