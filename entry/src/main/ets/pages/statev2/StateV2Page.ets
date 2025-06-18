@Entry
@ComponentV2
struct StateV2Page {
  info: Info = new Info("Tom", 25);
  build() {
    Column() {
      Blank().height(100)
      Button("Step1、Only change name")
        .onClick(() => {
          this.info.person = new Person("Jack", 25);  // 能够触发onNameChange方法，不触发onAgeChange方法
        })
      Button("Step2、Only change age")
        .onClick(() => {
          this.info.person = new Person("Jack", 18);  // 能够触发onAgeChange方法，不触发onNameChange方法
        })
      Button("Step3、Change name and age")
        .onClick(() => {
          this.info.person = new Person("Lucy", 19);  // 能够触发onNameChange、onAgeChange方法
        })
    }
  }
}

@ObservedV2
class Info {
  @Trace person: Person;
  @Monitor("person.name")
  onNameChange(monitor: IMonitor) {
    console.log(`name change from ${monitor.value()?.before} to ${monitor.value()?.now}`);
  }
  @Monitor("person.age")
  onAgeChange(monitor: IMonitor) {
    console.log(`age change from ${monitor.value()?.before} to ${monitor.value()?.now}`);
  }
  constructor(name: string, age: number) {
    this.person = new Person(name, age);
  }
}
@ObservedV2
class Person {
  @Trace name: string;
  @Trace age: number;
  constructor(name: string, age: number) {
    this.name = name;
    this.age = age;
  }
}