import { worker } from '@kit.ArkTS';
import { BusinessError } from '@kit.BasicServicesKit';

function promiseCase() {
  let p: Promise<void> = new Promise<void>((resolve: Function, reject: Function) => {
    setTimeout(() => {
      resolve(1);
    }, 100)
  }).then(undefined, (error: BusinessError) => {
  })
  return p;
}

async function postMessageTest() {
  let ss = new worker.ThreadWorker("entry/ets/workers/Worker3.ets");
  let res = undefined;
  let flag = false;
  let isTerminate = false;
  ss.onexit = () => {
    isTerminate = true;
    console.info("worker:: onexit" );
  }
  // 接收Worker线程发送的消息
  ss.onmessage = (e) => {
    res = e.data;
    flag = true;
    console.info("worker:: res is  " + res);
  }
  // 给Worker线程发送消息
  ss.postMessage("worker:: hello world");
  while (!flag) {
    await promiseCase();
  }

  ss.terminate();
  while (!isTerminate) {
    await promiseCase();
  }
}

@Entry
@Component
struct Com4Page {
  @State message: string = 'Hello World';

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            postMessageTest();
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}