import dayjs from 'dayjs';
import { JSON } from '@kit.ArkTS';
import { FULL_PERCENT } from '../../model/ConstantsData';
import Constants from '../../common/ACConstants';
import es from 'dayjs/locale/es'
import advancedFormat from 'dayjs/plugin/advancedFormat'


@Builder
function PageBuilder() {
  DayJsExamplePage()
}

/**
 * https://day.js.org/docs/en/plugin/plugin
 * https://day.js.org/docs/en/parse/parse
 */
@Entry
@Component
struct DayJsExamplePage {
  @State message: string = 'Hello World';
  @State text1: string = 'text1'


  build() {
    NavDestination() {
      Column() {
        Blank().height(50)
        Text(this.text1).width(FULL_PERCENT)
        Button('点击显示').onClick(() => {
          let arr: string[] = []
          arr.push('dayjs(\'2018-08-08\')')
          arr.push(JSON.stringify(dayjs('2018-08-08')))
          arr.push('\n')

          arr.push('dayjs().format(\'{YYYY} MM-DDTHH:mm:ss SSS [Z] A\')')
          arr.push(JSON.stringify(dayjs().format('{YYYY} MM-DDTHH:mm:ss SSS [Z] A'))) // display
          arr.push('\n')

          arr.push('dayjs().set(\'month\', 3).month()')
          arr.push(JSON.stringify(dayjs().set('month', 3).month())) // get & set
          arr.push('\n')

          arr.push('dayjs().add(1, \'year\')')
          arr.push(JSON.stringify(dayjs().add(1, 'year'))) // manipulate
          arr.push('\n')

          arr.push('dayjs().isBefore(dayjs())')
          arr.push(JSON.stringify(dayjs().isBefore(dayjs()))) // query
          arr.push('\n')

          dayjs.locale(es)
          arr.push('dayjs(\'2018-05-05\').locale(\'zh-cn\').format()')
          arr.push(JSON.stringify(dayjs('2018-05-05').locale('zh-cn').format())) // query
          arr.push('\n')

          dayjs.extend(advancedFormat)
          arr.push('dayjs().format(\'Q Do k kk X x\')')
          arr.push(JSON.stringify(dayjs().format('Q Do k kk X x')))

          this.text1 = arr.join('\n')
        })

      }
      .height('100%')
      .width('100%')
    }
    .title('DayJsExamplePage')
    .hideTitleBar(false)
    .hideToolBar(false)
  }
}