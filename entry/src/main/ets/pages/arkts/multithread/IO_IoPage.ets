import { write } from './write'
import { BusinessError } from '@kit.BasicServicesKit';
import { taskpool } from '@kit.ArkTS';
import { common } from '@kit.AbilityKit';

@Concurrent
async function concurrentTest(context: common.UIAbilityContext): Promise<boolean> {
  let filePath1: string = context.filesDir + "/path1.txt"; // 应用文件路径
  let filePath2: string = context.filesDir + "/path2.txt";
  // 循环写文件操作
  let fileList: Array<string> = [];
  fileList.push(filePath1);
  fileList.push(filePath2)
  for (let i: number = 0; i < fileList.length; i++) {
    write('Hello World!', fileList[i]).then(() => {
      console.info(`Succeeded in writing the file. FileList: ${fileList[i]}`);
    }).catch((err: BusinessError) => {
      console.error(`Failed to write the file. Code is ${err.code}, message is ${err.message}`)
      return false;
    })
  }
  return true;
}

@Entry
@Component
struct IO_IoPage {
  @State message: string = 'Hello World';
  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            let context = getContext() as common.UIAbilityContext;

            // 使用TaskPool执行包含密集I/O的并发函数
            // 数组较大时，I/O密集型任务任务分发也会抢占UI主线程，需要使用多线程能力
            taskpool.execute(concurrentTest, context).then((o: object) => {
              // 调度结果处理
              console.info(`taskpool: execute success => ${o}`)
            })
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}