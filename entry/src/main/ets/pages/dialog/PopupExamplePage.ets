@Entry
@Component
struct PopupExamplePage {
  @State handlePopup1: boolean = false
  @State handlePopup2: boolean = false
  @State handlePopup3: boolean = false
  @State handlePopup4: boolean = false
  @State handlePopup5: boolean = false
  @State handlePopup6: boolean = false
  @State handlePopup7: boolean = false
  @State handlePopup8: boolean = false
  @State handlePopup9: boolean = false

  // popup构造器定义弹框内容
  @Builder
  popupBuilder() {
    Row() {
      Text('Custom Popup with transitionEffect').fontSize(10)
    }.height(50).padding(5)
  }

  // popup构造器定义弹框内容
  @Builder
  popupBuilder8() {
    Row({ space: 2 }) {
      Image($r("app.media.icon")).width(24).height(24).margin({ left: 5 })
      Text('This is Custom Popup').fontSize(15)
    }.width(200).height(50).padding(5)
  }

  build() {
    Column({ space: 20 }) {
      Button('文本提示气泡')
        .id('PopupExamplePageHelloWorld')
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
          this.handlePopup1 = !this.handlePopup1
        })
        .bindPopup(this.handlePopup1, {
          message: 'This is a popup with PopupOptions',
        })
      Button('添加气泡状态变化的事件')
        .id('PopupExamplePageHelloWorld')
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
          this.handlePopup2 = !this.handlePopup2
        })
        .bindPopup(this.handlePopup2, {
          message: 'This is a popup with PopupOptions',
          onStateChange: (e) => { // 返回当前的气泡状态
            if (!e.isVisible) {
              this.handlePopup2 = false
            }
          }
        })
      Button('带按钮的提示气泡')
        .id('PopupExamplePageHelloWorld')
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
          this.handlePopup3 = !this.handlePopup3
        })
        .bindPopup(this.handlePopup3, {
          message: 'This is a popup with PopupOptions',
          primaryButton: {
            value: 'Confirm',
            action: () => {
              this.handlePopup3 = !this.handlePopup3
              console.info('confirm Button click')
            }
          },
          secondaryButton: {
            value: 'Cancel',
            action: () => {
              this.handlePopup4 = !this.handlePopup4
            }
          },
          onStateChange: (e) => {
            if (!e.isVisible) {
              this.handlePopup4 = false
            }
          }
        })

      // PopupOptions 类型设置弹框内容
      Button('气泡的动画111')
        .onClick(() => {
          this.handlePopup6 = !this.handlePopup6
        })
        .bindPopup(this.handlePopup6, {
          message: 'This is a popup with transitionEffect',
          placementOnTop: true,
          showInSubWindow: false,
          onStateChange: (e) => {
            if (!e.isVisible) {
              this.handlePopup6 = false
            }
          },
          // 设置弹窗显示动效为透明度动效与平移动效的组合效果，无退出动效
          transition: TransitionEffect.asymmetric(
            TransitionEffect.OPACITY.animation({ duration: 1000, curve: Curve.Ease }).combine(
              TransitionEffect.translate({ x: 50, y: 50 })),
            TransitionEffect.IDENTITY)
        })
      // .position({ x: 100, y: 150 })

      // CustomPopupOptions 类型设置弹框内容
      Button('气泡的动画222')
        .onClick(() => {
          this.handlePopup7 = !this.handlePopup7
        })
        .bindPopup(this.handlePopup7, {
          builder: this.popupBuilder,
          placement: Placement.Top,
          showInSubWindow: false,
          onStateChange: (e) => {
            if (!e.isVisible) {
              this.handlePopup7 = false
            }
          },
          // 设置弹窗显示动效与退出动效为缩放动效
          transition: TransitionEffect.scale({ x: 1, y: 0 }).animation({ duration: 500, curve: Curve.Ease })
        })
      // .position({ x: 80, y: 300 })

      Button('自定义气泡')
        .id('PopupExamplePageHelloWorld')
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
          this.handlePopup8 = !this.handlePopup8
        })
        .bindPopup(this.handlePopup8, {
          builder: this.popupBuilder8, // 气泡的内容
          placement: Placement.Bottom, // 气泡的弹出位置
          popupColor: Color.Pink, // 气泡的背景色
          onStateChange: (e) => {
            if (!e.isVisible) {
              this.handlePopup8 = false
            }
          }
        })


      Button('气泡样式')
        .id('PopupExamplePageHelloWorld')
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
          this.handlePopup9 = !this.handlePopup9
        })
        .bindPopup(this.handlePopup9, {
          width: 200,
          message: 'This is a popup.',
          popupColor: Color.Red, // 设置气泡的背景色
          mask: {
            color: '#33d9d9d9'
          },
          placement: Placement.Top,
          backgroundBlurStyle: BlurStyle.NONE // 去除背景模糊效果需要关闭气泡的模糊背景
        })
    }
    .height('100%')
    .width('100%')
  }
}