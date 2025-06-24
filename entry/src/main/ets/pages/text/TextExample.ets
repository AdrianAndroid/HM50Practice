import Constants from '../../common/Constants';
import TextMarqueeView from './TextMarqueeView';
import TextGradientView from './TextMarqueeView';
import TextReflectionView from './TextReflectionView';
import TextScrollingView from './TextScrollingView';

// xxx.ets
@Entry
@Component
struct TextExample {
  @State message: ResourceStr = $r('app.string.text_content');
  @State messageLong: ResourceStr = $r('app.string.text_content_long');
  @State value: number = 0;

  @Styles
  fancy() {
    .borderRadius($r('app.float.row_border_radius'))
    .backgroundColor(Color.White)
    .padding({
      top: $r('app.float.row_padding'),
      bottom: $r('app.float.row_padding')
    })
    .width(Constants.FULL_PERCENT)
  }

  @Builder
  textBuilder(value: ResourceStr) {
    Row() {
      Text(value)
        .fontSize($r("app.float.title_font_size"))
        .fontColor($r('app.color.title_font_color'))
        .fontWeight(Constants.FONT_WEIGHT_500)
        .margin({ top: $r('app.float.title_margin_bottom') })
        .lineHeight($r('app.float.title_line_height'))
    }
    .width(Constants.FULL_PERCENT)
    .height($r('app.float.title_row_height'))
    .margin({ bottom: $r('app.float.title_row_margin_bottom') })
  }


  build() {

    Navigation() {
      Column() {
        this.textBuilder($r('app.string.text_gradient'))
        Row() {
          TextGradientView({ message: this.message }) // 两边阴影
        }
        .fancy()
        .justifyContent(FlexAlign.Center)

        this.textBuilder($r('app.string.text_scrolling'))
        Row() {
          TextScrollingView({ message: this.message })
        }
        .fancy()
        .justifyContent(FlexAlign.Center)

        this.textBuilder($r('app.string.text_reflection'))
        Row() {
          TextReflectionView({ message: this.message })
        }
        .fancy()
        .justifyContent(FlexAlign.Center)

        this.textBuilder($r('app.string.text_marquee'))
        Row() {
          TextMarqueeView({ message: this.messageLong })
        }
        .fancy()
        .justifyContent(FlexAlign.Center)

        Row() {
          Text("1").fontSize(14).fontColor(Color.Red).margin({ left: 10, right: 10 })
          Text("我是热搜词条1")
            .fontSize(12)
            .fontColor(Color.Blue)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .fontWeight(300)
          Text("爆")
            .margin({ left: 6 })
            .textAlign(TextAlign.Center)
            .fontSize(10)
            .fontColor(Color.White)
            .fontWeight(600)
            .backgroundColor(0x770100)
            .borderRadius(5)
            .width(15)
            .height(14)
        }.width('100%').margin(5)


        Row() {
          Text("2").fontSize(14).fontColor(Color.Red).margin({ left: 10, right: 10 })
          Text("我是热搜词条2 我是热搜词条2 我是热搜词条2 我是热搜词条2 我是热搜词条2")
            .fontSize(12)
            .fontColor(Color.Blue)
            .fontWeight(300)
            .constraintSize({ maxWidth: 200 })
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
          Text("热")
            .margin({ left: 6 })
            .textAlign(TextAlign.Center)
            .fontSize(10)
            .fontColor(Color.White)
            .fontWeight(600)
            .backgroundColor(0xCC5500)
            .borderRadius(5)
            .width(15)
            .height(14)
        }.width('100%').margin(5)


        Row() {
          Text("3").fontSize(14).fontColor(Color.Orange).margin({ left: 10, right: 10 })
          Text("我是热搜词条3")
            .fontSize(12)
            .fontColor(Color.Blue)
            .fontWeight(300)
            .maxLines(1)
            .constraintSize({ maxWidth: 200 })
            .textOverflow({ overflow: TextOverflow.Ellipsis })
          Text("热")
            .margin({ left: 6 })
            .textAlign(TextAlign.Center)
            .fontSize(10)
            .fontColor(Color.White)
            .fontWeight(600)
            .backgroundColor(0xCC5500)
            .borderRadius(5)
            .width(15)
            .height(14)
        }.width('100%').margin(5)


        Row() {
          Text("4").fontSize(14).fontColor(Color.Grey).margin({ left: 10, right: 10 })
          Text("我是热搜词条4 我是热搜词条4 我是热搜词条4 我是热搜词条4 我是热搜词条4")
            .fontSize(12)
            .fontColor(Color.Blue)
            .fontWeight(300)
            .constraintSize({ maxWidth: 200 })
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }.width('100%').margin(5)
      }
      .padding({
        left: $r('app.float.area_padding_left'),
        right: $r('app.float.area_padding_left')
      })
    }
    .height(Constants.FULL_PERCENT)
    .width(Constants.FULL_PERCENT)
    .title($r('app.string.title'))
    .backgroundColor($r('app.color.page_background_color'))
    .mode(NavigationMode.Stack)
  }
}