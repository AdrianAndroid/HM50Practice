import { hilog } from '@kit.PerformanceAnalysisKit';
import testNapi from 'libentry.so';
import { SendableObjTest } from './SendableObjTest'

@Entry
@Component
struct SendableObjTestPage {
  @State message: string = 'Hello ';

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            SendableObjTest.newSendable()
            hilog.info(0x0000, 'testTag', 'Test send Sendable begin');
            testNapi.testSendSendable();
            hilog.info(0x0000, 'testTag', 'Test send Sendable end');
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}

@ComponentV2
struct Dddee {
  build() {
    Column()

  }
}