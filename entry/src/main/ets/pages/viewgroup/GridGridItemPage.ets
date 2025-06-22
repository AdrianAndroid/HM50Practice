import Constants from '../../common/Constants';

class GridDataSource implements IDataSource {
  totalCount(): number {
    return 100;
  }

  getData(index: number): string {
    return 'g' + index
  }

  registerDataChangeListener(listener: DataChangeListener): void {
  }

  unregisterDataChangeListener(listener: DataChangeListener): void {
  }
}

@Entry
@Component
struct GridGridItemPage {
  @State message: string = 'Hello World';
  @State services: Array<string> =
    ['会议', '投票', '签到', '打印', '投票', '签到', '打印', '投票', '签到', '打印', '投票', '签到', '打印', '投票',
      '签到', '打印', '投票', '签到', '打印', '投票', '签到', '打印', '投票', '签到', '打印', '投票', '签到', '打印',
      '签到', '打印', '投票', '签到', '打印', '投票', '签到', '打印', '投票', '签到', '打印', '投票', '签到', '打印']
  layoutOptions: GridLayoutOptions = {
    regularSize: [1, 1],
    onGetRectByIndex: (index: number) => {
      // if (index == key1) { // key1是“0”按键对应的index
      //   return [6, 0, 1, 2];
      // } else if (index == key2) { // key2是“=”按键对应的index
      //   return [5, 3, 2, 1];
      // }
      // ...
      // 这里需要根据具体布局返回其他item的位置
      return [6, 0, 1, 2]
    }
  }
  private scroller: Scroller = new Scroller()
  private dataSource = new GridDataSource()

  build() {
    Stack() {
      this.example9()
    }
    .height('100%')
    .width('100%')
  }

  @Builder
  example9() {
    Grid() {
      LazyForEach(this.dataSource, (str: string) => {
        GridItem() {
          Text(str)
            .width(Constants.FULL_PERCENT)
            .height('25%')
            .textAlign(TextAlign.Center)
            .backgroundColor(Color.Green)
        }
      })
    }
    .width(Constants.FULL_PERCENT)
    .height(Constants.FULL_PERCENT)
    //.rowsTemplate('1fr 1fr 1fr 1fr')
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .rowsGap(20)
    .columnsGap(20)
    .cachedCount(3)
  }

  @Builder
  example8() {
    Column({ space: 5 }) {
      Grid(this.scroller) {
        ForEach(this.services, (service: string, index) => {
          GridItem() {
            Text(service + index)
              .width(Constants.FULL_PERCENT)
              .height('25%')
              .textAlign(TextAlign.Center)
              .backgroundColor(Color.Green)
          }
          .width('80%')
        }, (service: string): string => service)
      }
      .columnsTemplate('1fr 1fr 1fr 1fr')
      .rowsGap(15)
      .columnsGap(15)
      .height('80%')

      Row({ space: 20 }) {
        Button('上一页')
          .onClick(() => {
            this.scroller.scrollPage({
              next: false,
              animation: true
            })
          })

        Button('下一页')
          .onClick(() => {
            this.scroller.scrollPage({
              next: true,
              animation: true
            })
          })
      }
    }
  }

  // 构建可滚动的网格布局
  @Builder
  example7() {
    Column({ space: 5 }) {
      Grid() {
        ForEach(this.services, (service: string, index) => {
          GridItem() {
            Text(service)
              .width(Constants.FULL_PERCENT)
              .height(Constants.FULL_PERCENT)
              .textAlign(TextAlign.Center)
              .backgroundColor(Color.Green)
          }
          .width('25%')
        }, (service: string): string => service)
      }
      .rowsTemplate('1fr 2fr') // 只设置rowsTemplate属性，当内容超出Grid区域时，可水平滚动。
      .rowsGap(15)
      .columnsGap(15)
    }
  }

  @Builder
  example6() {
    Column() {
      Grid() {
        ForEach(this.services, (service: string) => {
          GridItem() {
            Text(service)
              .width(Constants.FULL_PERCENT)
              .height(Constants.FULL_PERCENT)
              .textAlign(TextAlign.Center)
              .backgroundColor(Color.Green)
          }
        }, (service: string): string => service)
      }
      .rowsTemplate(('1fr 1fr') as string)
      .columnsTemplate(('1fr 1fr') as string)
      .columnsGap(10)
      .rowsGap(15)
    }
  }

  @Builder
  example5() {
    Column() {
      Grid() {
        ForEach(this.services, (service: string) => {
          GridItem() {
            Text(service)
              .width(50)
              .height(50)
              .textAlign(TextAlign.Center)
              .backgroundColor(Color.Green)
          }
        }, (service: string): string => service)
      }
      .rowsTemplate(('1fr 1fr') as string)
      .columnsTemplate(('1fr 1fr') as string)
    }
  }

  @Builder
  example4() {
    Grid() {
      GridItem() {
        Text('会议').backgroundColor(Color.Gray)
      }

      GridItem() {
        Text('签到')
      }

      GridItem() {
        Text('投票')
      }

      GridItem() {
        Text('打印')
      }
    }
    .rowsTemplate('1fr 1fr 1fr')
    .columnsTemplate('1fr 1fr 1fr')
  }

  @Builder
  example3() {
    Grid() {
      // ...
    }
    .maxCount(3)
    .layoutDirection(GridDirection.Row)
  }

  @Builder
  example2() {
    Grid(undefined, this.layoutOptions) {
      // ...
    }
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .rowsTemplate('1fr 1fr 1fr 1fr 1fr 1fr 1fr')
  }

  @Builder
  example1() {
    Grid()
      .rowsTemplate('1fr 1fr 1fr')
      .columnsTemplate('1fr 2fr 1fr')
  }
}