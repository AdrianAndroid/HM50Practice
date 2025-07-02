// fit_content_test.ets
import { webview } from '@kit.ArkWeb';


@Entry
@Component
struct WebHeightPage {
  private webviewController: WebviewController = new webview.WebviewController()
  private scroller: Scroller = new Scroller()


  build() {
    Navigation() {
      Column() {
        Scroll(this.scroller) {
          Column() {
            Web({
              src: $rawfile("fit_content.html"),
              controller: this.webviewController,
              renderMode: RenderMode.SYNC_RENDER // 设置为同步渲染模式
            })
              .layoutMode(WebLayoutMode.FIT_CONTENT) // 设置为Web组件大小自适应页面内容
              .overScrollMode(OverScrollMode.NEVER) // 设置过滚动模式为关闭状态
            Text("评论区")
              .fontSize(28)
              .fontColor("#FF0F0F")
              .height(100)
              .width("100%")
              .backgroundColor("#f89f0f")
          }
        }


      }
    }
    .title("标题栏")
  }
}