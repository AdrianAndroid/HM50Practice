import { UIUtils } from "@kit.ArkUI";

@Entry
@Component
struct StateV1Page {
  @State name: string | undefined = "mary";

  build() {
    Column() {
      Text(`The name is  ${this.name}`).fontSize(30)

      Child({ name: this.name })

      Button('Parents change name to Peter')
        .onClick(() => {
          this.name = "Peter";
        })

      Button('Parents change name to undefined')
        .onClick(() => {
          this.name = undefined;
        })
    }
  }
}

@Component
struct Child {
  @Link name: string | undefined;

  build() {
    Column() {

      Button('Child change name to Bob')
        .onClick(() => {
          this.name = "Bob";
        })

      Button('Child change name to undefined')
        .onClick(() => {
          this.name = undefined;
        })

    }.width('100%')
  }
}

