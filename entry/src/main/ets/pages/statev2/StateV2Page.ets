@Entry
@ComponentV2
struct StateV2Page {
  derived: Derived = new Derived("AAA");
  build() {
    Column() {
      Blank()
        .height(100)
      Button("change name")
        .onClick(() => {
          this.derived.name = "BBB"; // 能够先后触发onBaseNameChange、onDerivedNameChange方法
        })
    }
  }
}

@ObservedV2
class Base {
  @Trace name: string;
  // 基类监听name属性
  @Monitor("name")
  onBaseNameChange(monitor: IMonitor) {
    console.log(`Base Class name change`);
  }
  constructor(name: string) {
    this.name = name;
  }
}
@ObservedV2
class Derived extends Base {
  // 继承类监听name属性
  @Monitor("name")
  onDerivedNameChange(monitor: IMonitor) {
    console.log(`Derived Class name change`);
  }
  constructor(name: string) {
    super(name);
  }
}
