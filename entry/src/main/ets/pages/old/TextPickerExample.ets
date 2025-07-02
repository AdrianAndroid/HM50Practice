@Entry
@Component
struct TextPickerExample {
  private select: number | number[] = 0;
  private cascade: TextCascadePickerRangeContent[] = [
    {
      text: '辽宁省',
      children: [{ text: '沈阳市', children: [{ text: '沈河区' }, { text: '和平区' }, { text: '浑南区' }] },
        { text: '大连市', children: [{ text: '中山区' }, { text: '金州区' }, { text: '长海县' }] }]
    },
    {
      text: '吉林省',
      children: [{ text: '长春市', children: [{ text: '南关区' }, { text: '宽城区' }, { text: '朝阳区' }] },
        { text: '四平市', children: [{ text: '铁西区' }, { text: '铁东区' }, { text: '梨树县' }] }]
    },
    {
      text: '黑龙江省',
      children: [{ text: '哈尔滨市', children: [{ text: '道里区' }, { text: '道外区' }, { text: '南岗区' }] },
        { text: '牡丹江市', children: [{ text: '东安区' }, { text: '西安区' }, { text: '爱民区' }] }]
    }
  ]
  @State v: string = '';
  @State showTriggered: string = '';
  private triggered: string = '';
  private maxLines: number = 3;


  linesNum(max: number): void {
    let items: string[] = this.triggered.split('').filter(item => item != '');
    if (items.length > max) {
      this.showTriggered = items.slice(-this.maxLines).join('');
    } else {
      this.showTriggered = this.triggered;
    }
  }


  build() {
    Column() {
      Button("TextPickerDialog.show:" + this.v)
        .onClick(() => {
          TextPickerDialog.show({
            range: this.cascade,
            selected: this.select,
            onAccept: (value: TextPickerResult) => {
              this.select = value.index
              console.log(this.select + '')
              this.v = value.value as string
              console.info("TextPickerDialog:onAccept()" + JSON.stringify(value))
              if (this.triggered != '') {
                this.triggered += `onAccept(${JSON.stringify(value)})`;
              } else {
                this.triggered = `onAccept(${JSON.stringify(value)})`;
              }
              this.linesNum(this.maxLines);
            },
            onCancel: () => {
              console.info("TextPickerDialog:onCancel()")
              if (this.triggered != '') {
                this.triggered += `onCancel()`;
              } else {
                this.triggered = `onCancel()`;
              }
              this.linesNum(this.maxLines);
            },
            onChange: (value: TextPickerResult) => {
              console.info("TextPickerDialog:onChange()" + JSON.stringify(value))
              if (this.triggered != '') {
                this.triggered += `onChange(${JSON.stringify(value)})`;
              } else {
                this.triggered = `onChange(${JSON.stringify(value)})`;
              }
              this.linesNum(this.maxLines);
            },
          })
        })
        .margin({ top: 60 })
    }
  }
}