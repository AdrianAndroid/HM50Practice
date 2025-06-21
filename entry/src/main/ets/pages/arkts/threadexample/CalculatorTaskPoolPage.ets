import { Calculator } from './Calculator'
import { TimerSdk } from './CalculatorTimerSdk'
import { taskpool } from '@kit.ArkTS';

@Concurrent
function initCalculator(): Calculator {
  return Calculator.init()
}

@Concurrent
function initTimerSdk(): TimerSdk {
  return TimerSdk.init()
}

@Entry
@Component
struct CalculatorTaskPoolPage {
  calc?: Calculator
  timer?: TimerSdk

  aboutToAppear(): void {
    taskpool.execute(initCalculator).then((ret) => {
      this.calc = ret as Calculator
    })
    taskpool.execute(initTimerSdk).then((ret) => {
      this.timer = ret as TimerSdk
    })
  }

  build() {
    Row() {
      Column() {
        Text("calculate add")
          .id('add')
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .alignRules({
            center: { anchor: '__container__', align: VerticalAlign.Center },
            middle: { anchor: '__container__', align: HorizontalAlign.Center }
          })
          .onClick(async () => {
            let result = this.calc?.add(1, 2)
            console.info(`Result is ${result}`)
          })
        Text("show history")
          .id('show')
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .alignRules({
            center: { anchor: '__container__', align: VerticalAlign.Center },
            middle: { anchor: '__container__', align: HorizontalAlign.Center }
          })
          .onClick(async () => {
            this.calc?.showHistory()
          })
        Text("countdown")
          .id('get')
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .alignRules({
            center: { anchor: '__container__', align: VerticalAlign.Center },
            middle: { anchor: '__container__', align: HorizontalAlign.Center }
          })
          .onClick(async () => {
            console.info(`Timer start`)
            await this.timer?.Countdown(1000);
            console.info(`Timer end`)
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}