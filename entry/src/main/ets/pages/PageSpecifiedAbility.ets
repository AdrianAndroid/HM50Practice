import { common } from '@kit.AbilityKit';
import { Utils } from '../common/Utils';

@Entry
@Component
struct PageSpecifiedAbility {
  @State message: string = 'Hello World';

  build() {
    Column() {
      Text(this.message)
        .id('PageSpecifiedAbilityHelloWorld')
        .fontSize($r('app.float.page_text_font_size'))
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(() => {
          this.message = 'Welcome';
        })
      Button('Terminate')
        .onClick(() => {
          Utils.finishSelf(getContext(this) as common.UIAbilityContext)
        })
    }
    .height('100%')
    .width('100%')
  }
}