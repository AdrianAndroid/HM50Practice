@Entry
@ComponentV2
struct StateV2Page {
  son: Son = new Son();
  renderTimes: number = 0;
  isRender(id: number): number {
    console.info(`id: ${id} renderTimes: ${this.renderTimes}`);
    this.renderTimes++;
    return 40;
  }

  build() {
    Column() {
      Blank()
        .height(100)
      Text('pencil length'+ this.son.bag.pencil.length)
        .fontSize(this.isRender(1))   // UINode (1)
      Button("change length")
        .onClick(() => {
          // 点击更改length值，UINode（1）会刷新
          this.son.bag.pencil.length += 100;
        })
      Button("assign Son")
        .onClick(() => {
          // 由于变量son非状态变量，因此无法刷新UINode（1）
          this.son = new Son();
        })
    }
  }
}

@ObservedV2
class Pencil {
  @Trace length: number = 21; // 当length变化时，会刷新关联的组件
}
class Bag {
  width: number = 50;
  height: number = 60;
  pencil: Pencil = new Pencil();
}
class Son {
  age: number = 5;
  school: string = "some";
  bag: Bag = new Bag();
}