import { taskpool } from '@kit.ArkTS';
import { BusinessError } from '@kit.BasicServicesKit';

@Concurrent
async function test1(arg: TestA) {
  console.info("TestA name is: " + arg);
}

@Entry
@Component
struct ComNormalPage {
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
          // 1. 创建Test实例objA
          let objA = new TestA("TestA");
          // 2. 创建任务task，将objA传递给该任务，objA非sendable对象，通过序列化传递给子线程
          let task = new taskpool.Task(test1, objA);
          // 3. 执行任务
          taskpool.execute(task).then(() => {
            console.info("taskpool: execute task success!");
          }).catch((e: BusinessError) => {
            console.error(`taskpool: execute task: Code: ${e.code}, message: ${e.message}`);
          })
        })
    }
    .height('100%')
    .width('100%')
  }
}

class TestA {
  constructor(name: string) {
    this.name = name;
  }

  name: string = 'ClassA';
}