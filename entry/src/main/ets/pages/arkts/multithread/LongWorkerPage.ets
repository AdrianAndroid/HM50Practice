// Index.ets
import { worker } from '@kit.ArkTS';
// Index.ets
const workerInstance: worker.ThreadWorker = new worker.ThreadWorker('entry/ets/workers/Worker6.ets');

@Entry
@Component
struct LongWorkerPage {
  build() {
    Column() {
      Blank().height(200)
      Text("Listener task")
        .id('HelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
          workerInstance.postMessage({type: 'start'})
          workerInstance.onmessage = (event) => {
            console.info('Worker6 UI主线程收到消息:', event.data);
          }
          // 10秒后停止worker
          setTimeout(() => {
            workerInstance.postMessage({ type: 'stop' });
          }, 10000);
        })
    }
    .height('100%')
    .width('100%')
  }
}