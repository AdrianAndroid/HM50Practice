import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct ModalHalfExamplePage {
  @State message: string = 'Hello World';
  @State isShowSheet: boolean = false
  private items: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

  @Builder
  SheetBuilder() {
    Column() {
      // 第一步：自定义滚动容器
      List({ space: '10vp' }) {
        ForEach(this.items, (item: number) => {
          ListItem() {
            Text(String(item)).fontSize(16).fontWeight(FontWeight.Bold)
          }.width('90%').height('80vp').backgroundColor('#ff53ecd9').borderRadius(10)
        })
      }
      .alignListItem(ListItemAlign.Center)
      .margin({ top: '10vp' })
      .width('100%')
      .height('900px')
      // 第二步：设置滚动组件的嵌套滚动属性
      .nestedScroll({
        scrollForward: NestedScrollMode.PARENT_FIRST,
        scrollBackward: NestedScrollMode.SELF_FIRST,
      })

      Text("非滚动区域")
        .width('100%')
        .backgroundColor(Color.Gray)
        .layoutWeight(1)
        .textAlign(TextAlign.Center)
        .align(Alignment.Top)
    }.width('100%').height('100%')
  }

  build() {
    Column() {
      Button('Open Sheet').width('90%').height('80vp')
        .onClick(() => {
          this.isShowSheet = !this.isShowSheet
        })
        .bindSheet(
          $$this.isShowSheet,
          this.SheetBuilder(),
          {
            detents: [SheetSize.MEDIUM, SheetSize.LARGE, 600],
            preferType: SheetType.BOTTOM,
            title: { title: '嵌套滚动场景' },
            // 第一步：声明onWillDismiss回调
            onWillDismiss: (action: DismissSheetAction) => {
              if (action.reason === DismissReason.PRESS_BACK) {
                promptAction.showToast({ message: 'DismissReason.PRESS_BACK' })
              } else if (action.reason === DismissReason.TOUCH_OUTSIDE) {
                promptAction.showToast({ message: 'DismissReason.TOUCH_OUTSIDE' })
              } else if (action.reason === DismissReason.CLOSE_BUTTON) {
                promptAction.showToast({ message: 'DismissReason.CLOSE_BUTTON' })
              } else if (action.reason === DismissReason.SLIDE_DOWN) {
                promptAction.showToast({ message: 'DismissReason.SLIDE_DOWN' })
              } else {
                promptAction.showToast({ message: 'DismissReason Other' })
              }
              // 第二步：确认二次回调交互能力，此处用AlertDialog提示 "是否需要关闭半模态"
              AlertDialog.show(
                {
                  message: '是否选择关闭半模态',
                  autoCancel: true,
                  alignment: DialogAlignment.Bottom,
                  gridCount: 4,
                  offset: { dx: 0, dy: -20 },
                  primaryButton: {
                    value: 'cancel',
                    action: () => {
                      console.info('Callback when the cancel button is clicked')
                    }
                  },
                  secondaryButton: {
                    enabled: true,
                    defaultFocus: true,
                    style: DialogButtonStyle.HIGHLIGHT,
                    value: 'ok',
                    // 第三步：确认关闭半模态逻辑所在，此处为AlertDialog的Button回调
                    action: () => {
                      // 第四步：上述第三步逻辑触发的时候，调用dismiss()关闭半模态
                      action.dismiss()
                      console.info('Callback when the ok button is clicked')
                    }
                  },
                  cancel: () => {
                    console.info('AlertDialog Closed callbacks')
                  }
                }
              )
            },
            onWillSpringBackWhenDismiss: (action: SpringBackAction) => {
              promptAction.showToast({ message: JSON.stringify(action) })
              //action.springBack()
            }
          },
        )

    }.width('100%').height('100%')
    .justifyContent(FlexAlign.Center)
  }
}