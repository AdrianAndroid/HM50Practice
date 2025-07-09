import Constants from '../../common/Constants'
import { SysColorPage } from './SysColorPage'
import { SysFloatPage } from './SysFloatPage'
import { SysMediaPage } from './SysMediaPage'
import { SysStringPage } from './SysStringPage'
import { SysSymbolPage } from './SysSymbolPage'


const MODE_COLOR: number = 0
const MODE_FLOAT: number = 1
const MODE_MEDIA: number = 2
const MODE_STRING: number = 3
const MODE_SYMBOL: number = 4

@Builder
export function PageBuilder(name: string, param: Object) {
  SysResourcePage()
}


@Entry
@Component
struct SysResourcePage {
  @State mode: number = 0;
  pathStack: NavPathStack = new NavPathStack()

  build() {
    NavDestination() {
      Column() {
        Row() {
          this.buildRadio('COLOR', MODE_COLOR, () => {
            this.mode = MODE_COLOR
          })
          this.buildRadio('FLOAT', MODE_FLOAT, () => {
            this.mode = MODE_FLOAT
          })
          this.buildRadio('MEDIA', MODE_MEDIA, () => {
            this.mode = MODE_MEDIA
          })
          this.buildRadio('STRING', MODE_STRING, () => {
            this.mode = MODE_STRING
          })
          this.buildRadio('SYMBOL', MODE_SYMBOL, () => {
            this.mode = MODE_SYMBOL
          })
        }

        if (this.mode === MODE_COLOR) {
          SysColorPage()
        } else if (this.mode === MODE_FLOAT) {
          SysFloatPage()
        } else if (this.mode === MODE_MEDIA) {
          SysMediaPage()
        } else if (this.mode === MODE_STRING) {
          SysStringPage()
        } else if (this.mode === MODE_SYMBOL) {
          SysSymbolPage()
        }
      }
      .height('100%')
      .width('100%')
    }
    .title(Constants.SysResourcePage)
    .hideTitleBar(false)
    .hideToolBar(false)
    .onReady((callback) => {
      this.pathStack = callback.pathStack
    })
  }

  @Builder
  buildRadio(text: string, mode: number, onChange: () => void) {
    Column() {
      Text(text).fontSize(11)
      Radio({ value: text, group: 'mode' })
        .checked(this.mode == mode)
        .width(20)
        .height(20)
        .onChange((isCheck) => {
          if (isCheck) {
            onChange()
          }
        })
    }.borderWidth(1)
  }
}