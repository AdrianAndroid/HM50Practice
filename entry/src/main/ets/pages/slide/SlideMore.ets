import { promptAction } from "@kit.ArkUI"

@ComponentV2
struct SlideMore {
  @Local topBanners: BannerIndexBean[] = []
  @BuilderParam widgetsOnStack ?: CustomBuilder
  @BuilderParam widgetsOnTabContent?: CustomBuilder
  private listController: ListScroller = new ListScroller()
  private tabsController: TabsController = new TabsController()
  private rightMoreWidth: number = 70
  private currentTabIndex: number = 0
  private touchRightMoreSize = this.rightMoreWidth - 1
  private isTouchEnd: boolean = false

  @Event onTouchEnd: () => void = () => {
    promptAction.showToast({ message: 'onTouchEnd' })
  }

  build() {
    List({ scroller: this.listController }) {
      if (this.topBanners.length > 0) {
        ListItem() {
          Stack({ alignContent: Alignment.Top }) {
            this.mainTabBuilder()
            // VR/房型/公区标签组（位置调整：在Banner中部，避免被导航栏遮挡）
            // this.topTab()
            // this.bottomTab()
            if (this.widgetsOnStack) {
              this.widgetsOnStack()
            }
          }
        }

        ListItem() {
          // 侧边栏
          ZraSideBar({ rightMoreWidth: this.rightMoreWidth })
        }
      } else {
        ListItem() {
          Image('')
            .width('100%')
            .height('100%')
        }
      }
    }
    .onDidScroll(() => {
      // this.apartmentVm.bannerOffset = this.listController.currentOffset().xOffset
    })
    .listDirection(Axis.Horizontal)
    .edgeEffect(EdgeEffect.None)
    .scrollBar(BarState.Off)
    .nestedScroll({
      scrollForward: NestedScrollMode.SELF_FIRST,
      scrollBackward: NestedScrollMode.SELF_FIRST
    })
    .width('100%')
    .height(344)
  }

  @Builder
  mainTabBuilder() {
    if (this.widgetsOnTabContent) {
      Tabs({ controller: this.tabsController }) {
        if (this.topBanners.length >= 2) {
          ForEach(this.topBanners.slice(0, this.topBanners.length - 1), (item: BannerIndexBean, _: number) => {
            TabContent() {
              if (this.widgetsOnTabContent) {
                this.widgetsOnTabContent()
              }
            }
          })
        }
        if (this.topBanners.length >= 1) {
          TabContent() {
            if (this.widgetsOnTabContent) {
              this.widgetsOnTabContent()
            }
          }
          .gesture(
            PanGesture({ direction: PanDirection.Left })
              .onActionEnd(() => {
                this.listController.scrollTo({ xOffset: 0, yOffset: 0, animation: true })
                if (this.isTouchEnd && this.onTouchEnd) {
                  this.onTouchEnd()
                }
                this.isTouchEnd = false
              })
              .onActionCancel(() => {
                this.listController.scrollTo({ xOffset: 0, yOffset: 0, animation: true })
                this.isTouchEnd = false
              })
              .onActionUpdate((event: GestureEvent) => {
                // 当滑动到最后一页且手势为右滑时，触发外层 List 滚动
                if (this.currentTabIndex === (this.topBanners.length - 1) && event.offsetX < 0) {
                  this.listController.scrollBy(Math.abs(event.offsetX), 0)
                  if (!this.isTouchEnd && this.listController.currentOffset().xOffset >= this.touchRightMoreSize) {
                    this.isTouchEnd = true
                  }
                }
              })
          )
        }
      }
      .onChange((index: number) => {
        // this.zraBuildBannerVM.bannerTopIndex = this.topBanners[index].firIndex
        // this.zraBuildBannerVM.bannerBottomIndex = this.topBanners[index].secIndex
        // this.zraBuildBannerVM.changeBannerBottoms(this.topBanners[index].bottomLabels)
        // this.currentTabIndex = index
      })
      .tabsAnimation()
    }
  }
}

@Extend(Tabs)
function tabsAnimation() {
  .barHeight(0)
  .barWidth(0)
  .animationDuration(0)
  .animationMode(AnimationMode.NO_ANIMATION)
  .edgeEffect(EdgeEffect.None)
}

@ComponentV2
export struct ZraSideBar {
  @Require @Param rightMoreWidth: number
  @Param arrowImageResource: Resource = $r("app.media.message")
  @Param text: string = '滑动进入相册'

  build() {
    Column() {
      Row({ space: 3 }) {
        Image(this.arrowImageResource)
          .width(12)
          .height(12)
        Column() {
          ForEach(this.text.split(''), (item: string, index: number) => {
            Text(item)
              .fontSize(11)
              .fontColor('#ff999999')
          })
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .height('100%')
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .backgroundColor('#f6f8fc')
    .width(this.rightMoreWidth)
    .height('100%')
  }
}

class BannerIndexBean {
}

export class ZraConstants {
  // 1、VR；2、公寓视频；3、房型；4、公区；5、周边  6、效果图
  static readonly MEDIA_TYPE_VR = 1 // VR
  static readonly MEDIA_TYPE_VIDEO = 2 // 视频
  static readonly MEDIA_TYPE_HOUSE = 3 // 房型
  static readonly MEDIA_TYPE_PUBLIC = 4 // 公区
  static readonly MEDIA_TYPE_SURROUND = 5 // 周边
  static readonly MEDIA_TYPE_EFFECT_PIC = 6 // 效果图
}
