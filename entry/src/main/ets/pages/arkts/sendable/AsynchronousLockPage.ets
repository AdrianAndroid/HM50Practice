import { ArkTSUtils, taskpool } from '@kit.ArkTS';

@Sendable
export class A {
  private count_: number = 0;
  lock_: ArkTSUtils.locks.AsyncLock = new ArkTSUtils.locks.AsyncLock();

  public async getCount(): Promise<number> {
    // 对需要保护的数据加异步锁
    return this.lock_.lockAsync(() => {
      return this.count_;
    })
  }

  public async increaseCount() {
    // 对需要保护的数据加异步锁
    await this.lock_.lockAsync(() => {
      this.count_++;
    })
  }
}

@Concurrent
async function printCount(a: A) {
  console.info("InputModule: count is:" + await a.getCount());
}


@Entry
@Component
struct AsynchronousLockPage {
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
        .onClick(async () => {
          // 创建sendable对象a
          let a: A = new A();
          // 将实例a传递给子线程
          await taskpool.execute(printCount, a);
        })
    }
    .height('100%')
    .width('100%')
  }
}