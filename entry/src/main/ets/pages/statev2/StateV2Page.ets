import Constants from '../../common/Constants';

@Entry
@ComponentV2
struct StateV2Page {
  @Local rawObject: RawObject = new RawObject("rawObject");
  @Local observedObject: ObservedObject = new ObservedObject("observedObject");
  build() {
    Column() {
      Blank()
        .height(100)
      Text(`${this.rawObject.name}`)
      Text(`${this.observedObject.name}`)
      Button("change object")
        .onClick(() => {
          // 对类对象整体的修改均能观察到
          this.rawObject = new RawObject("new rawObject");
          this.observedObject = new ObservedObject("new observedObject");
        })
      Button("change name")
        .onClick(() => {
          // @Local与@Param均不具备观察类对象属性的能力，因此对rawObject.name的修改无法观察到
          this.rawObject.name = "new rawObject name";
          // 由于ObservedObject的name属性被@Trace装饰，因此对observedObject.name的修改能被观察到
          this.observedObject.name = "new observedObject name";
        })
      Child({
        rawObject: this.rawObject,
        observedObject: this.observedObject
      })
    }
  }
}

@ComponentV2
struct Child {
  @Require @Param rawObject: RawObject;
  @Require @Param observedObject: ObservedObject;
  build() {
    Column() {
      Text(`${this.rawObject.name}`)
      Text(`${this.observedObject.name}`)
    }
  }

}

class RawObject {
  name: string;
  constructor(name: string) {
    this.name = name;
  }
}
@ObservedV2
class ObservedObject {
  @Trace name: string;
  constructor(name: string) {
    this.name = name;
  }
}