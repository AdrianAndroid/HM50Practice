import { promptAction } from '@kit.ArkUI';

export interface SelectionMenuTheme {
  imageSize: number;
  buttonSize: number;
  menuSpacing: number;
  editorOptionMargin: number;
  expandedOptionPadding: number;
  defaultMenuWidth: number;
  imageFillColor: Resource;
  backGroundColor: Resource;
  iconBorderRadius: Resource;
  containerBorderRadius: Resource;
  cutIcon: Resource;
  copyIcon: Resource;
  pasteIcon: Resource;
  selectAllIcon: Resource;
  shareIcon: Resource;
  translateIcon: Resource;
  searchIcon: Resource;
  arrowDownIcon: Resource;
  iconPanelShadowStyle: ShadowStyle;
  iconFocusBorderColor: Resource;
}

// 自定义SelectionMenuTheme接口

export const defaultTheme: SelectionMenuTheme = {
  imageSize: 24,
  buttonSize: 48,
  menuSpacing: 8,
  editorOptionMargin: 1,
  expandedOptionPadding: 3,
  defaultMenuWidth: 256,
  imageFillColor: $r('sys.color.ohos_id_color_primary'),
  backGroundColor: $r('sys.color.ohos_id_color_dialog_bg'),
  iconBorderRadius: $r('sys.float.ohos_id_corner_radius_default_m'),
  containerBorderRadius: $r('sys.float.ohos_id_corner_radius_card'),
  cutIcon: $r("sys.media.ohos_ic_public_cut"),
  copyIcon: $r("sys.media.ohos_ic_public_copy"),
  pasteIcon: $r("sys.media.ohos_ic_public_paste"),
  selectAllIcon: $r("sys.media.ohos_ic_public_select_all"),
  shareIcon: $r("sys.media.ohos_ic_public_share"),
  translateIcon: $r("sys.media.ohos_ic_public_translate_c2e"),
  searchIcon: $r("sys.media.ohos_ic_public_search_filled"),
  arrowDownIcon: $r("sys.media.ohos_ic_public_arrow_down"),
  iconPanelShadowStyle: ShadowStyle.OUTER_DEFAULT_MD,
  iconFocusBorderColor: $r('sys.color.ohos_id_color_focused_outline'),
}

// 定义defaultTheme变量

@Entry
@Component
struct RichEditorExamplePage {
  @State message: string = 'Hello World';
  controller: RichEditorController = new RichEditorController()
  options: RichEditorOptions = { controller: this.controller }
  scroller = new Scroller()
  fontStyle: TextStyle = new TextStyle({ fontColor: Color.Pink });
  // 定义字体样式对象
  mutableStyledString: MutableStyledString = new MutableStyledString("创建使用属性字符串构建的RichEditor组件。",
    [{
      start: 0,
      length: 5,
      styledKey: StyledStringKey.FONT,
      styledValue: this.fontStyle
    }]);
  controller2: RichEditorStyledStringController = new RichEditorStyledStringController();
  options2: RichEditorStyledStringOptions = { controller: this.controller2 };
  theme = defaultTheme
  @State sliderShow: boolean = true
  controller1: RichEditorController = new RichEditorController();
  options1: RichEditorOptions = { controller: this.controller1 }
  private my_builder: CustomBuilder = undefined

