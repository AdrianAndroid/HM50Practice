import { ArkTSUtils, taskpool } from '@kit.ArkTS';

// @Concurrent
// function notifyAll(conditionVariable: ArkTSUtils.locks.AsyncLock) {
//   conditionVariable.notifyAll();
// }
//
// @Concurrent
// function notifyOne(conditionVariable: ArkTSUtils.locks.ConditionVariable) {
//   conditionVariable.notifyOne();
// }
//
// @Concurrent
// async function wait(conditionVariable: ArkTSUtils.locks.ConditionVariable) {
//   await conditionVariable.wait().then(() => {
//     console.log(`TaskPool Thread Wait: success`);
//   });
// }
//
// @Concurrent
// async function waitFor(conditionVariable: ArkTSUtils.locks.ConditionVariable) {
//   await conditionVariable.waitFor(3000).then(() => {
//     console.log(`TaskPool Thread WaitFor: success`);
//   });
// }

@Entry
@Component
struct SendableWaitForPage {
  @State message: string = 'Hello World';

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            // // 创建conditionVariable对象
            // const conditionVariable: ArkTSUtils.locks.ConditionVariable = new ArkTSUtils.locks.ConditionVariable();
            // // 将实例conditionVariable传递给wait线程
            // taskpool.execute(wait, conditionVariable);
            // // 将实例conditionVariable传递给notifyAll线程，唤醒wait线程，日志输出"TaskPool Thread Wait: success"
            // taskpool.execute(notifyAll, conditionVariable);
            // // 将实例conditionVariable传递给waitFor线程
            // taskpool.execute(waitFor, conditionVariable);
            // // 将实例conditionVariable传递给notifyOne线程，唤醒waitFor线程，日志输出"TaskPool Thread WaitFor: success"
            // taskpool.execute(notifyOne, conditionVariable);
            //
            // // 创建有name的conditionVariable对象
            // const conditionVariableRequest: ArkTSUtils.locks.ConditionVariable = ArkTSUtils.locks.ConditionVariable.request("Request1");
            // // 将实例conditionVariableRequest传递给wait线程
            // taskpool.execute(wait, conditionVariableRequest);
            // // 将实例conditionVariableRequest传递给notifyAll线程，唤醒wait线程，日志输出"TaskPool Thread Wait: success"
            // taskpool.execute(notifyAll, conditionVariableRequest);
            // // 将实例conditionVariableRequest传递给waitFor线程
            // taskpool.execute(waitFor, conditionVariableRequest);
            // // 将实例conditionVariableRequest传递给notifyOne线程，唤醒waitFor线程，日志输出"TaskPool Thread WaitFor: success"
            // taskpool.execute(notifyOne, conditionVariableRequest);
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}