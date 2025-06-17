import Constants from "../../common/Constants";

@Component
struct StateV1Page2 {
  @LocalStorageLink('PropA') propA: number = 2;
  pathStack: NavPathStack | undefined

  build() {
    NavDestination() {
      Row() {
        Text(`${this.propA}`)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)

        Button('Change propA')
          .onClick(() => {
            this.propA = 100
          })

        Button('Back Index')
          .onClick(() => {
            this.pathStack?.pop()
          })
      }
      .width(Constants.FULL_PERCENT)
    }
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
  }
}

@Builder
export function PageBuilder() {
  StateV1Page2()
}