  build() {
    Scroll(this.scroller) {
      Column() {
        // 创建不使用属性字符串构建的RichEditor组件
        RichEditor(this.options)
          .border({ width: 1 })
          .onReady(() => {
            this.controller.addTextSpan('创建不使用属性字符串构建的RichEditor组件。', {
              style: {
                fontColor: Color.Black,
                fontSize: 15
              }
            })
          })
          .onSubmit(() => {
            promptAction.showToast({ message: 'onSubmit' })
            this.scroller.scrollEdge(Edge.Bottom)
          })

        // 创建使用属性字符串构建的RichEditor组件
        RichEditor(this.options2)
          .border({ width: 1 })
          .onReady(() => {
            this.controller2.setStyledString(this.mutableStyledString);
          })

        // 设置属性
        // 设置自定义选择菜单
        RichEditor(this.options)
          .onReady(() => {
            this.controller.addTextSpan('组件设置了自定义菜单，长按可触发。', {
              style: {
                fontColor: Color.Black,
                fontSize: 18
              }
            })
          })
          .bindSelectionMenu(RichEditorSpanType.TEXT, this.SystemMenu, ResponseType.LongPress, {
            onDisappear: () => {
              this.sliderShow = false
            }
          })
          .border({ width: 1 })// 绑定自定义菜单
          .width(300)
          .height(100)

        // 设置输入框光标、手柄颜色
        RichEditor(this.options)
          .border({ width: 1 })
          .onReady(() => {
            this.controller.addTextSpan('组件设置了光标手柄颜色。', {
              style: {
                fontColor: Color.Black,
                fontSize: 15
              }
            })
          })
          .caretColor(Color.Orange)
          .width(300)
          .height(100)

        // 设置无输入时的提示文本
        RichEditor(this.options)
          .border({ width: 1 })
          .placeholder("此处为提示文本...", {
            fontColor: Color.Gray,
            font: {
              size: 15,
              weight: FontWeight.Normal,
              family: "HarmonyOS Sans",
              style: FontStyle.Normal
            }
          })
          .width(300)
          .height(50)

        // 添加事件
        // 添加组件初始化完成后可触发的回调
        RichEditor(this.options)
          .border({ width: 1 })
          .onReady(() => {
            this.controller.addTextSpan('onReady回调内容是组件内预置文本。', {
              style: {
                fontColor: Color.Black,
                fontSize: 15
              }
            })
          })

        // 添加组件内容被选中时可触发的回调
        RichEditor(this.options)
          .border({ width: 1 })
          .onReady(() => {
            this.controller.addTextSpan('选中此处文本，触发onselect回调。', {
              style: {
                fontColor: Color.Black,
                fontSize: 15
              }
            })
          })
          .onSelect((value: RichEditorSelection) => {
            this.controller.addTextSpan(JSON.stringify(value), {
              style: {
                fontColor: Color.Gray,
                fontSize: 10
              }
            })
          })
          .width(300)
          .height(50)
        Text('查看回调内容：').fontSize(10).fontColor(Color.Gray).width(300)
        RichEditor(this.options)
          .border({ width: 1 })
          .width(300)
          .height(70)

        // 添加图文变化前和图文变化后可触发的回调
        RichEditor(this.options)
          .border({ width: 1 })
          .onReady(() => {
            promptAction.showToast({ message: 'onReady' })
            this.controller.addTextSpan('组件内图文变化前，触发回调。\n图文变化后，触发回调。', {
              style: {
                fontColor: Color.Black,
                fontSize: 15
              }
            })
          })
          .onWillChange((value: RichEditorChangeValue) => {
            promptAction.showToast({ message: 'onWillChange' })
            this.controller.addTextSpan('组件内图文变化前，触发回调：\n' + JSON.stringify(value), {
              style: {
                fontColor: Color.Gray,
                fontSize: 10
              }
            })
            return true;
          })
          .onDidChange((rangeBefore: TextRange, rangeAfter: TextRange) => {
            promptAction.showToast({ message: 'onDidChange' })
            this.controller.addTextSpan('\n图文变化后，触发回调：\nrangeBefore:' + JSON.stringify(rangeBefore) +
              '\nrangeAfter：' + JSON.stringify(rangeBefore), {
              style: {
                fontColor: Color.Gray,
                fontSize: 10
              }
            })
            return true;
          })
          .width(300)
          .height(50)

        Text('查看回调内容：').fontSize(10).fontColor(Color.Gray).width(300)
        RichEditor(this.options)
          .border({ width: 1 })
          .width(300)
          .height(70)

        // 添加输入法输入内容前和完成输入后可触发的回调
        RichEditor(this.options)
          .border({ width: 1 })
          .onReady(() => {
            this.controller.addTextSpan('输入法输入内容前，触发回调。\n输入法完成输入后，触发回调。', {
              style: {
                fontColor: Color.Black,
                fontSize: 15
              }
            })
          })
          .aboutToIMEInput((value: RichEditorInsertValue) => {
            this.controller.addTextSpan('输入法输入内容前，触发回调：\n' + JSON.stringify(value), {
              style: {
                fontColor: Color.Gray,
                fontSize: 10
              }
            })
            return true;
          })
          .onIMEInputComplete((value: RichEditorTextSpanResult) => {
            this.controller.addTextSpan('输入法完成输入后，触发回调：\n' + JSON.stringify(value), {
              style: {
                fontColor: Color.Gray,
                fontSize: 10
              }
            })
            return true;
          })
          .width(300)
          .height(50)
        Text('查看回调内容：').fontSize(10).fontColor(Color.Gray).width(300)
        RichEditor(this.options)
          .border({ width: 1 })
          .width(300)
          .height(70)

        // 添加完成粘贴前可触发的回调
        RichEditor(this.options)
          .border({ width: 1 })
          .onReady(() => {
            this.controller.addTextSpan('对此处文本进行复制粘贴操作可触发对应回调。', {
              style: {
                fontColor: Color.Black,
                fontSize: 15
              }
            })
          })
          .onPaste(() => {
            this.controller.addTextSpan('触发onPaste回调\n', {
              style: {
                fontColor: Color.Gray,
                fontSize: 10
              }
            })
          })
          .width(300)
          .height(70)

        // 设定用户预设的样式
        RichEditor(this.options)
          .border({ width: 1 })
          .onReady(() => {
            this.controller.addTextSpan('点击按钮,改变组件预设样式。', {
              style: {
                fontColor: Color.Black,
                fontSize: 15
              }
            })
          })
          .width(300)
          .height(60)
        Button('setTypingStyle', {
          buttonStyle: ButtonStyleMode.NORMAL
        })
          .height(30)
          .fontSize(13)
          .onClick(() => {
            this.controller.setTypingStyle({
              fontWeight: 'medium',
              fontColor: Color.Pink,
              fontSize: 15,
              fontStyle: FontStyle.Italic,
              decoration: {
                type: TextDecorationType.Underline,
                color: Color.Gray
              }
            })
          })

        // 设置组件内的内容选中时部分背板高亮
        RichEditor(this.options)
          .border({ width: 1 })
          .onReady(() => {
            this.controller.addTextSpan('点击按钮在此处选中0-2位置的文本。', {
              style: {
                fontColor: Color.Black,
                fontSize: 15
              }
            })
          })
          .width(300)
          .height(60)
        Button('setSelection(0,2)', {
          buttonStyle: ButtonStyleMode.NORMAL
        })
          .height(30)
          .fontSize(13)
          .onClick(() => {
            this.controller.setSelection(0, 2)
          })

        // 添加文本内容
        RichEditor(this.options)
          .border({ width: 1 })
          .onReady(() => {
            this.controller.addTextSpan('点击按钮在此处添加text。', {
              style: {
                fontColor: Color.Black,
                fontSize: 15
              }
            })
          })
          .width(300)
          .height(100)
        Button('addTextSpan', {
          buttonStyle: ButtonStyleMode.NORMAL
        })
          .height(30)
          .fontSize(13)
          .onClick(() => {
            this.controller.addTextSpan('新添加一段文字。')
          })

        // 添加图片内容
        RichEditor(this.options)
          .border({ width: 1 })
          .onReady(() => {
            this.controller.addTextSpan('点击按钮在此处添加image。', {
              style: {
                fontColor: Color.Black,
                fontSize: 15
              }
            })
          })
          .width(300)
          .height(100)
        Button('addImageSpan', {
          buttonStyle: ButtonStyleMode.NORMAL
        })
          .height(30)
          .fontSize(13)
          .onClick(() => {
            this.controller.addImageSpan($r("app.media.startIcon"), {
              imageStyle: {
                size: ["57px", "57px"]
              }
            })
          })

        // 添加@Builder装饰器修饰的内容
        Button('addBuilderSpan', {
          buttonStyle: ButtonStyleMode.NORMAL
        })
          .height(30)
          .fontSize(13)
          .onClick(() => {
            this.my_builder = () => {
              this.TextBuilder()
            }
            this.controller.addBuilderSpan(this.my_builder)
          })

        // 添加SymbolSpan内容
        RichEditor(this.options)
          .border({ width: 1 })
          .onReady(() => {
            this.controller.addTextSpan('点击按钮在此处添加symbol。', {
              style: {
                fontColor: Color.Black,
                fontSize: 15
              }
            })
          })
          .width(300)
          .height(100)
        Button('addSymbolSpan', {
          buttonStyle: ButtonStyleMode.NORMAL
        })
          .height(30)
          .fontSize(13)
          .onClick(() => {
            this.controller.addSymbolSpan($r("sys.symbol.basketball_fill"), {
              style: {
                fontSize: 30
              }
            })
          })

        // 获取组件内图文信息
        RichEditor(this.options)
          .border({ width: 1 })
          .onReady(() => {
            this.controller.addTextSpan('点击按钮获取此处span信息。', {
              style: {
                fontColor: Color.Black,
                fontSize: 15
              }
            })
          })
          .width(300)
          .height(50)
        Text('查看getSpans返回值：').fontSize(10).fontColor(Color.Gray).width(300)
        RichEditor(this.options1)
          .border({ width: 1 })
          .width(300)
          .height(50)
        Button('getSpans', {
          buttonStyle: ButtonStyleMode.NORMAL
        })
          .height(30)
          .fontSize(13)
          .onClick(() => {
            this.controller1.addTextSpan(JSON.stringify(this.controller.getSpans()), {
              style: {
                fontColor: Color.Gray,
                fontSize: 10
              }
            })
          })
      }.width('100%')
    }
    .height('100%')
    .width('100%')
  }

  @Builder
  TextBuilder() {
    Row() {
      Image($r('app.media.startIcon')).width(50).height(50).margin(16)
      Column() {
        Text("文本文档.txt").fontWeight(FontWeight.Bold).fontSize(16)
        Text("123.45KB").fontColor('#8a8a8a').fontSize(12)
      }.alignItems(HorizontalAlign.Start)
    }.backgroundColor('#f4f4f4')
    .borderRadius("20")
    .width(220)
  }

  @Builder
  SystemMenu() {
    Column() {
      Menu() {
        if (this.controller) {
          MenuItemGroup() {
            MenuItem({
              startIcon: this.theme.cutIcon,
              content: "剪切",
              labelInfo: "Ctrl+X",
            })
            MenuItem({
              startIcon: this.theme.copyIcon,
              content: "复制",
              labelInfo: "Ctrl+C"
            })
            MenuItem({
              startIcon: this.theme.pasteIcon,
              content: "粘贴",
              labelInfo: "Ctrl+V"
            })
          }
        }
      }
      .radius(this.theme.containerBorderRadius)
      .clip(true)
      .backgroundColor(Color.White)
      .width(this.theme.defaultMenuWidth)
    }
    .width(this.theme.defaultMenuWidth)
  }
}