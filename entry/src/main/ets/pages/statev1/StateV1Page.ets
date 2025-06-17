import { UIUtils } from "@kit.ArkUI";

@Entry
@Component
struct StateV1Page {
  @State arr: Array<ObservedArray<string>> = [new ObservedArray<string>('apple'), new ObservedArray<string>('banana'), new ObservedArray<string>('orange')];

  build() {
    Column() {
      Blank()
        .height(50)
      ForEach(this.arr, (itemArr: ObservedArray<string>) => {
        Item({ itemArr: itemArr })
      })

      Divider()

      Button('push two-dimensional array item')
        .margin(10)
        .onClick(() => {
          this.arr[0].push('strawberry');
        })

      Button('push array item')
        .margin(10)
        .onClick(() => {
          this.arr.push(new ObservedArray<string>('pear'));
        })

      Button('change two-dimensional array first item')
        .margin(10)
        .onClick(() => {
          this.arr[0][0] = 'APPLE';
        })

      Button('change array first item')
        .margin(10)
        .onClick(() => {
          this.arr[0] = new ObservedArray<string>('watermelon');
        })
    }
  }
}

@Observed
class ObservedArray<T> extends Array<T> {
}

@Component
struct Item {
  @ObjectLink itemArr: ObservedArray<string>;

  build() {
    Row() {
      ForEach(this.itemArr, (item: string, index: number) => {
        Text(`${index}: ${item}`)
          .width(100)
      }, (item: string) => item)
    }
  }
}