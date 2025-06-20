import { freezeObj } from './helper';
import { worker } from '@kit.ArkTS';

@Sendable
export class GlobalConfig {
  // 一些配置属性与方法
  init() {
    // 初始化相关逻辑
    freezeObj(this); // 初始化完成后冻结当前对象
  }
}


@Entry
@Component
struct SendableObjectFreezePage {
  build() {
    Column() {
      Text("Sendable freezeObj Test")
        .id('HelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
          let gConifg = new GlobalConfig();
          gConifg.init();
          const workerInstance = new worker.ThreadWorker('entry/ets/workers/Worker2.ets', { name: "Worker1" });
          workerInstance.postMessage(gConifg);
        })
    }
    .height('100%')
    .width('100%')
  }
}