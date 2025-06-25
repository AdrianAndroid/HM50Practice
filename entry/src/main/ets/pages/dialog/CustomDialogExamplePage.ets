@Entry
@Component
struct CustomDialogExamplePage {
  @State message: string = 'Hello World';
  @State textValue5: string = ''
  @State inputValue5: string = 'click me'
  @State textValue3: string = ''
  @State textValue4: string = ''
  @State inputValue4: string = 'click me'
  @State inputValue6: string = 'Click Me'
  dialogController1: CustomDialogController = new CustomDialogController({
    builder: CustomDialog1Example(),
  })
  dialogController2: CustomDialogController = new CustomDialogController({
    builder: CustomDialog2Example({
      cancel: () => {
        this.onCancel2()
      },
      confirm: () => {
        this.onAccept2()
      },
    }),
  })
  dialogController3: CustomDialogController | null = new CustomDialogController({
    builder: CustomDialog3Example({
      cancel: () => {
        this.onCancel3()
      },
      confirm: () => {
        this.onAccept3()
      },
      textValue: $textValue
    })
  })
  dialogController4: CustomDialogController | null = new CustomDialogController({
    builder: CustomDialog4Example(),
    openAnimation: {
      duration: 1200,
      curve: Curve.Friction,
      delay: 500,
      playMode: PlayMode.Alternate,
      onFinish: () => {
        console.info('play end')
      }
    },
    autoCancel: true,
    alignment: DialogAlignment.Bottom,
    offset: { dx: 0, dy: -20 },
    gridCount: 4,
    customStyle: false,
    backgroundColor: 0xd9ffffff,
    cornerRadius: 10,
  })
  dialogController5: CustomDialogController | null = new CustomDialogController({
    builder: CustomDialog5Example(),
    autoCancel: true,
    alignment: DialogAlignment.Center,
    offset: { dx: 0, dy: -20 },
    gridCount: 4,
    customStyle: false,
    backgroundColor: 0xd9ffffff,
    cornerRadius: 20,
    width: '80%',
    height: '100px',
    borderWidth: 1,
    borderStyle: BorderStyle.Dashed, //使用borderStyle属性，需要和borderWidth属性一起使用
    borderColor: Color.Blue, //使用borderColor属性，需要和borderWidth属性一起使用
    shadow: ({
      radius: 20,
      color: Color.Grey,
      offsetX: 50,
      offsetY: 0
    }),
  })
  dialogController6Two: CustomDialogController | null = new CustomDialogController({
    builder: CustomDialogExample6Two(),
    alignment: DialogAlignment.Bottom,
    offset: { dx: 0, dy: -25 }
  })
  dialogController6: CustomDialogController | null = new CustomDialogController({
    builder: CustomDialogExample6({
      openSecondBox: () => {
        if (this.dialogController6Two != null) {
          this.dialogController6Two.open()
        }
      }
    }),
    cancel: this.exitApp6,
    autoCancel: true,
    alignment: DialogAlignment.Bottom,
    offset: { dx: 0, dy: -20 },
    gridCount: 4,
    customStyle: false
  })

  // 在自定义组件即将析构销毁时将dialogController置空
  aboutToDisappear() {
    this.dialogController3 = null // 将dialogController置空
    this.dialogController4 = null // 将dialogController置空
    this.dialogController5 = null // 将dialogController置空
    this.dialogController6 = null
    this.dialogController6Two = null
  }

  onPageShow() {
    const params3 = this.getUIContext().getRouter().getParams() as Record<string, string>; // 获取传递过来的参数对象
    if (params3) {
      this.dialogController3?.open()
      this.textValue3 = params3.info as string; // 获取info属性的值
    }
  }

  onCancel2() {
    console.info('Callback when the first button is clicked')
  }

  onAccept2() {
    console.info('Callback when the second button is clicked')
  }

  onCancel3() {
    console.info('Callback when the first button is clicked')
  }

  onAccept3() {
    console.info('Callback when the second button is clicked')
  }

  exitApp3() {
    console.info('Click the callback in the blank area')
  }

  exitApp6() {
    console.info('Click the callback in the blank area')
  }

