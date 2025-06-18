@Entry
@ComponentV2
struct StateV2Page {
  build() {
    Column() {
      // 当点击改变count时，Text组件会刷新
      Blank()
        .height(200)
      Text(`${Manager.count}`)
        .fontSize(100)
        .onClick(() => {
          Manager.count++;
        })
    }
  }
}
@ObservedV2
class Manager {
  @Trace static count: number = 1;
}