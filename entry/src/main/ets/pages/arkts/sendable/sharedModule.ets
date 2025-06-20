// 共享模块sharedModule.ets
import { ArkTSUtils } from '@kit.ArkTS';

// 声明当前模块为共享模块，只能导出可Sendable数据
"use shared"

// 共享模块，SingletonA全局唯一
@Sendable
class SingletonA {
  private count_: number = 0;
  lock_: ArkTSUtils.locks.AsyncLock = new ArkTSUtils.locks.AsyncLock()

  public async getCount(): Promise<number> {
    return this.lock_.lockAsync(() => {
      return this.count_;
    })
  }

  public async increaseCount() {
    await this.lock_.lockAsync(() => {
      this.count_++;
    })
  }
}

class SingeB {}

export let singletonA = new SingletonA();