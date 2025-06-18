@Entry
@ComponentV2
struct StateV2Page {
  info: Info = new Info();
  build() {
    Column() {
      Button("change name")
        .onClick(() => {
          this.info.name = "Jack"; // 能够触发onNameChange方法
        })
      Button("change age")
        .onClick(() => {
          this.info.age = 26; // 不能够触发onAgeChange方法
        })
      Button("change region")
        .onClick(() => {
          this.info.region = "South"; // 能够触发onChange方法
        })
      Button("change job")
        .onClick(() => {
          this.info.job = "Driver"; // 能够触发onChange方法
        })
    }
  }
}

@ObservedV2
class Info {
  @Trace name: string = "Tom";
  @Trace region: string = "North";
  @Trace job: string = "Teacher";
  age: number = 25;
  // name被@Trace装饰，能够监听变化
  @Monitor("name")
  onNameChange(monitor: IMonitor) {
    console.log(`name change from ${monitor.value()?.before} to ${monitor.value()?.now}`);
  }
  // age未被@Trace装饰，不能监听变化
  @Monitor("age")
  onAgeChange(monitor: IMonitor) {
    console.log(`age change from ${monitor.value()?.before} to ${monitor.value()?.now}`);
  }
  // region与job均被@Trace装饰，能够监听变化
  @Monitor("region", "job")
  onChange(monitor: IMonitor) {
    monitor.dirty.forEach((path: string) => {
      console.log(`${path} change from ${monitor.value(path)?.before} to ${monitor.value(path)?.now}`);
    })
  }
}