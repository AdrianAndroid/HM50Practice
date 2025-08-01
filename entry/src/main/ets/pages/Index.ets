import Constants from '../common/Constants'
import { JSON } from '@kit.ArkTS'

// xxx.ets
interface RouterItem {
  title: string
  thumb: Resource
  path: string
}

const routerList: RouterItem[] = [
  {
    title: Constants.ArkTSMainPage,
    thumb: $r('sys.symbol.xmark_video'),
    path: Constants.ArkTSMainPage
  },
  {
    title: Constants.WebMainPage,
    thumb: $r('sys.symbol.private_browsing_mode'),
    path: Constants.WebMainPage
  },
  {
    title: Constants.DialogMainPage,
    thumb: $r('sys.symbol.dial'),
    path: Constants.DialogMainPage
  },
  {
    title: Constants.AnimateMainPage,
    thumb: $r('sys.symbol.shock_load_rate_fill'),
    path: Constants.AnimateMainPage
  },
  {
    title: Constants.FastWebExamplePage,
    thumb: $r('sys.symbol.whatsapp'),
    path: Constants.FastWebExamplePage
  },
  {
    title: Constants.DayJsExamplePage,
    thumb: $r('sys.symbol.star_calendar'),
    path: Constants.DayJsExamplePage
  },
  {
    title: Constants.StateExamplePage,
    thumb: $r('sys.symbol.radiostation_1'),
    path: Constants.StateExamplePage
  },
  {
    title: Constants.NavigationListExamplePage,
    thumb: $r('sys.symbol.navigation'),
    path: Constants.NavigationListExamplePage
  },
  {
    title: Constants.TabSimplePage,
    thumb: $r('sys.symbol.table_tennis_bat'),
    path: Constants.TabSimplePage
  },
  {
    title: Constants.SwiperExamplePage,
    thumb: $r('sys.symbol.swipe'),
    path: Constants.SwiperExamplePage
  },
  {
    title: Constants.SystemDateTimePage,
    thumb: $r('sys.symbol.time_lapse'),
    path: Constants.SystemDateTimePage
  },
  {
    title: Constants.SysResourcePage,
    thumb: $r('sys.symbol.input_source'),
    path: Constants.SysResourcePage
  },
  {
    title: Constants.Tyme4ohPage,
    thumb: $r('sys.symbol.calendar'),
    path: Constants.Tyme4ohPage
  }
]

@Preview
@Entry
@Component
struct Index {
  @State currentIndex: number = 0;
  @Provide('pathStack') pathStack: NavPathStack = new NavPathStack()
  @StorageProp('bottomRectHeight') bottomRectHeight: number = 0;
  @StorageProp('topRectHeight') topRectHeight: number = 0;
  @State navigationTitleMode: NavigationTitleMode = NavigationTitleMode.Free

  aboutToAppear(): void {
    // this.pathStack.disableAnimation(true) // 禁止动画
  }

  @Builder
  NavigationTitle() {
    Column() {
      Text('Title')
        .fontColor('#182431')
        .fontSize(30)
        .lineHeight(41)
        .fontWeight(700)
    }
    .backgroundColor(Color.Blue)
    .alignItems(HorizontalAlign.Start)
    .margin({ left: $r('sys.float.titlebar_title_margin_left'), right: $r('sys.float.titlebar_title_margin_right') })
  }

  onBackPress(): boolean | void {
    if (this.pathStack.size() > 0) {
      this.pathStack.pop()
      return true
    } else {
      return false
    }
  }

  changeNavigationTitleMode() {
    switch (this.navigationTitleMode) {
      case NavigationTitleMode.Free:
        this.navigationTitleMode = NavigationTitleMode.Full
        break
      case NavigationTitleMode.Full:
        this.navigationTitleMode = NavigationTitleMode.Mini
        break
      case NavigationTitleMode.Mini:
        this.navigationTitleMode = NavigationTitleMode.Free
        break
    }
  }

  @Builder
  NavigationMenus() {
    Row() {
      Image($r('sys.media.ohos_ic_public_add'))
        .width(24)
        .height(24)
      Image($r('sys.media.ohos_ic_public_add'))
        .width(24)
        .height(24)
        .margin({ left: 24 })
      Image($r('app.media.ic_source'))
        .width(48)
        .height(48)
        .margin({ left: 24 })
    }.backgroundColor(Color.Green)
    .margin({ right: $r('sys.float.titlebar_menu_margin_right') })
  }

  build() {
    Column() {
      Navigation(this.pathStack) {
        Column().height(this.getUIContext().px2vp(this.topRectHeight))

        TextInput({ placeholder: 'search...' })
          .width('90%')
          .height(40)
          .backgroundColor('#FFFFFF')
          .margin({ top: 8 })

        List({ space: 12, initialIndex: 0 }) {
          ForEach(routerList, (item: RouterItem) => {
            ListItem() {
              this.itemBuilder(item)
            }
            .onClick((event: ClickEvent) => {
              this.pathStack.pushPath({ name: item.path })
            })
          }, (item: number, index) => JSON.stringify(item))
        }
        .height('100%')
        .width('100%')
        .margin({top: 12})
      }
      // .title(this.NavigationTitle)
      // .menus(this.NavigationMenus)
      .titleMode(this.navigationTitleMode)
      .mode(NavigationMode.Stack)
      .toolbarConfiguration([
        {
          value: 'titleMode',
          icon: $r("app.media.ic_public_highlights"),
          action: () => {
            this.changeNavigationTitleMode()
          }
        },
        {
          value: 'add',
          icon: $r("app.media.ic_public_highlights"),
          action: () => {
            console.info('titleMode action2')
          }
        },
        {
          value: 'add',
          icon: $r("app.media.ic_public_highlights"),
          action: () => {
            console.info('titleMode action3')
          }
        }
      ])
      .hideTitleBar(false)
      .hideToolBar(false)
      .titleMode(NavigationTitleMode.Free)
      .onTitleModeChange((titleModel: NavigationTitleMode) => {
        console.info('titleMode' + titleModel)
      })
    }
    .width('100%').height('100%')
  }

  @Builder
  itemBuilder(item: RouterItem) {
    Row() {
      // Image(item.thumb)
      //   .width(60)
      //   .height(60)

      // 创建图标
      SymbolGlyph(item.thumb)
        .fontSize(60)
        .renderingStrategy(SymbolRenderingStrategy.SINGLE)
        .fontColor([Color.Black, Color.Green, Color.White])
      Blank()
        .width($r('sys.float.sheet_title_text_horizontal_margin'))
      Text(item.title)
        .width('90%')
        .height(Constants.FULL_HEIGHT)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.MARQUEE })
        .fontSize(16)
        .fontWeight(500)
        .textAlign(TextAlign.Start)
    }
    .margin({left: $r('sys.float.ohos_id_card_margin_start'), right: $r('sys.float.ohos_id_card_margin_end')})
    .backgroundColor(Color.White)
    .borderRadius(24)
    .height(72)
  }

  aboutToReuse(params: Record<string, object>): void {

  }
}