import { PromptAction } from '@kit.ArkUI';

@Entry
@Component
struct FixedStyleDialogPage {
  @State selectTime: Date = new Date('2023-12-25T08:30:00');
  @State private selectedDate: Date = new Date('2024-04-23')
  private fruits: TextCascadePickerRangeContent[] = [
    {
      text: '辽宁省',
      children: [
        { text: '沈阳市', children: [{ text: '沈河区' }, { text: '和平区' }, { text: '浑南区' }] },
        { text: '大连市', children: [{ text: '中山区' }, { text: '金州区' }, { text: '长海县' }] }
      ]
    },
    {
      text: '吉林省',
      children: [
        { text: '长春市', children: [{ text: '南关区' }, { text: '宽城区' }, { text: '朝阳区' }] },
        { text: '四平市', children: [{ text: '铁西区' }, { text: '铁东区' }, { text: '梨树县' }] }
      ]
    },
    {
      text: '黑龙江省',
      children: [
        { text: '哈尔滨市', children: [{ text: '道里区' }, { text: '道外区' }, { text: '南岗区' }] },
        { text: '牡丹江市', children: [{ text: '东安区' }, { text: '西安区' }, { text: '爱民区' }] }
      ]
    }
  ]
  private select: number = 0;

  build() {
    Column() {
      Button('ShowActionMenu')
        .id('FixedStyleDialogPageHelloWorld')
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
          this.showActionMenu()
        })
      Button('showDialog')
        .id('FixedStyleDialogPageHelloWorld')
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
          this.showDialog()
        })

      // 选择器弹窗 (PickerDialog)
      Text(JSON.stringify(this.selectedDate))
      Button('calendarPickerDialog')
        .id('FixedStyleDialogPageHelloWorld')
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
          this.calendarPickerDialog()
        })
      Text(JSON.stringify(this.selectTime))
      Button('showDatePickerDialog')
        .id('FixedStyleDialogPageHelloWorld')
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
          this.showDatePickerDialog()
        })
      Button('showDatePickerDialog2')
        .id('FixedStyleDialogPageHelloWorld')
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
          this.showDatePickerDialog2()
        })
      Button('showTimePickerDialog')
        .id('FixedStyleDialogPageHelloWorld')
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
          this.showTimePickerDialog()
        })
      Button('showTextPickerDialog')
        .id('FixedStyleDialogPageHelloWorld')
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
          this.showTextPickerDialog()
        })
      Button('showActionSheet')
        .id('FixedStyleDialogPageHelloWorld')
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
          this.showActionSheet()
        })
      Button('showAlertDialog')
        .id('FixedStyleDialogPageHelloWorld')
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
          this.showAlertDialog()
        })
    }
    .height('100%')
    .width('100%')
  }

  private showAlertDialog() {
    this.getUIContext().showAlertDialog(
      {
        title: 'title',
        message: 'text',
        autoCancel: true,
        alignment: DialogAlignment.Center,
        offset: { dx: 0, dy: -20 },
        gridCount: 3,
        transition: TransitionEffect.asymmetric(TransitionEffect.OPACITY
          .animation({ duration: 3000, curve: Curve.Sharp })
          .combine(TransitionEffect.scale({ x: 1.5, y: 1.5 }).animation({ duration: 3000, curve: Curve.Sharp })),
          TransitionEffect.OPACITY.animation({ duration: 100, curve: Curve.Smooth })
            .combine(TransitionEffect.scale({ x: 0.5, y: 0.5 })
              .animation({ duration: 100, curve: Curve.Smooth }))),
        buttons: [{
          value: 'cancel',
          action: () => {
            console.info('Callback when the first button is clicked')
          }
        },
          {
            enabled: true,
            defaultFocus: true,
            style: DialogButtonStyle.HIGHLIGHT,
            value: 'ok',
            action: () => {
              console.info('Callback when the second button is clicked')
            }
          }],
      }
    )
  }

  private showActionSheet() {
    this.getUIContext().showActionSheet({
      title: 'ActionSheet title',
      message: 'message',
      autoCancel: false,
      width: 300,
      height: 300,
      cornerRadius: 20,
      borderWidth: 1,
      borderStyle: BorderStyle.Solid,
      borderColor: Color.Blue,
      backgroundColor: Color.White,
      transition: TransitionEffect.asymmetric(
        TransitionEffect.OPACITY
          .animation({ duration: 1000, curve: Curve.Sharp })
          .combine(TransitionEffect.scale({ x: 1.5, y: 1.5 }).animation({ duration: 1000, curve: Curve.Sharp })),
        TransitionEffect.OPACITY.animation({ duration: 100, curve: Curve.Smooth })
          .combine(TransitionEffect.scale({ x: 0.5, y: 0.5 }).animation({ duration: 100, curve: Curve.Smooth }))
      ),
      confirm: {
        value: 'Confirm button',
        action: () => {
          console.info('Get Alert Dialog handled')
        }
      },
      alignment: DialogAlignment.Center,
      sheets: [
        {
          title: 'apples',
          action: () => {
          }
        },
        {
          title: 'bananas',
          action: () => {
          }
        },
        {
          title: 'pears',
          action: () => {
            console.log('pears')
          }
        }
      ]
    })
  }

  private showTextPickerDialog() {
    this.getUIContext().showTextPickerDialog({
      range: this.fruits,
      selected: this.select,
      onAccept: (value: TextPickerResult) => {
        this.select = value.index as number
      }
    })
  }

  private showTimePickerDialog() {
    this.getUIContext().showTimePickerDialog({
      selected: this.selectTime,
      textStyle: { color: '#2787d9', font: { size: '14fp', weight: FontWeight.Normal } },
      selectedTextStyle: { color: '#004aaf', font: { size: '18fp', weight: FontWeight.Regular } },
      acceptButtonStyle: {
        fontColor: '#2787d9',
        fontSize: '16fp',
        backgroundColor: '#f7f7f7',
        borderRadius: 10
      },
      cancelButtonStyle: {
        fontColor: Color.Red,
        fontSize: '16fp',
        backgroundColor: '#f7f7f7',
        borderRadius: 10
      }
    })
  }

  private showDatePickerDialog2() {
    this.getUIContext().showDatePickerDialog({
      start: new Date("2000-1-1"),
      end: new Date("2100-12-31"),
      selected: this.selectTime,
      textStyle: { color: '#2787d9', font: { size: '14fp', weight: FontWeight.Normal } },
      selectedTextStyle: { color: '#004aaf', font: { size: '18fp', weight: FontWeight.Regular } },
      acceptButtonStyle: {
        fontColor: '#2787d9',
        fontSize: '16fp',
        backgroundColor: '#f7f7f7',
        borderRadius: 10
      },
      cancelButtonStyle: {
        fontColor: Color.Red,
        fontSize: '16fp',
        backgroundColor: '#f7f7f7',
        borderRadius: 10
      },
      onDateAccept: (value: Date) => {
        this.selectedDate = value
      }
    })

  }

  private showDatePickerDialog() {
    this.getUIContext().showDatePickerDialog({
      start: new Date("2000-1-1"),
      end: new Date("2100-12-31"),
      selected: this.selectTime,
      lunarSwitch: true,
      showTime: true,
      onDateAccept: (value: Date) => {
        this.selectTime = value
        console.info("DatePickerDialog:onAccept()" + JSON.stringify(value))
      },
    })
  }

  private calendarPickerDialog() {
    console.info("CalendarDialog.show")
    CalendarPickerDialog.show({
      selected: this.selectedDate,
      acceptButtonStyle: {
        fontColor: '#2787d9',
        fontSize: '16fp',
        backgroundColor: '#f7f7f7',
        borderRadius: 10
      },
      cancelButtonStyle: {
        fontColor: Color.Red,
        fontSize: '16fp',
        backgroundColor: '#f7f7f7',
        borderRadius: 10
      },
      onAccept: (date: Date) => {
        // 当弹出框再次弹出时显示选中的是上一次确定的日期
        this.selectedDate = date
      }
    })
  }

  private showDialog() {
    let uiContext = this.getUIContext();
    let promptAction: PromptAction = uiContext.getPromptAction();
    try {
      promptAction.showDialog({
        title: 'showDialog Title Info',
        message: 'Message Info',
        buttons: [
          {
            text: 'button1',
            color: '#000000'
          },
          {
            text: 'button2',
            color: '#000000'
          }
        ]
      }, (err, data) => {
        if (err) {
          console.error('showDialog err: ' + err);
          return;
        }
        console.info('showDialog success callback, click button: ' + data.index);
      });
    } catch (error) {
    }
  }

  private showActionMenu() {
    let uiContext = this.getUIContext();
    let promptAction: PromptAction = uiContext.getPromptAction();
    try {
      promptAction.showActionMenu({
        title: 'showActionMenu Title Info',
        buttons: [
          {
            text: 'item1',
            color: '#666666'
          },
          {
            text: 'item2',
            color: '#000000'
          },
        ]
      })
        .then(data => {
          console.info('showActionMenu success, click button: ' + data.index);
        })
        .catch((err: Error) => {
          console.error('showActionMenu error: ' + err);
        })
    } catch (error) {
    }
  }
}