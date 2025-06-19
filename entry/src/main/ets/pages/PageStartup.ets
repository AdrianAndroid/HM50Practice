import { startupManager } from '@kit.AbilityKit';

@Entry
@Component
struct PageStartup {
  @State message: string = '手动模式';
  @State startParams: Array<string> = ["StartupTask_006"];

  build() {
    RelativeContainer() {
      Button(this.message)
        .id('AppStartup')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
          if (!startupManager.isStartupTaskInitialized("StartupTask_006")) { // 判断是否已经完成初始化
            startupManager.run(this.startParams)
          }
        })
        .alignRules({
          center: {anchor: '__container__', align: VerticalAlign.Center},
          middle: {anchor: '__container__', align: HorizontalAlign.Center}
        })
    }
    .height('100%')
    .width('100%')
  }
}