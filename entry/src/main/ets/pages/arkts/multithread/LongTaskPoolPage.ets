import { sensor } from '@kit.SensorServiceKit';
import { JSON, taskpool } from '@kit.ArkTS';
import { BusinessError, emitter } from '@kit.BasicServicesKit';
import Logger from '../../../common/Logger';

// Index.ets
@Concurrent
async function SensorListener() : Promise<void> {
  sensor.on(sensor.SensorId.ACCELEROMETER, (data) => {
    Logger.debug('LongTaskPoolPage', `ACCELEROMETER data=>${JSON.stringify(data)}`)
    emitter.emit({ eventId: 0 }, { data: data });
  }, { interval: 1000000000 });

  emitter.on({ eventId: 1 }, () => {
    Logger.debug('LongTaskPoolPage', 'ACCELEROMETER off')
    sensor.off(sensor.SensorId.ACCELEROMETER)
    emitter.off(1)
  })
}

@Entry
@Component
struct LongTaskPoolPage {
  sensorTask?: taskpool.LongTask

  build() {
    Column({space: 10}) {
      Blank()
        .height(200)
      Button("Add listener")
        .id('HelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
          this.sensorTask = new taskpool.LongTask(SensorListener);
          emitter.on({ eventId: 0 }, (data) => {
            // Do something here
            Logger.debug('LongTaskPoolPage',`Receive ACCELEROMETER data: {${data.data?.x}, ${data.data?.y}, ${data.data?.z}`);
          });
          taskpool.execute(this.sensorTask).then(() => {
            Logger.debug('LongTaskPoolPage',"Add listener of ACCELEROMETER success");
          }).catch((e: BusinessError) => {
            // Process error
          })
        })
      Button("Delete listener")
        .id('HelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
          emitter.emit({ eventId: 1 });
          emitter.off(0);
          if(this.sensorTask != undefined) {
            taskpool.terminateTask(this.sensorTask);
          } else {
            console.error("sensorTask is undefined.");
          }
        })
    }
    .height('100%')
    .width('100%')
  }
}