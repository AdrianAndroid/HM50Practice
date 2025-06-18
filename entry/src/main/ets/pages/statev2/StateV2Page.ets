@Entry
@Component
struct StateV2Page {
  @State father: Father = new Father("John", 8);

  build() {
    Column() {
      Child({son: this.father.son})
    }
  }
}
@Component
struct Child {
  @ObjectLink son: Son;

  build() {
    Row() {
      Column() {
        Text(`name: ${this.son.name} age: ${this.son.age}`)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            this.son.age++;
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}
@Observed
class Father {
  son: Son;

  constructor(name: string, age: number) {
    this.son = new Son(name, age);
  }
}
@Observed
class Son {
  name: string;
  age: number;

  constructor(name: string, age: number) {
    this.name = name;
    this.age = age;
  }
}