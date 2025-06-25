@Entry
@Component
struct MenuExamplePage {
  @State select: boolean = true
  private iconStr: ResourceStr = $r("app.media.startIcon")
  private iconStr2: ResourceStr = $r("app.media.startIcon")

  @Builder
  SubMenu() {
    Menu() {
      MenuItem({ content: "复制", labelInfo: "Ctrl+C" })
      MenuItem({ content: "粘贴", labelInfo: "Ctrl+V" })
    }
  }

  @Builder
  MyMenu() {
    Menu() {
      MenuItem({ startIcon: $r("app.media.icon"), content: "菜单选项" })
      MenuItem({ startIcon: $r("app.media.icon"), content: "菜单选项" }).enabled(false)
      MenuItem({
        startIcon: this.iconStr,
        content: "菜单选项",
        endIcon: $r("app.media.ic_arrow_right"),
        // 当builder参数进行配置时，表示与menuItem项绑定了子菜单。鼠标hover在该菜单项时，会显示子菜单。
        builder: this.SubMenu
      })
      MenuItemGroup({ header: '小标题' }) {
        MenuItem({ content: "菜单选项" })
          .selectIcon(true)
          .selected(this.select)
          .onChange((selected) => {
            console.info("menuItem select" + selected);
            let Str: Tmp = new Tmp()
            Str.set($r("app.media.icon"))
          })
        MenuItem({
          startIcon: $r("app.media.icon"),
          content: "菜单选项",
          endIcon: $r("app.media.ic_arrow_right"),
          builder: this.SubMenu
        })
      }.backgroundColor(Color.Green)

      MenuItem({
        startIcon: this.iconStr2,
        content: "菜单选项",
        endIcon: $r("app.media.ic_arrow_right")
      })
    }
  }

  build() {
    Column() {
      Button('创建默认样式的菜单')
        .id('MenuExamplePageHelloWorld')
        .fontWeight(FontWeight.Bold)
        .bindMenu([
          {
            value: 'Menu1',
            action: () => {
              console.info('handle Menu1 select')
            }
          }
        ])
      Button('创建自定义样式的菜单')
        .id('MenuExamplePageHelloWorld')
        .fontWeight(FontWeight.Bold)
        .bindMenu(this.MyMenu())
      Button('创建支持右键或长按的菜单')
        .id('MenuExamplePageHelloWorld')
        .fontWeight(FontWeight.Bold)
        //.bindMenu(this.MyMenu())
        .bindContextMenu(this.MyMenu(), ResponseType.LongPress)
    }
    .height('100%')
    .width('100%')
  }
}

class Tmp {
  iconStr2: ResourceStr = $r("app.media.startIcon")

  set(val: Resource) {
    this.iconStr2 = val
  }
}