@Entry
@ComponentV2
struct StateV2Page {
  father: Father = new Father();

  build() {
    Column() {
      // 当点击改变age时，Text组件会刷新
      Blank()
        .height(200)
      Text(`${this.father.son.age}`)
        .onClick(() => {
          this.father.son.age++;
        })
    }
  }
}
@ObservedV2
class Son {
  @Trace age: number = 100;
}
class Father {
  son: Son = new Son();
}