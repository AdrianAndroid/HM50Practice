import { taskpool } from '@kit.ArkTS';
import { BusinessError } from '@kit.BasicServicesKit';

@Concurrent
function adjustImageValue(arrayBuffer: ArrayBuffer): ArrayBuffer {
  // 对arrayBuffer进行操作
  return arrayBuffer;  // 返回值默认转移
}

function createImageTask(arrayBuffer: ArrayBuffer, isParamsByTransfer: boolean): taskpool.Task {
  let task: taskpool.Task = new taskpool.Task(adjustImageValue, arrayBuffer);
  if (!isParamsByTransfer) { // 是否使用转移方式
    // 传递空数组[]，全部arrayBuffer参数传递均采用拷贝方式
    task.setTransferList([]);
  }
  return task;
}


@Entry
@Component
struct ComArrayBufferPage {
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
          let taskNum = 4;
          let arrayBuffer = new ArrayBuffer(1024 * 1024);
          let taskPoolGroup = new taskpool.TaskGroup();
          // 创建taskNum个Task
          for (let i: number = 0; i < taskNum; i++) {
            let arrayBufferSlice: ArrayBuffer = arrayBuffer.slice(arrayBuffer.byteLength / taskNum * i, arrayBuffer.byteLength / taskNum * (i + 1));
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
    }
    .height('100%')
    .width('100%')
  }
}