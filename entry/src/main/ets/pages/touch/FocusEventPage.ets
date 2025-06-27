import { ColorMetrics, LengthMetrics } from '@kit.ArkUI';
import { KeyCode } from '@kit.InputKit';

@Entry
@Component
struct FocusEventPage {
  @State message: string = 'Hello World';
  @State oneButtonColor: Color = Color.Gray;
  @State twoButtonColor: Color = Color.Gray;
  @State threeButtonColor: Color = Color.Gray;

  build() {
    Scroll() {
      Column() {
        Text('获焦/失焦事件OnFocusOnBlur')
        this.exampleOnFocusOnBlur()
        Text('设置组件是否可获焦FocusableEnabled')
        this.exampleFocusableEnabled()
        Text('默认焦点')
        Text('页面的默认焦点DefaultFocus')
        this.exampleDefaultFocus()
        Text('容器的默认焦点DefaultFocusFocusPriority')
        this.exampleDefaultFocusFocusPriority()
        Text('焦点样式focusBox')
        this.exampleFocusBox()
        Text('主动获焦/失焦requestFocusClearFocus')
        this.exampleRequestFocusClearFocus()
        Text('焦点组与获焦优先级focusScopePriorityFocusScopeId')
        this.exampleFocusScopePriorityFocusScopeId()
        Text('焦点与按键事件OnClick')
        this.exampleOnClick()
      }
    }
    .height('100%')
    .width('100%')
  }
  @State count: number = 0
  @State name: string = 'Button'
  @Builder
  private exampleOnClick() {
    Button(this.name)
      .fontSize(30)
      .onClick(() => {
        this.count++
        if (this.count <= 0) {
          this.name = "count is negative number"
        } else if (this.count % 2 === 0) {
          this.name = "count is even number"
        } else {
          this.name = "count is odd number"
        }
      }).height(60)
  }

  @State inputValue: string = ''

  @Builder
  private exampleFocusScopePriorityFocusScopeId() {
    Row({ space: 20 }) {
      Column({ space: 20 }) { // 标记为Column1
        Column({ space: 5 }) {
          Button('Group1')
            .width(165)
            .height(40)
            .fontColor(Color.White)
          Row({ space: 5 }) {
            Button()
              .width(80)
              .height(40)
              .fontColor(Color.White)
            Button()
              .width(80)
              .height(40)
              .fontColor(Color.White)
          }

          Row({ space: 5 }) {
            Button()
              .width(80)
              .height(40)
              .fontColor(Color.White)
            Button()
              .width(80)
              .height(40)
              .fontColor(Color.White)
          }
        }.borderWidth(2).borderColor(Color.Red).borderStyle(BorderStyle.Dashed)

        Column({ space: 5 }) {
          Button('Group2')
            .width(165)
            .height(40)
            .fontColor(Color.White)
          Row({ space: 5 }) {
            Button()
              .width(80)
              .height(40)
              .fontColor(Color.White)
            Button()
              .width(80)
              .height(40)
              .fontColor(Color.White)
              .focusScopePriority('ColumnScope1', FocusPriority.PRIOR) // Column1首次获焦时获焦
          }

          Row({ space: 5 }) {
            Button()
              .width(80)
              .height(40)
              .fontColor(Color.White)
            Button()
              .width(80)
              .height(40)
              .fontColor(Color.White)
          }
        }.borderWidth(2).borderColor(Color.Green).borderStyle(BorderStyle.Dashed)
      }
      .focusScopeId('ColumnScope1')

      Column({ space: 5 }) { // 标记为Column2
        TextInput({ placeholder: 'input', text: this.inputValue })
          .onChange((value: string) => {
            this.inputValue = value
          })
          .width(156)
        Button('Group3')
          .width(165)
          .height(40)
          .fontColor(Color.White)
        Row({ space: 5 }) {
          Button()
            .width(80)
            .height(40)
            .fontColor(Color.White)
          Button()
            .width(80)
            .height(40)
            .fontColor(Color.White)
        }

        Button()
          .width(165)
          .height(40)
          .fontColor(Color.White)
          .focusScopePriority('ColumnScope2', FocusPriority.PREVIOUS) // Column2获焦时获焦
        Row({ space: 5 }) {
          Button()
            .width(80)
            .height(40)
            .fontColor(Color.White)
          Button()
            .width(80)
            .height(40)
            .fontColor(Color.White)
        }

        Button()
          .width(165)
          .height(40)
          .fontColor(Color.White)
        Row({ space: 5 }) {
          Button()
            .width(80)
            .height(40)
            .fontColor(Color.White)
          Button()
            .width(80)
            .height(40)
            .fontColor(Color.White)
        }
      }.borderWidth(2).borderColor(Color.Orange).borderStyle(BorderStyle.Dashed)
      .focusScopeId('ColumnScope2', true) // Column2为焦点组
    }.alignItems(VerticalAlign.Top)
  }

