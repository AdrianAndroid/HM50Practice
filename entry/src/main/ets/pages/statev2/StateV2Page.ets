import { taskpool } from '@kit.ArkTS';
import { UIUtils } from '@kit.ArkUI';
import Logger from '../../common/Logger';
import { SendableData } from './SendableData';

@Sendable
export class SendableData2  {
  name: string = 'Tom';
  age: number = 20;
  gender: number = 1;
  // ....更多其他属性
  likes: number = 1;
  follow: boolean = false;
}

@Concurrent
function threadGetData(param: string): SendableData {
  Logger.debug('StateV2Page', `threadGetData => ${param}`)
  // 在子线程处理数据
  let ret = new SendableData();
  console.info(`Concurrent threadGetData, param ${param}`);
  ret.name = param + "-o";
  ret.age = Math.floor(Math.random() * 40);
  ret.likes = Math.floor(Math.random() * 100);
  return ret;
}

@Entry
@ComponentV2
struct StateV2Page {
  @Local send: SendableData = UIUtils.makeObserved(new SendableData());
  build() {
    Column() {
      Blank().height(100)
      Text(this.send.name)
      Button("change name").onClick(() => {
        // ok 可以观察到属性的改变
        this.send.name += "0";
      })

      Button("task").onClick(() => {
        // 将待执行的函数放入taskpool内部任务队列等待，等待分发到工作线程执行。
        taskpool.execute(threadGetData, this.send.name).then(val => {
          Logger.debug('StateV2Page', `then`)
          // 和@Local一起使用，可以观察this.send的变化
          this.send = UIUtils.makeObserved(val as SendableData);
        })
      })
    }
  }
}