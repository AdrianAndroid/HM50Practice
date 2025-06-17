import { UIUtils } from "@kit.ArkUI";

@Entry
@Component
struct StateV1Page {
  @Provide message: Set<number> = new Set([0, 1, 2, 3, 4])

  build() {
    Row() {
      Column() {
        Button('Provide init set').onClick(() => {
          this.message = new Set([0, 1, 2, 3, 4, 5])
        })
        Child()
      }
      .width('100%')
    }
    .height('100%')
  }
}


@Component
struct Child {
  @Consume message: Set<number>

  build() {
    Column() {
      ForEach(Array.from(this.message.entries()), (item: [number, string]) => {
        Text(`${item[0]}`).fontSize(30)
        Divider()
      })
      Button('Consume init set').onClick(() => {
        this.message = new Set([0, 1, 2, 3, 4])
      })
      Button('Consume set new one').onClick(() => {
        this.message.add(5)
      })
      Button('Consume clear').onClick(() => {
        this.message.clear()
      })
      Button('Consume delete the first one').onClick(() => {
        this.message.delete(0)
      })
    }
    .width('100%')
  }
}