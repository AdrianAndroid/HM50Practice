@Entry
@ComponentV2
struct StateV2Page {
  info: Info = new Info();

  aboutToAppear(): void {
    this.info.message = "Index aboutToAppear";
  }

  build() {
    Column() {
      Button("change message")
        .onClick(() => {
          this.info.message = "Index click to change message";
        })
    }
  }
}


@ObservedV2
class Info {
  @Trace message: string = "not initialized";

  constructor() {
    this.message = "initialized";
  }
  @Monitor("message")
  onMessageChange(monitor: IMonitor) {
    console.log(`message change from ${monitor.value()?.before} to ${monitor.value()?.now}`);
  }
}
