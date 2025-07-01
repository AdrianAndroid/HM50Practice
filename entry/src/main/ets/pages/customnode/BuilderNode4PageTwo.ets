// ets/pages/PageTwo.ets
// 该页面中存在一个按钮，可跳转回主页面，回到主页面后，原有的文字消失
// import "ets/pages/Index"

@Entry({ routeName: "pageTwo" })
@Component
struct BuilderNode4PageTwo {
  build() {
    Column() {
      Button('Router replace to index')
        .onClick(() => {
          this.getUIContext().getRouter().replaceNamedRoute({ name: "myIndex" });
        })
    }
    .height('100%')
    .width('100%')
    .alignItems(HorizontalAlign.Center)
    .padding(16)
  }
}

// @Entry
// @Component
// struct BuilderNode4PageTwo {
//   @State message: string = 'Hello World';
//
//   build() {
//     RelativeContainer() {
//       Text(this.message)
//         .id('BuilderNode4PageTwoHelloWorld')
//         .fontSize($r('app.float.page_text_font_size'))
//         .fontWeight(FontWeight.Bold)
//         .alignRules({
//           center: { anchor: '__container__', align: VerticalAlign.Center },
//           middle: { anchor: '__container__', align: HorizontalAlign.Center }
//         })
//         .onClick(() => {
//           this.message = 'Welcome';
//         })
//     }
//     .height('100%')
//     .width('100%')
//   }
// }
//
