@Entry
@ComponentV2
struct StateV2Page {
  frequence: Frequence = new Frequence();
  build() {
    Column() {
      Blank()
        .height(100)
      Button("change count to 1000")
        .onClick(() => {
          for (let i = 1; i <= 1000; i++) {
            this.frequence.count = i;
          }
        })
      Button("change count to 0 then to 1000")
        .onClick(() => {
          for (let i = 999; i >= 0; i--) {
            this.frequence.count = i;
          }
          this.frequence.count = 1000; // 最终不触发onCountChange方法
        })
    }
  }
}

@ObservedV2
class Frequence {
  @Trace count: number = 0;
  @Monitor("count")
  onCountChange(monitor: IMonitor) {
    console.log(`count change from ${monitor.value()?.before} to ${monitor.value()?.now}`);
  }
}