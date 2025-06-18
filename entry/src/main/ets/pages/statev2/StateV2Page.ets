@Entry
@ComponentV2
struct StateV2Page {
  @Local info: Info = new Info("Tom", 25);

  @Monitor("info")
  infoChange(monitor: IMonitor) {
    console.log(`info change changed from`);
    monitor.dirty.forEach((path: string) => {
      console.log(`${path} changed from ${monitor.value(path)?.before} to ${monitor.value(path)?.now}`)
    })
  }

  @Monitor("info.name")
  infoPropertyChange(monitor: IMonitor) {
    console.log(`info name change  changed from`);
    monitor.dirty.forEach((path: string) => {
      console.log(`${path} changed from ${monitor.value(path)?.before} to ${monitor.value(path)?.now}`)
    })
  }
  build() {
    Column() {
      Blank()
        .height(100)
      Text(`name: ${this.info.name}, age: ${this.info.age}`)
      Button("change info")
        .onClick(() => {
          this.info = new Info("Lucy", 18); // 能够监听到
        })
      Button("change info.name")
        .onClick(() => {
          this.info.name = "Jack"; // 监听不到
        })
    }
  }
}

class Info {
  name: string;
  age: number;
  constructor(name: string, age: number) {
    this.name = name;
    this.age = age;
  }
}