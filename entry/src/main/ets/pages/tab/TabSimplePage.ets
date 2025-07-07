import Constants, { Route, ChildRoute  } from '../../common/Constants';

@Builder
export function PageBuilder(name: string, param: Object) {
  TabSimplePage()
}

@Component
struct TabSimplePage {
  private routes: Route[] = [
    {
      title: $r('app.string.bottom_nav'),
      child: [
        {
          text: $r('app.string.common_bottom_nav'),
          to: 'TabsBottomTab'
        },
        {
          text: $r('app.string.rudder_bottom_nav'),
          to: 'TabsRudderStyleTab'
        },
        {
          text: $r('app.string.video_slide'),
          to: 'TabsTabContentOverflow'
        }
      ]
    },
    {
      title: $r('app.string.top_nav'),
      child: [
        {
          text: $r('app.string.left_tab'),
          to: 'TabsLeftTab'
        },
        {
          text: $r('app.string.underline_tab'),
          to: 'TabsUnderlineTab'
        },
        {
          text: $r('app.string.background_light_tab'),
          to: 'TabsBackgroundLightTab'
        },
        {
          text: $r('app.string.word_tab'),
          to: 'TabsWordTab'
        },
        {
          text: $r('app.string.double_nesting_tab_one'),
          to: 'TabsDoubleNestingTabOne'
        },
        {
          text: $r('app.string.double_nesting_tab_two'),
          to: 'TabsDoubleNestingTabTwo'
        },
        {
          text: $r('app.string.slide_and_mor_tab'),
          to: 'TabsSlideAndMoreTab'
        }
      ]
    },
    {
      title: $r('app.string.side_tab'),
      child: [
        {
          text: $r('app.string.common_side_tab'),
          to: 'TabsSideTab'
        },
        {
          text: $r('app.string.drawer_tab'),
          to: 'TabsDrawerTab'
        }
      ]
    }
  ];

  build() {
    NavDestination() {
      Scroll(){
        Column() {
          ForEach(this.routes, (item: Route) => {
            Row() {
              Text(item.title)
                .width(Constants.INDEX_CONTENT_WIDTH)
                .fontSize($r('app.float.double_text_size'))
                .fontColor($r('app.color.index_text_color'))
            }
            .height(Constants.CARD_TITLE_HEIGHT)

            Column() {
              ForEach(item.child, (itemChild: ChildRoute, index: number) => {
                Column() {
                  Text(itemChild.text)
                    .fontWeight(FontWeight.Medium)
                    .padding({ left: $r('app.float.padding_bottom_tab') })
                    .fontSize($r('app.float.text_size'))
                  Text(itemChild.to)
                    .fontWeight(FontWeight.Regular)
                    .padding({ left: $r('app.float.padding_bottom_tab') })
                    .fontSize('11fp')

                  if (item.child.length - 1 !== index) {
                    Row()
                      .height(Constants.DIVIDER_HEIGHT)
                      .backgroundColor($r('app.color.index_divider_color'))
                      .width(Constants.DIVIDER_WIDTH)
                  }
                }
                .padding({top: 20, bottom:20})
                .alignItems(HorizontalAlign.Start)
                .onClick(() => {
                  this.getUIContext().getRouter().pushUrl({
                    url: 'pages/tab/' + itemChild.to
                  })
                })
                .width(Constants.INDEX_CONTENT_WIDTH)
              }, (item: ChildRoute, index: number) => JSON.stringify(item) + index)
            }
            .margin({ top: $r('app.float.margin_index_top'), bottom: $r('app.float.margin_index_bottom') })
            .borderRadius(Constants.BORDER_RADIUS_INDEX_LIST)
            .backgroundColor(Color.White)
          }, (item: Route, index: number) => JSON.stringify(item) + index)
        }
        .width(Constants.FULL_WIDTH)
      }
      .backgroundColor($r('app.color.side_background_color'))
      .width(Constants.FULL_WIDTH)
      .height(Constants.FULL_HEIGHT)
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
    }
    .width(Constants.FULL_WIDTH)
    .height(Constants.FULL_HEIGHT)
  }
}