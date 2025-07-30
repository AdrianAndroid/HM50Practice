import { taskpool } from '@kit.ArkTS';
import { BusinessError } from '@kit.BasicServicesKit';

@Concurrent
function adjustImageValue(arrayBuffer: ArrayBuffer): ArrayBuffer {
  // 对arrayBuffer进行操作
  return arrayBuffer; // 返回值默认转移
}

function createImageTask(arrayBuffer: ArrayBuffer, isParamsByTransfer: boolean): taskpool.Task {
  let task: taskpool.Task = new taskpool.Task(adjustImageValue, arrayBuffer);
  if (!isParamsByTransfer) { // 是否使用转移方式
    // 传递空数组[]，全部arrayBuffer参数传递均采用拷贝方式
    task.setTransferList([]);
  }
  return task;
}

/**
 * TaskPool简介：https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/taskpool-introduction
 */
@Entry
@Component
struct ComArrayBufferPage {
  build() {
    Column() {
      Button('111111')
        .onClick(() => {
          let taskNum = 4;
          let arrayBuffer = new ArrayBuffer(1024 * 1024);
          let taskPoolGroup = new taskpool.TaskGroup();
          // 创建taskNum个Task
          for (let i: number = 0; i < taskNum; i++) {
            let arrayBufferSlice: ArrayBuffer =
              arrayBuffer.slice(arrayBuffer.byteLength / taskNum * i, arrayBuffer.byteLength / taskNum * (i + 1));
            // 使用拷贝方式传入ArrayBuffer，所以isParamsByTransfer为false
            taskPoolGroup.addTask(createImageTask(arrayBufferSlice, false));
          }
          // 执行Task
          taskpool.execute(taskPoolGroup).then((data) => {
            // 返回结果，对数组拼接，获得最终结果
          }).catch((e: BusinessError) => {
            console.error(e.message);
          })
        })

      Button('22222222')
        .onClick(() => {
          const buffer = new ArrayBuffer(1);
          const group = new taskpool.TaskGroup();
          const task1 = new taskpool.Task(printArrayBuffer1, buffer);
          const task2 = new taskpool.Task(printArrayBuffer2, buffer);
          const task3 = new taskpool.Task(printArrayBuffer3, buffer);
          group.addTask(task1);
          group.addTask(task2);
          group.addTask(task3);
          task1.setCloneList([buffer]);
          task2.setCloneList([buffer]);
          task3.setCloneList([buffer]);
          for (let i = 0; i < 5; i++) {
            taskpool.execute(group).then(() => {
              console.info('execute group success');
            }).catch((e: BusinessError) => {
              console.error(`execute group error: ${e.message}`);
            }).finally(() => {
              console.log('finally')
            })
          }
        })

      Button('22222222')
        .onClick(() => {
            concurrentFunc()
        });
    }
    .height('100%')
    .width('100%')
  }
}

@Concurrent
function add(num1: number, num2: number): number {
  return num1 + num2;
}

async function concurrentFunc() {
  try {
    const task: taskpool.Task = new taskpool.Task(add, 1, 2);
    console.info(`taskpool res is: ${await taskpool.execute(task)}`); // 输出结果：taskpool res is: 3
  } catch (e) {
    console.error(`taskpool execute error is: ${e}}`);
  }
}


@Concurrent
function printArrayBuffer1(buffer: ArrayBuffer) {
  console.log('printArrayBuffer1 size -> ' + buffer.byteLength);
  return buffer;
}

@Concurrent
function printArrayBuffer2(buffer: ArrayBuffer) {
  console.log('printArrayBuffer2 size -> ' + buffer.byteLength);
  return buffer;
}

@Concurrent
function printArrayBuffer3(buffer: ArrayBuffer) {
  console.log('printArrayBuffer3 size -> ' + buffer.byteLength);
  return buffer;
}
