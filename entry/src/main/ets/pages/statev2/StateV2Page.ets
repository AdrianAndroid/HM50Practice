@Entry
@ComponentV2
struct StateV2Page {
  @Local message: string = "Hello World";
  @Local name: string = "Tom";
  @Local age: number = 24;
  @Monitor("message", "name")
  onStrChange(monitor: IMonitor) {
    monitor.dirty.forEach((path: string) => {
      console.log(`${path} changed from ${monitor.value(path)?.before} to ${monitor.value(path)?.now}`)
    })
  }
  build() {
    Column() {
      Blank()
        .height(100)
      Button("change string")
        .onClick(() => {
          this.message += "!";
          this.name = "Jack";
        })
    }
  }
}