  @State btColor: string = '#ff2787d9'
  @State btColor2: string = '#ff2787d9'

  @Builder
  private exampleRequestFocusClearFocus() {
    Column({ space: 20 }) {
      Column({ space: 5 }) {
        Button('Button')
          .width(200)
          .height(70)
          .fontColor(Color.White)
          .focusOnTouch(true)
          .backgroundColor(this.btColor)
          .onFocus(() => {
            this.btColor = '#ffd5d5d5'
          })
          .onBlur(() => {
            this.btColor = '#ff2787d9'
          })
          .id("testButton")

        Button('Button')
          .width(200)
          .height(70)
          .fontColor(Color.White)
          .focusOnTouch(true)
          .backgroundColor(this.btColor2)
          .onFocus(() => {
            this.btColor2 = '#ffd5d5d5'
          })
          .onBlur(() => {
            this.btColor2 = '#ff2787d9'
          })
          .id("testButton2")

        Divider()
          .vertical(false)
          .width("80%")
          .backgroundColor('#ff707070')
          .height(10)

        Button('FocusController.requestFocus')
          .width(200).height(70).fontColor(Color.White)
          .onClick(() => {
            this.getUIContext().getFocusController().requestFocus("testButton")
          })
          .backgroundColor('#ff2787d9')

        Button("focusControl.requestFocus")
          .width(200).height(70).fontColor(Color.White)
          .onClick(() => {
            focusControl.requestFocus("testButton2")
          })
          .backgroundColor('#ff2787d9')

        Button("clearFocus")
          .width(200).height(70).fontColor(Color.White)
          .onClick(() => {
            this.getUIContext().getFocusController().clearFocus()
          })
          .backgroundColor('#ff2787d9')
      }
    }
    .width('100%')
  }

  @Builder
  private exampleFocusBox() {
    Column({ space: 30 }) {
      Button("small black focus box")
        .focusBox({
          margin: new LengthMetrics(0),
          strokeColor: ColorMetrics.rgba(0, 0, 0),
        })
      Button("large red focus box")
        .focusBox({
          margin: LengthMetrics.px(20),
          strokeColor: ColorMetrics.rgba(255, 0, 0),
          strokeWidth: LengthMetrics.px(10)
        })
    }
    .alignItems(HorizontalAlign.Center)
    .width('100%')
  }

  @Builder
  private exampleDefaultFocusFocusPriority() {
    Row() {
      Button('Button1')
        .defaultFocus(true)
      Button('Button2')
        .focusScopePriority('RowScope', FocusPriority.PREVIOUS)
    }.focusScopeId('RowScope')
  }

  @Builder
  private exampleDefaultFocus() {
    Column({ space: 20 }) {
      // 通过外接键盘的上下键可以让焦点在三个按钮间移动，按钮获焦时颜色变化，失焦时变回原背景色
      Button('First Button')
        .width(260)
        .height(70)
        .backgroundColor(this.oneButtonColor)
        .fontColor(Color.Black)// 监听第一个组件的获焦事件，获焦后改变颜色
        .onFocus(() => {
          this.oneButtonColor = Color.Green;
        })// 监听第一个组件的失焦事件，失焦后改变颜色
        .onBlur(() => {
          this.oneButtonColor = Color.Gray;
        })

      Button('Second Button')
        .width(260)
        .height(70)
        .backgroundColor(this.twoButtonColor)
        .fontColor(Color.Black)// 监听第二个组件的获焦事件，获焦后改变颜色
        .onFocus(() => {
          this.twoButtonColor = Color.Green;
        })// 监听第二个组件的失焦事件，失焦后改变颜色
        .onBlur(() => {
          this.twoButtonColor = Color.Grey;
        })

      Button('Third Button')
        .width(260)
        .height(70)
        .backgroundColor(this.threeButtonColor)
        .fontColor(Color.Black)// 设置默认焦点
        .defaultFocus(true)// 监听第三个组件的获焦事件，获焦后改变颜色
        .onFocus(() => {
          this.threeButtonColor = Color.Green;
        })// 监听第三个组件的失焦事件，失焦后改变颜色
        .onBlur(() => {
          this.threeButtonColor = Color.Gray;
        })
    }.width('100%').margin({ top: 20 })
  }



