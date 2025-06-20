import { worker } from '@kit.ArkTS';
import Logger from '../../../common/Logger';

@Entry
@Component
struct MUL_WorkerPage {
  @State message: string = 'Hello World';

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            let w: worker.ThreadWorker = new worker.ThreadWorker('entry/ets/workers/Worker5.ets');
            w.onmessage = (ob: object): void => {
              // 接收Worker子线程的结果
              Logger.debug('MUL_WorkerPage', 'onmessage' + JSON.stringify(ob))
              setTimeout(() => {
                w.terminate()
              }, 2000)
            }
            w.onerror = (): void => {
              // 接收Worker子线程的错误信息
              Logger.debug('MUL_WorkerPage', 'onerror')
            }
            w.onexit = (): void => {
              Logger.debug('MUL_WorkerPage', 'onexit')
            }
            w.onmessageerror = (): void => {
              Logger.debug('MUL_WorkerPage', 'onmessageerror')
            }
            // 向Worker子线程发送Set消息
            w.postMessage({'type': 0, 'data': 'data'})
            // 向Worker子线程发送Get消息
            w.postMessage({'type': 1})
            // ...
            // 根据实际业务，选择时机以销毁线程
            // w.terminate()
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}