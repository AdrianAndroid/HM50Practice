@Entry
@ComponentV2
struct StateV2Page {
  outer: Outer = new Outer();
  build() {
    Column() {
      Button("change name")
        .onClick(() => {
          this.outer.inner.num = 100; // 能够触发onChange方法
        })
    }
  }
}

@ObservedV2
class Inner {
  @Trace num: number = 0;
}
@ObservedV2
class Outer {
  inner: Inner = new Inner();
  @Monitor("inner.num")
  onChange(monitor: IMonitor) {
    console.log(`inner.num change from ${monitor.value()?.before} to ${monitor.value()?.now}`);
  }
}