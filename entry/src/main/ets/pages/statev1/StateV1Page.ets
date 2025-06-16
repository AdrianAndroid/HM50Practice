import { UIUtils } from "@kit.ArkUI";

@Entry
@Component
struct StateV1Page {
  @State animal: Animals | undefined = new Animals("lion");

  build() {
    Column() {
      Text(`Parents' animals are  ${this.animal instanceof Animals ? this.animal.name : 'undefined'}`).fontSize(30)

      Child({animal: this.animal})

      Button('Parents change animals into dogs')
        .onClick(() => {
          // 判断animal的类型，做属性的更新
          if (this.animal instanceof Animals) {
            this.animal.name = "Dog";
          } else {
            console.info('num is undefined, cannot change property');
          }
        })

      Button('Parents change animal to undefined')
        .onClick(() => {
          // 赋值为undefined
          this.animal = undefined;
        })
    }
  }
}

class Animals {
  public name: string;

  constructor(name: string) {
    this.name = name;
  }
}

@Component
struct Child {
  @Prop animal: Animals | undefined;

  build() {
    Column() {
      Text(`Child's animal is  ${this.animal instanceof Animals ? this.animal.name : 'undefined'}`).fontSize(30)

      Button('Child change animals into tigers')
        .onClick(() => {
          // 赋值为Animals的实例
          this.animal = new Animals("Tiger");
        })

      Button('Child change animal to undefined')
        .onClick(() => {
          // 赋值为undefined
          this.animal = undefined;
        })

    }.width('100%')
  }
}