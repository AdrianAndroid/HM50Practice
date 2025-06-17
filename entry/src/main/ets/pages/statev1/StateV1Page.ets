import { UIUtils } from "@kit.ArkUI";

@Entry
@Component
struct StateV1Page {
  @State dog: Dog = new Dog('Molly', 2, 'Husky');

  @Styles
  pressedStyles() {
    .backgroundColor('#ffd5d5d5')
  }

  @Styles
  normalStyles() {
    .backgroundColor('#ffffff')
  }

  build() {
    Column() {
      Blank()
        .height(100)
      Text(`${this.dog.name}`)
        .width(320)
        .margin(10)
        .fontSize(30)
        .textAlign(TextAlign.Center)
        .stateStyles({
          pressed: this.pressedStyles,
          normal: this.normalStyles
        })
        .onClick(() => {
          this.dog.name = 'DouDou';
        })

      Text(`${this.dog.age}`)
        .width(320)
        .margin(10)
        .fontSize(30)
        .textAlign(TextAlign.Center)
        .stateStyles({
          pressed: this.pressedStyles,
          normal: this.normalStyles
        })
        .onClick(() => {
          this.dog.age = 3;
        })

      Text(`${this.dog.kinds}`)
        .width(320)
        .margin(10)
        .fontSize(30)
        .textAlign(TextAlign.Center)
        .stateStyles({
          pressed: this.pressedStyles,
          normal: this.normalStyles
        })
        .onClick(() => {
          this.dog.kinds = 'Samoyed';
        })
    }
  }
}

@Observed
class Animal {
  name: string;
  age: number;

  constructor(name: string, age: number) {
    this.name = name;
    this.age = age;
  }
}

@Observed
class Dog extends Animal {
  kinds: string;

  constructor(name: string, age: number, kinds: string) {
    super(name, age);
    this.kinds = kinds;
  }
}