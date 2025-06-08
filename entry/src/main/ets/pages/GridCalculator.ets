@Entry
@Component
struct GridCalculator {
  @State private displayValue: string = '0'
  @State private expression: string[] = []
  @State private lastInputIsOperator: boolean = false

  build(): void {
    Column() {
      // 显示区域
      Column() {
        Text(this.getDisplayExpression())
          .fontSize(24)
          .fontColor('#666')
          .width('100%')
          .textAlign(TextAlign.End)
          .margin({ top: 30, right: 20 })

        Text(this.displayValue)
          .fontSize(48)
          .fontColor('#000')
          .width('100%')
          .textAlign(TextAlign.End)
          .margin({ top: 10, right: 20, bottom: 30 })
      }
      .width('100%')
      .backgroundColor('#F5F5F5')

      // 按钮网格
      Grid() {
        // 第一行
        this.createButton('C', '#E0E0E0', () => this.clearAll())
        this.createButton('±', '#E0E0E0', () => this.toggleSign())
        this.createButton('%', '#E0E0E0', () => this.calculatePercentage())
        this.createButton('÷', '#FF9500', () => this.appendOperator('/'))

        // 第二行
        this.createButton('7', '#F5F5F5', () => this.appendNumber('7'))
        this.createButton('8', '#F5F5F5', () => this.appendNumber('8'))
        this.createButton('9', '#F5F5F5', () => this.appendNumber('9'))
        this.createButton('×', '#FF9500', () => this.appendOperator('*'))

        // 第三行
        this.createButton('6', '#F5F5F5', () => this.appendNumber('6'))
        this.createButton('5', '#F5F5F5', () => this.appendNumber('5'))
        this.createButton('4', '#F5F5F5', () => this.appendNumber('4'))
        this.createButton('-', '#FF9500', () => this.appendOperator('-'))

        // 第四行
        this.createButton('3', '#F5F5F5', () => this.appendNumber('3'))
        this.createButton('2', '#F5F5F5', () => this.appendNumber('2'))
        this.createButton('1', '#F5F5F5', () => this.appendNumber('1'))
        this.createButton('+', '#FF9500', () => this.appendOperator('+'))

        // 第五行 - 零键跨两列 (修改为两个零按钮)
        this.createButton('0', '#F5F5F5', () => this.appendNumber('0'))
        this.createButton('0', '#F5F5F5', () => this.appendNumber('0'))

        this.createButton('.', '#F5F5F5', () => this.appendDecimal())
        this.createButton('=', '#FF9500', () => this.calculateResult())
      }
      .columnsTemplate('1fr 1fr 1fr 1fr')
      .rowsTemplate('1fr 1fr 1fr 1fr 1fr')
      .columnsGap(1)
      .rowsGap(1)
      .width('100%')
      .height('60%')
    }
    .width('100%')
    .height('100%')
  }

  // 创建按钮组件的辅助方法，改为返回void并直接构建UI
  @Builder
  private createButton(label: string, bgColor: string, onClick: () => void): void {
    GridItem() {
      Button(label)
        .width('100%')
        .height('100%')
        .backgroundColor(bgColor)
        .fontColor(bgColor === '#FF9500' ? '#FFF' : '#000')
        .onClick(onClick)
    }
  }

  // 获取显示的表达式，显式指定返回类型
  private getDisplayExpression(): string {
    return this.expression.join(' ')
  }

  // 追加数字，显式指定返回类型
  private appendNumber(num: string): void {
    if (this.displayValue === '0' || this.lastInputIsOperator) {
      this.displayValue = num
    } else {
      this.displayValue += num
    }
    this.lastInputIsOperator = false
  }

  // 追加运算符，显式指定返回类型
  private appendOperator(operator: string): void {
    if (this.expression.length === 0 && this.displayValue === '0') {
      return // 不允许表达式开头是运算符
    }

    if (!this.lastInputIsOperator) {
      this.expression.push(this.displayValue, operator)
      this.lastInputIsOperator = true
    } else {
      // 替换最后一个运算符
      if (this.expression.length > 0) {
        this.expression[this.expression.length - 1] = operator
      }
    }
  }

  // 追加小数点，显式指定返回类型
  private appendDecimal(): void {
    if (this.lastInputIsOperator) {
      this.displayValue = '0.'
      this.lastInputIsOperator = false
    } else if (!this.displayValue.includes('.')) {
      this.displayValue += '.'
    }
  }

  // 清除所有，显式指定返回类型
  private clearAll(): void {
    this.displayValue = '0'
    this.expression = []
    this.lastInputIsOperator = false
  }

  // 正负号切换，显式指定返回类型
  private toggleSign(): void {
    this.displayValue = (parseFloat(this.displayValue) * -1).toString()
  }

  // 计算百分比，显式指定返回类型
  private calculatePercentage(): void {
    this.displayValue = (parseFloat(this.displayValue) / 100).toString()
  }

  // 计算结果，显式指定返回类型
  private calculateResult(): void {
    if (this.lastInputIsOperator || this.expression.length === 0) {
      return // 无效计算
    }

    this.expression.push(this.displayValue)
    let result = this.evaluateExpression()
    this.displayValue = result.toString()
    this.expression = []
    this.lastInputIsOperator = false
  }

  // 计算表达式结果，显式指定返回类型
  private evaluateExpression(): number {
    let result = parseFloat(this.expression[0])

    for (let i = 1; i < this.expression.length; i += 2) {
      let operator = this.expression[i]
      let operand = parseFloat(this.expression[i + 1])

      switch (operator) {
        case '+':
          result += operand
          break
        case '-':
          result -= operand
          break
        case '*':
          result *= operand
          break
        case '/':
          if (operand === 0) {
            return NaN
          }
          result /= operand
          break
      }
    }

    return result
  }
}