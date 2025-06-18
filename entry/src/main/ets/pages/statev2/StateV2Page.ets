@Entry
@ComponentV2
struct StateV2Page {
  @Local info: Info = new Info();
  @Local flag: boolean = false;
  @Monitor("info.message")
  onMessageChange(monitor: IMonitor) {
    console.log(`Index message change from ${monitor.value()?.before} to ${monitor.value()?.now}`);
  }

  build() {
    Column() {
      Button("show/hide Child")
        .onClick(() => {
          this.flag = !this.flag
        })
      Button("change message in Index")
        .onClick(() => {
          this.info.message = "Index click to change Message";
        })
      if (this.flag) {
        Child({ info: this.info })
      }
    }
  }
}


@ObservedV2
class Info {
  @Trace message: string = "not initialized";

  constructor() {
    console.log("in constructor message change to initialized");
    this.message = "initialized";
  }
}
@ComponentV2
struct Child {
  @Param info: Info = new Info();
  @Monitor("info.message")
  onMessageChange(monitor: IMonitor) {
    console.log(`Child message change from ${monitor.value()?.before} to ${monitor.value()?.now}`);
  }
  aboutToAppear(): void {
    this.info.message = "Child aboutToAppear";
  }
  aboutToDisappear(): void {
    console.log("Child aboutToDisappear");
    this.info.message = "Child aboutToDisappear";
  }
  build() {
    Column() {
      Text("Child")
      Button("change message in Child")
        .onClick(() => {
          this.info.message = "Child click to change Message";
        })
    }
    .borderColor(Color.Red)
    .borderWidth(2)

  }
}