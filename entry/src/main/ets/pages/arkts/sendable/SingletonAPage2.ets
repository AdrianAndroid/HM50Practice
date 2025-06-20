import { taskpool } from '@kit.ArkTS';
import { singletonA } from './sharedModule';

@Concurrent
async function increaseCount() {
  await singletonA.increaseCount();
  console.info("SharedModule: count is:" + await singletonA.getCount());
}

@Concurrent
async function printCount() {
  console.info("SharedModule: count is:" + await singletonA.getCount());
}

@Entry
@Component
struct SingletonAPage2 {
  @State message: string = 'Hello World';

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('SingletonAPageHelloWorld')
        .fontSize($r('app.float.page_text_font_size'))
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(() => {
          this.message = 'Welcome';
        })
    }
    .height('100%')
    .width('100%')
  }
}