import { FULL_PERCENT } from '../../model/ConstantsData'

const PAGE_ONE = 'PAGE_ONE'
const PAGE_TWO = 'PAGE_TWO'
const PAGE_THR = 'PAGE_THR'
const PAGE_FOU = 'PAGE_FOU'
const PAGE_FIV = 'PAGE_FIV'
const PAGE_SIX = 'PAGE_SIX'

/**
 * https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/arkts-new-rendering-control-repeat
 */
@Entry
@ComponentV2
struct RepeatExamplePage {
  @Local checkPage: string = PAGE_ONE
  @Local dataArr1: Array<string> = []; // 数据源

  aboutToAppear(): void {
    for (let i = 0; i < 50; i++) {
      this.dataArr1.push(`data_${i}`); // 为数组添加一些数据
    }
  }

  @Builder
  buildRadio(page: string) {
    Radio({ value: 'Radio1', group: 'radioGroup' })
      .checked(this.checkPage === page)
      .onChange(() => {
        this.checkPage = page
      })
  }

  build() {
    Column() {
      Flex() {
          this.buildRadio(PAGE_ONE)
          this.buildRadio(PAGE_TWO)
          this.buildRadio(PAGE_THR)
          this.buildRadio(PAGE_FOU)
          this.buildRadio(PAGE_FIV)
          this.buildRadio(PAGE_SIX)
      }
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
      .width(FULL_PERCENT)

      if (this.checkPage === PAGE_ONE) {
        this.example1()
      } else if (this.checkPage === PAGE_TWO) {
      } else if (this.checkPage === PAGE_THR) {
      } else if (this.checkPage === PAGE_FOU) {
      } else if (this.checkPage === PAGE_FIV) {
      } else if (this.checkPage === PAGE_SIX) {
      }
    }
    .padding({top: 50})
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
    .height('100%')
    .width('100%')
  }

  @Builder
  example1() {
    Column() {
      List() {
        Repeat<string>(this.dataArr1)
          .each((ri: RepeatItem<string>) => {
            ListItem() {
              Text('each_' + ri.item).fontSize(30)
            }
          })
          .virtualScroll({ totalCount: this.dataArr1.length }) // 打开懒加载，totalCount为期望加载的数据长度
      }
      .cachedCount(2) // 容器组件的预加载区域大小
      .height('70%')
      .width(FULL_PERCENT)
      .border({ width: 1 }) // 边框
    }
  }
}