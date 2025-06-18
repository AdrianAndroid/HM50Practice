@Entry
@ComponentV2
struct StateV2Page {
  son: Son = new Son(0);
  cousin: Cousin = new Cousin(0);
  renderTimes: number = 0;

  isRender(id: number): number {
    console.info(`id: ${id} renderTimes: ${this.renderTimes}`);
    this.renderTimes++;
    return 40;
  }

  build() {
    Row() {
      Column() {
        Blank()
          .height(100)
        Text(`Son ${this.son.age}`)
          .fontSize(this.isRender(1))
          .fontWeight(FontWeight.Bold)
        Text(`Cousin ${this.cousin.age}`)
          .fontSize(this.isRender(2))
          .fontWeight(FontWeight.Bold)
        Button('change Son age')
          .onClick(() => {
            this.son.age++;
          })
        Button('change Cousin age')
          .onClick(() => {
            this.cousin.age++;
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}

@ObservedV2
class GrandFather {
  @Trace age: number = 0;

  constructor(age: number) {
    this.age = age;
  }
}
class Father extends GrandFather{
  constructor(father: number) {
    super(father);
  }
}
class Uncle extends GrandFather {
  constructor(uncle: number) {
    super(uncle);
  }
}
class Son extends Father {
  constructor(son: number) {
    super(son);
  }
}
class Cousin extends Uncle {
  constructor(cousin: number) {
    super(cousin);
  }
}