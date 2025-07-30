import { BusinessError } from '@kit.BasicServicesKit';

/**
 * https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/async-concurrency-overview
 */
@Entry
@Component
struct PromiseAsyncAwaitPage {
  @State message: string = 'Hello World';

  testPromise() {
    const promise: Promise<number> = new Promise((resolve: Function, reject: Function) => {
      setTimeout(() => {
        const  randomNumber: Number = Math.random()
        if (randomNumber > 0.5) {
          resolve(randomNumber)
        } else {
          reject(new Error('Random number is too small'))
        }
      }, 1000)
    })
    promise.then((result: number) => {
      console.info(`Random number is ${result}`)
    }).catch((err: BusinessError) => {
      console.error(err.message)
    })

    // 使用 then 方法定义成功和失败的回调
    promise.then((result: number) => {
      console.info(`The number for success is ${result}`); // 成功时执行
    }, (error: BusinessError) => {
      console.error(error.message); // 失败时执行
    }
    );

    // 使用 then 方法定义成功的回调，catch 方法定义失败的回调
    promise.then((result: number) => {
      console.info(`Random number is ${result}`); // 成功时执行
    }).catch((error: BusinessError) => {
      console.error(error.message); // 失败时执行
    });

    promise.catch((error: BusinessError) => {
      console.error('--> '+error.message); // 失败时执行
    })
  }

  async testAsyncAwait(): Promise<string> {
    try {
      const result: string = await new Promise((result: Function) => {
        setTimeout(() => {
          result('Hello, World!')
        }, 300)
      })
      console.info(result); // 输出： Hello, world!
      return result
    } catch (e) {
      console.error(`Get exception: ${e}`)
    }
    return ''
  }

  build() {
    Column({space: 20}) {
      Button('testPromise')
        .onClick(async () => {
          this.testPromise();
        })
      Button('testAsyncAwait')
        .onClick(async () => {
          let res = await this.testAsyncAwait();
          console.info("res is: " + res);
        })
    }
    .height('100%')
    .width('100%')
  }
}