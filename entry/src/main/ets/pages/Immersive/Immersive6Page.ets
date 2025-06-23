@Entry
@Component
struct Immersive6Page {
  build() {
    Swiper() {
      Column() {
        Image($r('app.media.img_0'))
          .height('50%').width('100%')
          // 设置图片延伸到状态栏
          .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
        Column() {
          Text('HarmonyOS 第一课')
            .fontSize(32)
            .margin(30)
          Text('通过循序渐进的学习路径，无经验和有经验的开发者都可以掌握ArkTS语言声明式开发范式，体验更简洁、更友好的HarmonyOS应用开发旅程。')
            .fontSize(20).margin(20)
        }.height('50%').width('100%')
        .backgroundColor(Color.White)
        // 设置文本内容区背景延伸到导航栏
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
      }
    }
    .width('100%')
    .height('100%')
    // 关闭Swiper组件默认的裁切效果以便子节点可以绘制在Swiper外。
    .clip(false)
  }
}