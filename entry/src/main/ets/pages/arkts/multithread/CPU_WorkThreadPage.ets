// Index.ets
import { worker } from '@kit.ArkTS';


const workerInstance: worker.ThreadWorker = new worker.ThreadWorker('entry/ets/workers/Worker4.ts');

let done = false;

// 接收Worker子线程的结果
workerInstance.onmessage = (() => {
  console.info('MyWorker.ts onmessage');
  if (!done) {
    workerInstance.postMessage({ 'type': 1, 'value': 0 });
    done = true;
  }
})

workerInstance.onerror = (() => {
  // 接收Worker子线程的错误信息
})

// 向Worker子线程发送训练消息
workerInstance.postMessage({ 'type': 0 });

@Entry
@Component
struct WorkThreadPage {
  @State message: string = 'Hello World';

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('WorkThreadPageHelloWorld')
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