  build() {
    Column({ space: 10 }) {
      Button('创建自定义弹出框')
        .onClick(() => {
          this.dialogController1.open()
        })
      // 弹出框的交互
      Button('弹出框的交互')
        .onClick(() => {
          this.dialogController2.open()
        })
      Button('弹出框的交互传入的参数')
        .onClick(() => {
          if (this.dialogController3 != null) {
            this.dialogController3.open()
          }
        }).backgroundColor(0x317aff)
      Button(this.inputValue4 + '弹出框的动画')
        .onClick(() => {
          if (this.dialogController4 != null) {
            this.dialogController4.open()
          }
        }).backgroundColor(0x317aff)
      Button(this.inputValue5 + '弹出框的样式')
        .onClick(() => {
          if (this.dialogController5 != null) {
            this.dialogController5.open()
          }
        }).backgroundColor(0x317aff)
      Button(this.inputValue6 + '嵌套自定义弹出框')
        .onClick(() => {
          if (this.dialogController6 != null) {
            this.dialogController6.open()
          }
        }).backgroundColor(0x317aff)
    }
    .height('100%')
    .width('100%')
  }
}

@CustomDialog
struct CustomDialogExample6 {
  openSecondBox?: () => void
  controller?: CustomDialogController

  build() {
    Column() {
      Button('Open Second Dialog Box and close this box')
        .onClick(() => {
          this.controller!.close();
          this.openSecondBox!();
        })
        .margin(20)
    }.borderRadius(10)
  }
}

@CustomDialog
struct CustomDialogExample6Two {
  controllerTwo?: CustomDialogController
  @State message: string = "I'm the second dialog box."
  @State showIf: boolean = false;

  build() {
    Column() {
      if (this.showIf) {
        Text("Text")
          .fontSize(30)
          .height(100)
      }
      Text(this.message)
        .fontSize(30)
        .height(100)
      Button("Create Text")
        .onClick(() => {
          this.showIf = true;
        })
      Button('Close Second Dialog Box')
        .onClick(() => {
          if (this.controllerTwo != undefined) {
            this.controllerTwo.close()
          }
        })
        .margin(20)
    }
  }
}

@CustomDialog
struct CustomDialog5Example {
  controller?: CustomDialogController

  build() {
    Column() {
      Text('我是内容').fontSize(16).margin({ bottom: 10 })
    }
  }
}

@CustomDialog
struct CustomDialog4Example {
  controller?: CustomDialogController

  build() {
    Column() {
      Text('Whether to change a text?').fontSize(16).margin({ bottom: 10 })
    }
  }
}


@CustomDialog
struct CustomDialog3Example {
  @Link textValue: string
  controller?: CustomDialogController
  cancel: () => void = () => {
  }
  confirm: () => void = () => {
  }

  build() {
    Column({ space: 20 }) {
      if (this.textValue != '') {
        Text(`第二个页面的内容为：${this.textValue}`)
          .fontSize(20)
      } else {
        Text('是否获取第二个页面的内容')
          .fontSize(20)
      }
      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button('cancel')
          .onClick(() => {
            if (this.controller != undefined) {
              this.controller.close()
              this.cancel()
            }
          }).backgroundColor(0xffffff).fontColor(Color.Black)
        Button('confirm')
          .onClick(() => {
            if (this.controller != undefined && this.textValue != '') {
              this.controller.close()
            } else if (this.controller != undefined) {
              this.getUIContext().getRouter().pushUrl({
                url: 'pages/Index2'
              })
              this.controller.close()
            }
          }).backgroundColor(0xffffff).fontColor(Color.Red)
      }.margin({ bottom: 10 })
    }.borderRadius(10).padding({ top: 20 })
  }
}

@CustomDialog
struct CustomDialog2Example {
  cancel?: () => void
  confirm?: () => void
  controller: CustomDialogController

  build() {
    Column() {
      Text('我是内容').fontSize(20).margin({ top: 10, bottom: 10 })
      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button('cancel')
          .onClick(() => {
            this.controller.close()
            if (this.cancel) {
              this.cancel()
            }
          }).backgroundColor(0xffffff).fontColor(Color.Black)
        Button('confirm')
          .onClick(() => {
            this.controller.close()
            if (this.confirm) {
              this.confirm()
            }
          }).backgroundColor(0xffffff).fontColor(Color.Red)
      }.margin({ bottom: 10 })
    }
  }
}

@CustomDialog
struct CustomDialog1Example {
  controller: CustomDialogController = new CustomDialogController({
    builder: CustomDialog1Example({}),
  })

  build() {
    Column() {
      Text('我是内容')
        .fontSize(20)
    }.height(60).justifyContent(FlexAlign.Center)
  }
}