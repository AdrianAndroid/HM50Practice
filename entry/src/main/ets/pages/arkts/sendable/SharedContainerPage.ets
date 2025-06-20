import { ArkTSUtils, collections, taskpool } from '@kit.ArkTS';

@Concurrent
async function add(arr: collections.Array<number>, lock: ArkTSUtils.locks.AsyncLock) {
  await lock.lockAsync(() => {  // 如果不添加异步锁，任务会因为数据竞争冲突，导致抛异常失败
    arr[0]++;
  })
}

@Entry
@Component
struct SharedContainerPage {
  @State message: string = 'Hello World';

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('HelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(() => {
          let taskGroup = new taskpool.TaskGroup();
          let lock = new ArkTSUtils.locks.AsyncLock();
          let arr = collections.Array.create<number>(1, 0);
          let count = 1000;
          while (count--) {
            taskGroup.addTask(add, arr, lock);
          }
          taskpool.execute(taskGroup).then(() => {
            console.info(`Return success: ${arr[0]} === ${count}`);
          }).catch((e: Error) => {
            console.error("Return error.");
          })
        })
    }
    .height('100%')
    .width('100%')
  }
}