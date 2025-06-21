// sdk/TimerSdk.ets
@Sendable
export class TimerSdk {
  static init(): TimerSdk {
    let timer = new TimerSdk()
    return timer
  }


  async Countdown(time: number) {
    return new Promise((resolve: (value: boolean) => void) => {
      setTimeout(() => {
        resolve(true)
      }, time)
    })
  }
}