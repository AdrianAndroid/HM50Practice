import { UIUtils } from "@kit.ArkUI";

@Entry
@Component
struct StateV1Page {
  @State mainCounter: number = 10;

  build() {
    Column() {
      Row() {
        Column() {
          // customCounter必须从父组件初始化，因为MyComponent的customCounter成员变量缺少本地初始化；此处，customCounter2可以不做初始化。
          MyComponent({ customCounter: this.mainCounter })
          // customCounter2也可以从父组件初始化，父组件初始化的值会覆盖子组件customCounter2的本地初始化的值
          MyComponent({ customCounter: this.mainCounter, customCounter2: this.mainCounter })
        }
      }

      Row() {
        Column() {
          Button('Click to change number')
            .width(288)
            .height(40)
            .margin({ left: 30, top: 12 })
            .fontColor('#FFFFFF，90%')
            .onClick(() => {
              this.mainCounter++;
            })
        }
      }
    }
  }
}

@Component
struct MyComponent {
  @Prop customCounter: number;
  @Prop customCounter2: number = 5;

  build() {
    Column() {
      Row() {
        Text(`From Main: ${this.customCounter}`).fontColor('#ff6b6565').margin({ left: -110, top: 12 })
      }

      Row() {
        Button('Click to change locally !')
          .width(288)
          .height(40)
          .margin({ left: 30, top: 12 })
          .fontColor('#FFFFFF，90%')
          .onClick(() => {
            this.customCounter2++;
          })
      }

      Row() {
        Text(`Custom Local: ${this.customCounter2}`).fontColor('#ff6b6565').margin({ left: -110, top: 12 })
      }
    }
  }
}