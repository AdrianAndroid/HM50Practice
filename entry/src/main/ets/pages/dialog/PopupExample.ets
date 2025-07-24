@Entry
@Component
struct PopupExample {
  @State handlePopup1: boolean = false;
  @State customPopup1: boolean = false;
  @State handlePopup2: boolean = false;
  @State customPopup3: boolean = false;
  @State handlePopup3: boolean = false;
  @State handlePopup4: boolean = false;
  @State customPopup4: boolean = false;

  @State handlePopup5: boolean = false;
  @State handlePopup6: boolean = false;
  @State handlePopup7: boolean = false


  // Popup构造器定义弹框内容
  @Builder
  popupBuilder1() {
    Row({ space: 2 }) {
      Image($r("app.media.icon")).width(24).height(24).margin({ left: -5 })
      Text('Custom Popup').fontSize(10)
    }.width(100).height(50).padding(5)
  }
  // Popup构造器定义弹框内容
  @Builder popupBuilder4() {
    Row() {
      Text('Custom Popup with transitionEffect').fontSize(10)
    }.height(50).padding(5)
  }

  build() {
    Scroll() {

      Column() {
        // PopupOptions 类型设置弹框内容
        Text('示例1（弹出不同类型的气泡）').fontSize(30)
        Button('PopupOptions')
          .onClick(() => {
            this.handlePopup1 = !this.handlePopup1;
          })
          .bindPopup(this.handlePopup1, {
            message: 'This is a popup with PopupOptions',
            placementOnTop: true,
            showInSubWindow: false,
            // 设置气泡避让软键盘
            keyboardAvoidMode: KeyboardAvoidMode.DEFAULT,
            primaryButton: {
              value: 'confirm',
              action: () => {
                this.handlePopup1 = !this.handlePopup1;
                console.info('confirm Button click');
              }
            },
            // 第二个按钮
            secondaryButton: {
              value: 'cancel',
              action: () => {
                this.handlePopup1 = !this.handlePopup1;
                console.info('cancel Button click');
              }
            },
            onStateChange: (e) => {
              console.info(JSON.stringify(e.isVisible))
              if (!e.isVisible) {
                this.handlePopup1 = false;
              }
            }
          })

        // CustomPopupOptions 类型设置弹框内容
        Button('CustomPopupOptions')
          .onClick(() => {
            this.customPopup1 = !this.customPopup1;
          })
          .bindPopup(this.customPopup1, {
            builder: this.popupBuilder1,
            placement: Placement.Top,
            mask: { color: '#33000000' },
            popupColor: Color.Yellow,
            enableArrow: true,
            // 设置气泡避让软键盘
            keyboardAvoidMode: KeyboardAvoidMode.DEFAULT,
            showInSubWindow: false,
            onStateChange: (e) => {
              if (!e.isVisible) {
                this.customPopup1 = false;
              }
            }
          })


        Text('示例2（设置气泡的文本样式）').fontSize(30)
        Button('PopupOptions').margin(100)
          .onClick(() => {
            this.handlePopup2 = !this.handlePopup2;
          })
          .bindPopup(this.handlePopup2, {
            // PopupOptions类型气泡的内容
            message: 'This is a popup with PopupOptions',
            messageOptions: {
              // 气泡的文本样式
              textColor: Color.Red,
              font: {
                size: '14vp',
                style: FontStyle.Italic,
                weight: FontWeight.Bolder
              }
            },
            placement: Placement.Bottom,
            enableArrow: false, // 气泡弹出时不显示箭头
            targetSpace: '15vp',
            onStateChange: (e) => {
              console.info(JSON.stringify(e.isVisible));
              if (!e.isVisible) {
                this.handlePopup2 = false;
              }
            }
          })

        Text('示例3（设置气泡的样式）').fontSize(30)
        Button("popup")
          .margin({ top: 50 })
          .onClick(() => {
            this.customPopup3 = !this.customPopup3;
          })
          .bindPopup(this.customPopup3, {
            message: "this is a popup",
            arrowHeight: 20, // 设置气泡箭头高度
            arrowWidth: 20, // 设置气泡箭头宽度
            radius: 20, // 设置气泡的圆角
            shadow: ShadowStyle.OUTER_DEFAULT_XS, // 设置气泡的阴影
          })

        Button('PopupOptions')
          .onClick(() => {
            this.handlePopup3 = !this.handlePopup3;
          })
          .bindPopup(this.handlePopup3, {
            width: 300,
            message: 'This is a popup with PopupOptions',
            arrowPointPosition: ArrowPointPosition.START, // 设置箭头的位置
            backgroundBlurStyle: BlurStyle.NONE, // 关闭气泡的模糊背景
            popupColor: Color.Red, // 设置气泡的背景色
            autoCancel: true,
          })

        Text('示例4（设置气泡的动效）').fontSize(30)
        // PopupOptions 类型设置弹框内容
        Button('PopupOptions')
          .onClick(() => {
            this.handlePopup4 = !this.handlePopup4;
          })
          .bindPopup(this.handlePopup4, {
            message: 'This is a popup with transitionEffect',
            placementOnTop: true,
            showInSubWindow: false,
            onStateChange: (e) => {
              console.info(JSON.stringify(e.isVisible))
              if (!e.isVisible) {
                this.handlePopup4 = false;
              }
            },
            // 设置气泡显示动效为透明度动效与平移动效的组合效果，无退出动效
            transition:TransitionEffect.asymmetric(TransitionEffect.OPACITY.animation({ duration: 1000, curve: Curve.Ease }).combine(TransitionEffect.translate({ x: 50, y: 50 })), TransitionEffect.IDENTITY)
          })
        // CustomPopupOptions 类型设置弹框内容
        Button('CustomPopupOptions')
          .onClick(() => {
            this.customPopup4 = !this.customPopup4;
          })
          .bindPopup(this.customPopup4, {
            builder: this.popupBuilder4,
            placement: Placement.Top,
            showInSubWindow: false,
            onStateChange: (e) => {
              if (!e.isVisible) {
                this.customPopup4 = false;
              }
            },
            // 设置气泡显示动效与退出动效为缩放动效
            transition:TransitionEffect.scale({ x: 1, y: 0 }).animation({ duration: 500, curve: Curve.Ease })
          })

        Text('示例5（为气泡添加事件）').fontSize(30)
        Button('PopupOptions')
          .onClick(() => {
            this.handlePopup5 = true;
          })
          .bindPopup(this.handlePopup5, {
            message: 'This is a popup with PopupOptions',
            messageOptions: {
              textColor: Color.Red,
              font: {
                size: '14vp',
                style: FontStyle.Italic,
                weight: FontWeight.Bolder
              }
            },
            placement: Placement.Bottom,
            enableArrow: false,
            targetSpace: '15vp',
            onStateChange: (e) => {
              if (!e.isVisible) {
                this.handlePopup5 = false;
              }
            },
            onWillDismiss: (
              (dismissPopupAction: DismissPopupAction) => {
                console.info("dismissReason:" + JSON.stringify(dismissPopupAction.reason));
                if (dismissPopupAction.reason === DismissReason.PRESS_BACK) {
                  dismissPopupAction.dismiss();
                }
              }
            )
          })

        Text('示例6（为气泡拦截退出事件）').fontSize(30)
        Button('PopupOptions')
          .onClick(() => {
            this.handlePopup6 = true;
          })
          .bindPopup(this.handlePopup6, {
            message: 'This is a popup with PopupOptions',
            messageOptions: {
              textColor: Color.Red,
              font: {
                size: '14vp',
                style: FontStyle.Italic,
                weight: FontWeight.Bolder
              }
            },
            placement: Placement.Bottom,
            enableArrow: false,
            targetSpace: '15vp',
            followTransformOfTarget: true,
            onStateChange: (e) => {
              let timer = setTimeout(() => {
                this.handlePopup6 = false;
              }, 6000);
              if (!e.isVisible) {
                this.handlePopup6 = false;
                clearTimeout(timer);
              }
            },
            onWillDismiss: false
          })

        Text('示例7（为气泡内外描边设置线性渐变）').fontSize(30)
        Button('PopupOptions')
          .onClick(() => {
            this.handlePopup7 = !this.handlePopup7
          })
          .bindPopup(this.handlePopup7, {
            message: 'This is a popup with PopupOptions',
            placementOnTop: true,
            // outlineWidth: 1,
            // outlineLinearGradient: {
            //   direction: GradientDirection.Top,
            //   colors: [[Color.Yellow, 0.0], [Color.Green, 1.0]]
            // },
            // borderWidth: 1,
            // borderLinearGradient: {
            //   direction: GradientDirection.Bottom,
            //   colors: [[Color.Red, 0.0], [Color.Blue, 1.0]]
            // }
          })

      }
    }
    .height('100%')
    .width('100%')
  }
}