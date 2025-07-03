import { workScheduler } from '@kit.BackgroundTasksKit';
import { BusinessError } from '@kit.BasicServicesKit';
import Constants from '../../common/Constants';

@Entry
@Component
struct DelayTaskPage {
  @State message: string = 'Hello World';

  startDelayTask() {
    const workInfo: workScheduler.WorkInfo = {
      workId: 1,
      networkType: workScheduler.NetworkType.NETWORK_TYPE_WIFI,
      bundleName: Constants.bundleName,
      abilityName: 'EntryWorkSchedulerExtAbility'
    }

    try {
      workScheduler.startWork(workInfo);
      console.info(`startWork success`);
    } catch (error) {
      console.error(`startWork failed. code is ${(error as BusinessError).code} message is ${(error as BusinessError).message}`);
    }
  }

  stopDelayTask() {
    // 创建workinfo
    const workInfo: workScheduler.WorkInfo = {
      workId: 1,
      networkType: workScheduler.NetworkType.NETWORK_TYPE_WIFI,
      bundleName: Constants.bundleName,
      abilityName: 'EntryWorkSchedulerExtAbility'
    }


    try {
      workScheduler.stopWork(workInfo);
      console.info(`stopWork success`);
    } catch (error) {
      console.error(`stopWork failed. code is ${(error as BusinessError).code} message is ${(error as BusinessError).message}`);
    }
  }

  build() {
    Row() {
      Column() {
        Text("Index")
          .fontSize(50)
          .fontWeight(FontWeight.Bold)


        Button() {
          Text('申请延迟任务').fontSize(25).fontWeight(FontWeight.Bold)
        }
        .type(ButtonType.Capsule)
        .margin({ top: 10 })
        .backgroundColor('#0D9FFB')
        .width(250)
        .height(40)
        .onClick(() => {
          // 通过按钮申请长时任务
          this.startDelayTask();
        })


        Button() {
          Text('取消延迟任务').fontSize(25).fontWeight(FontWeight.Bold)
        }
        .type(ButtonType.Capsule)
        .margin({ top: 10 })
        .backgroundColor('#0D9FFB')
        .width(250)
        .height(40)
        .onClick(() => {
          // 通过按钮取消长时任务
          this.stopDelayTask()
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}