import Constants from '../../common/Constants';

@Entry({ storage: LocalStorage.getShared() })
@Component
struct StateV1Page {
  // 可以使用@LocalStorageLink/Prop与LocalStorage实例中的变量建立联系
  @LocalStorageLink('PropA') propA: number = 1;
  pageStack: NavPathStack = new NavPathStack()

  build() {
    Navigation(this.pageStack) {
      Row() {
        Column() {
          Text(`${this.propA}`)
            .fontSize(50)
            .fontWeight(FontWeight.Bold)
          Button("To Page")
            .onClick(() => {
              this.pageStack.pushPathByName('StateV1Page2', null)
            })
        }
        .width(Constants.FULL_PERCENT)
      }.height(Constants.FULL_PERCENT)
    }
  }
}