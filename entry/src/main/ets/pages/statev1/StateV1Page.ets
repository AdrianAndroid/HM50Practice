import { UIUtils } from "@kit.ArkUI";

@Entry
@Component
struct StateV1Page {
  @State person: Father = new Father('Hello', new Son('world'));

  build() {
    Column() {
      Blank()
        .height(100)
      Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center }) {
        Button('change Father name')
          .width(312)
          .height(40)
          .margin(12)
          .fontColor('#FFFFFF，90%')
          .onClick(() => {
            this.person.name = "Hi";
          })
        Button('change Son title')
          .width(312)
          .height(40)
          .margin(12)
          .fontColor('#FFFFFF，90%')
          .onClick(() => {
            this.person.son.title = "ArkUI";
          })
        Text(this.person.name)
          .fontSize(16)
          .margin(12)
          .width(312)
          .height(40)
          .backgroundColor('#ededed')
          .borderRadius(20)
          .textAlign(TextAlign.Center)
          .fontColor('#e6000000')
          .onClick(() => {
            this.person.name = 'Bye';
          })
        Text(this.person.son.title)
          .fontSize(16)
          .margin(12)
          .width(312)
          .height(40)
          .backgroundColor('#ededed')
          .borderRadius(20)
          .textAlign(TextAlign.Center)
          .onClick(() => {
            this.person.son.title = "openHarmony";
          })
        Child({ child: this.person.son })
      }

    }

  }
}


@Component
struct Child {
  @Prop child: Son = new Son('');

  build() {
    Column() {
      Text(this.child.title)
        .fontSize(16)
        .margin(12)
        .width(312)
        .height(40)
        .backgroundColor('#ededed')
        .borderRadius(20)
        .textAlign(TextAlign.Center)
        .onClick(() => {
          this.child.title = 'Bye Bye';
        })
    }
  }
}

// 以下是嵌套类对象的数据结构。
@Observed
class Son {
  public title: string;


  constructor(title: string) {
    this.title = title;
  }
}


@Observed
class Father {
  public name: string;
  public son: Son;


  constructor(name: string, son: Son) {
    this.name = name;
    this.son = son;
  }
}