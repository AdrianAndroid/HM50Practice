// Index.ets
import { taskpool } from '@kit.ArkTS';
import { IconItemSource } from './IconItemSource';
import { loadPicture } from './IndependentTask';

@Entry
@Component
struct Com2Page {
  @State message: string = 'Hello World';

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            let iconItemSourceList: IconItemSource[][];
            let taskGroup: taskpool.TaskGroup = new taskpool.TaskGroup();
            taskGroup.addTask(new taskpool.Task(loadPicture, 30));
            taskGroup.addTask(new taskpool.Task(loadPicture, 20));
            taskGroup.addTask(new taskpool.Task(loadPicture, 10));
            taskpool.execute(taskGroup).then((ret: object) => {
              let tmpLength = (ret as IconItemSource[][]).length
              for (let i = 0; i < tmpLength; i++) {
                for (let j = 0; j < ret[i].length; j++) {
                  iconItemSourceList.push(ret[i][j]);
                }
              }
            })
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}