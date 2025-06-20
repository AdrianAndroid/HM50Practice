import { BusinessError } from '@kit.BasicServicesKit';

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
    Column() {
      Blank().height(100)
      Text(this.message)
        .id('PromisAsyncAwaitPageHelloWorld')
        .fontSize($r('app.float.page_text_font_size'))
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(() => {
          this.testPromise()
        })
      Text(this.message)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .onClick(async () => {
          let res = await this.testAsyncAwait();
          console.info("res is: " + res);
        })
    }
    .height('100%')
    .width('100%')
  }
}