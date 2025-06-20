// Index.ets
import { taskpool, ArkTSUtils } from '@kit.ArkTS';
import { SendableTestClass, ISendable } from './sendable2';

// 在并发函数中模拟数据处理
@Concurrent
async function taskFunc(sendableObj: SendableTestClass) {
  console.info("SendableTestClass: name is: " + sendableObj.printName() + ", age is: " + sendableObj.printAge() + ", sex is: " + sendableObj.printSex());
  sendableObj.setAge(28);
  console.info("SendableTestClass: age is: " + sendableObj.printAge());

  // 解析sendableObj.arr数据生成JSON字符串
  let str = ArkTSUtils.ASON.stringify(sendableObj.arr);
  console.info("SendableTestClass: str is: " + str);

  // 解析该数据并生成ISendable数据
  let jsonStr = '{"name": "Alexa", "age": 23, "sex": "female"}';
  let obj = ArkTSUtils.ASON.parse(jsonStr) as ISendable;
  console.info("SendableTestClass: type is: " + typeof obj);
  console.info("SendableTestClass: name is: " + (obj as object)?.["name"]); // 输出: 'Alexa'
  console.info("SendableTestClass: age is: " + (obj as object)?.["age"]); // 输出: 23
  console.info("SendableTestClass: sex is: " + (obj as object)?.["sex"]); // 输出: 'female'
}
async function test() {
  // 使用taskpool传递数据
  let obj: SendableTestClass = new SendableTestClass();
  let task: taskpool.Task = new taskpool.Task(taskFunc, obj);
  await taskpool.execute(task);
}

@Entry
@Component
struct SendableClassPage {
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
          test();
        })
    }
    .height('100%')
    .width('100%')
  }
}