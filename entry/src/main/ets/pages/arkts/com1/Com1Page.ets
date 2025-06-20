// Index.ets
import { taskpool } from '@kit.ArkTS';
import { IconItemSource } from './IconItemSource';
import { loadPicture } from './IndependentTask';

@Entry
@Component
struct Com1Page {
  @State message: string = 'Hello World';

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            let iconItemSourceList: IconItemSource[] = [];
            // 创建Task
            let lodePictureTask: taskpool.Task = new taskpool.Task(loadPicture, 30);
            // 执行Task，并返回结果
            taskpool.execute(lodePictureTask).then((res: object) => {
              // loadPicture方法的执行结果
              iconItemSourceList = res as IconItemSource[];
            })
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}