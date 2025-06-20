import Logger from '../../../common/Logger';
import { ArkTSUtils, collections } from '@kit.ArkTS';

@Entry
@Component
struct ASONPage {
  @State message: string = 'Hello World';

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('ASONPageHelloWorld')
        .fontSize($r('app.float.page_text_font_size'))
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(() => {
          this.message = 'Welcome';
          let arr = new collections.Array(1, 2, 3)
          let json = ArkTSUtils.ASON.stringify(arr)
          Logger.info('ASONPage', json)
          let pa = ArkTSUtils.ASON.parse(json)
          Logger.info('ASONPage', typeof pa)
          Logger.info('ASONPage', `${pa}`)
          Logger.info('ASONPage', `${new collections.Array(pa)}`)
        })
    }
    .height('100%')
    .width('100%')
  }
}