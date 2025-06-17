@Entry()
@Component
struct StateV1Page {
  @State @Watch("onMessageUpdated") message: number = 0;
  private data: number[] = [0, 1]

  onMessageUpdated() {
    console.info(`TabContent message callback func ${this.message}`)
  }

  build() {
    Row() {
      Column() {
        Blank().height(100)
        Button('change message').onClick(() => {
          this.message++
        })

        Tabs() {
          ForEach(this.data, (item: number) => {
            TabContent() {
              FreezeChild({ message: this.message, index: item })
            }.tabBar(`tab${item}`)
          }, (item: number) => item.toString())
        }
      }
      .width('100%')
    }
    .height('100%')
  }
}

@Component({ freezeWhenInactive: true })
struct FreezeChild {
  @Link @Watch("onMessageUpdated") message: number
  private index: number = 0

  onMessageUpdated() {
    console.info(`FreezeChild message callback func ${this.message}, index: ${this.index}`)
  }

  build() {
    Text("message" + `${this.message}, index: ${this.index}`)
      .fontSize(50)
      .fontWeight(FontWeight.Bold)
  }
}