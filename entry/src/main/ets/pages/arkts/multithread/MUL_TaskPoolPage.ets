// Index.ets代码
import { taskpool} from '@kit.ArkTS';

// 步骤1: 定义并发函数，实现业务逻辑
@Concurrent
async function taskpoolFunc(num: number): Promise<number> {
  // 根据业务逻辑实现相应的功能
  let tmpNum: number = num + 100;
  return tmpNum;
}

async function mainFunc(): Promise<void> {
  // 步骤2: 创建任务并执行
  let task1: taskpool.Task = new taskpool.Task(taskpoolFunc, 1);
  let res1: number = await taskpool.execute(task1) as number;
  let task2: taskpool.Task = new taskpool.Task(taskpoolFunc, res1);
  let res2: number = await taskpool.execute(task2) as number;
  // 步骤3: 对任务返回的结果进行操作
  console.info("taskpool: task res1 is: " + res1);
  console.info("taskpool: task res2 is: " + res2);
}

@Entry
@Component
struct MUL_TaskPoolPage {
  @State message: string = 'Hello World';

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .onClick(async () => {
            mainFunc();
          })
      }
      .width('100%')
      .height('100%')
    }
  }
}