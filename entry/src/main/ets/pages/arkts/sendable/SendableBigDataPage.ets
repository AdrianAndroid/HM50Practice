// Index.ets
import { taskpool } from '@kit.ArkTS';
import { testTypeA, testTypeB, Test } from './sendable';
import { BusinessError, emitter } from '@kit.BasicServicesKit';
import Logger from '../../../common/Logger';

// 在并发函数中模拟数据处理
@Concurrent
async function taskFunc(obj: Test) {
  console.info("test task res1 is: " + obj.data1.name + " res2 is: " + obj.data2.name);
}

async function test() {
  // 使用taskpool传递数据
  let a: testTypeA = new testTypeA("testTypeA");
  let b: testTypeB = new testTypeB("testTypeB");
  let obj: Test = new Test(a, b);
  let task: taskpool.Task = new taskpool.Task(taskFunc, obj);
  await taskpool.execute(task);
}

@Concurrent
function SensorListener() {
  // 监听逻辑
  Logger.debug('SendableBigDataPage', 'SensorListener')
}

@Entry
@Component
struct SendableBigDataPage {
  build() {
    Column() {
      Text("Listener task")
        .id('HelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
          let sensorTask = new taskpool.LongTask(SensorListener);
          emitter.on({ eventId: 0 }, (data) => {
            // Do something here
            Logger.debug('SendableBigDataPage', `Receive ACCELEROMETER data: {${data.data?.x}, ${data.data?.y}, ${data.data?.z}`);
          });
          taskpool.execute(sensorTask).then(() => {
            Logger.debug('SendableBigDataPage', "Add listener of ACCELEROMETER success");
          }).catch((e: BusinessError) => {
            // Process error
          })
        })
      Text("Data processing task")
        .id('HelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
          test();
        })
    }
    .height('100%')
    .width('100%')
  }
}