@Entry
@ComponentV2
struct StateV2Page {
  person: Person = new Person();

  build() {
    Column() {
      // age被@Trace装饰，用在UI中可以触发UI刷新
      Text(`${this.person.age}`)
        .fontSize(100)
        .onClick(() => {
          this.person.age++; // 点击会触发UI刷新
        })
      // id未被@Trace装饰，用在UI中不会触发UI刷新
      Text(`${this.person.id}`) // 当id变化时不会刷新
        .fontSize(100)
        .onClick(() => {
          this.person.id++; // 点击不会触发UI刷新
        })
    }
  }
}

@ObservedV2
class Person {
  id: number = 0;
  @Trace age: number = 8;
}