  @State textFocusable: boolean = true;
  @State textEnabled: boolean = true;
  @State color1: Color = Color.Yellow;
  @State color2: Color = Color.Yellow;
  @State color3: Color = Color.Yellow;

  @Builder
  private exampleFocusableEnabled() {
    Column({ space: 5 }) {
      Text('Default Text')// 第一个Text组件未设置focusable属性，默认不可获焦
        .borderColor(this.color1)
        .borderWidth(2)
        .width(300)
        .height(70)
        .onFocus(() => {
          this.color1 = Color.Blue;
        })
        .onBlur(() => {
          this.color1 = Color.Yellow;
        })
      Divider()

      Text('focusable: ' + this.textFocusable)// 第二个Text设置了focusable初始为true，focusableOnTouch为true
        .borderColor(this.color2)
        .borderWidth(2)
        .width(300)
        .height(70)
        .focusable(this.textFocusable)
        .focusOnTouch(true)
        .onFocus(() => {
          this.color2 = Color.Blue;
        })
        .onBlur(() => {
          this.color2 = Color.Yellow;
        })

      Text('enabled: ' + this.textEnabled)// 第三个Text设置了focusable为true，enabled初始为true
        .borderColor(this.color3)
        .borderWidth(2)
        .width(300)
        .height(70)
        .focusable(true)
        .enabled(this.textEnabled)
        .focusOnTouch(true)
        .onFocus(() => {
          this.color3 = Color.Blue;
        })
        .onBlur(() => {
          this.color3 = Color.Yellow;
        })

      Divider()

      Row() {
        Button('Button1')
          .width(140).height(70)
        Button('Button2')
          .width(160).height(70)
      }

      Divider()
      Button('Button3')
        .width(300).height(70)

      Divider()
    }.width('100%').justifyContent(FlexAlign.Center)
    .onKeyEvent((e) => {
      // 绑定onKeyEvent，在该Column组件获焦时，按下'F'键，可将第二个Text的focusable置反
      if (e.keyCode === KeyCode.KEYCODE_F && e.type === KeyType.Down) {
        this.textFocusable = !this.textFocusable;
      }
      // 绑定onKeyEvent，在该Column组件获焦时，按下'G'键，可将第三个Text的enabled置反
      if (e.keyCode === KeyCode.KEYCODE_G && e.type === KeyType.Down) {
        this.textEnabled = !this.textEnabled;
      }
    })
  }

  @Builder
  private exampleOnFocusOnBlur() {
    Column() {
      // 通过外接键盘的上下键可以让焦点在三个按钮间移动，按钮获焦时颜色变化，失焦时变回原背景色
      Button('First Button')
        .width(260)
        .height(70)
        .backgroundColor(this.oneButtonColor)
        .fontColor(Color.Black)// 监听第一个组件的获焦事件，获焦后改变颜色
        .onFocus(() => {
          this.oneButtonColor = Color.Green;
        })// 监听第一个组件的失焦事件，失焦后改变颜色
        .onBlur(() => {
          this.oneButtonColor = Color.Gray;
        })

      Button('Second Button')
        .width(260)
        .height(70)
        .backgroundColor(this.twoButtonColor)
        .fontColor(Color.Black)// 监听第二个组件的获焦事件，获焦后改变颜色
        .onFocus(() => {
          this.twoButtonColor = Color.Green;
        })// 监听第二个组件的失焦事件，失焦后改变颜色
        .onBlur(() => {
          this.twoButtonColor = Color.Grey;
        })

      Button('Third Button')
        .width(260)
        .height(70)
        .backgroundColor(this.threeButtonColor)
        .fontColor(Color.Black)// 监听第三个组件的获焦事件，获焦后改变颜色
        .onFocus(() => {
          this.threeButtonColor = Color.Green;
        })// 监听第三个组件的失焦事件，失焦后改变颜色
        .onBlur(() => {
          this.threeButtonColor = Color.Gray;
        })
    }
  }
}