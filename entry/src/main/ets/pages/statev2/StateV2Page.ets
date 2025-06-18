@Entry
@ComponentV2
struct StateV2Page {
  son: Son = new Son();

  build() {
    Column() {
      // 当点击改变name时，Text组件会刷新
      Blank()
        .height(200)
      Text(`${this.son.name}`)
        .onClick(() => {
          this.son.name = "Jack";
        })
    }
  }
}
@ObservedV2
class Father {
  @Trace name: string = "Tom";
}
class Son extends Father {
}