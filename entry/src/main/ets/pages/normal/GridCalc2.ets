import Constants from '../../common/Constants';

@Entry
@Component
struct GridCalc2 {
  @State displayValue: string = "0";
  @State expression: string[] = [];
  @State lastInputIsOperator: boolean = false;

  build() {
    Column({ space: 1 }) {
      // 显示区域
      Text(this.displayValue)
        .width("100%")
        .height(100)
        .backgroundColor("#d3d3d3")
        .fontSize(36)
        .fontColor("#000")
        .textAlign(TextAlign.End)
        .padding({ right: 10 })
        .border({ width: 1, color: "#999" });

      // 按钮区域
      Grid() {
        // 第一行
        this.createButton("CE", "#E0E0E0", () => this.clearAll());
        this.createButton("C", "#E0E0E0", () => this.clear());
        this.createButton("/", "#FF9500", () => this.appendOperator("/"));
        this.createButton("×", "#FF9500", () => this.appendOperator("×"));

        // 第二行
        this.createButton("7", "#F5F5F5", () => this.appendNumber("7"));
        this.createButton("8", "#F5F5F5", () => this.appendNumber("8"));
        this.createButton("9", "#F5F5F5", () => this.appendNumber("9"));
        this.createButton("-", "#FF9500", () => this.appendOperator("-"));

        // 第三行
        this.createButton("4", "#F5F5F5", () => this.appendNumber("4"));
        this.createButton("5", "#F5F5F5", () => this.appendNumber("5"));
        this.createButton("6", "#F5F5F5", () => this.appendNumber("6"));
        this.createButton("+", "#FF9500", () => this.appendOperator("+"));

        // 第四行
        this.createButton("1", "#F5F5F5", () => this.appendNumber("1"));
        this.createButton("2", "#F5F5F5", () => this.appendNumber("2"));
        this.createButton("3", "#F5F5F5", () => this.appendNumber("3"));

        // 使用两个等号按钮模拟跨列效果
        GridItem() {
          Button("=")
            .width("100%")
            .height("100%")
            .backgroundColor("#FF9500")
            .fontColor("#FFF")
            .onClick(() => this.calculateResult());
        }

        GridItem() {
          Button("=")
            .width("100%")
            .height("100%")
            .backgroundColor("#FF9500")
            .fontColor("#FFF")
            .onClick(() => this.calculateResult());
        }

        // 第五行
        // 使用两个零按钮模拟跨列效果
        GridItem() {
          Button("0")
            .width("100%")
            .height("100%")
            .backgroundColor("#F5F5F5")
            .onClick(() => this.appendNumber("0"));
        }

        GridItem() {
          Button("0")
            .width("100%")
            .height("100%")
            .backgroundColor("#F5F5F5")
            .onClick(() => this.appendNumber("0"));
        }

        this.createButton(".", "#F5F5F5", () => this.appendDecimal());
        this.createButton("=", "#FF9500", () => this.calculateResult());
      }
      .columnsTemplate("1fr 1fr 1fr 1fr")
      .rowsTemplate("1fr 1fr 1fr 1fr 1fr")
      .width("100%")
      .height(500)
      .backgroundColor("#f2f2f2")
      .border({ width: 1, color: "#999" });
    }
    .width(Constants.FULL_WIDTH)
    .margin({ top: 50 });
  }

  // 创建按钮的辅助方法
  @Builder
  private createButton(label: string, bgColor: string, onClick: () => void): void {
    GridItem() {
      Button(label)
        .width("100%")
        .height("100%")
        .backgroundColor(bgColor)
        .fontColor(bgColor === "#FF9500" ? "#FFF" : "#000")
        .onClick(onClick);
    }
  }

  // 以下为计算器逻辑方法
  private appendNumber(num: string): void {
    if (this.displayValue === "0" || this.lastInputIsOperator) {
      this.displayValue = num;
    } else {
      this.displayValue += num;
    }
    this.lastInputIsOperator = false;
  }

  private appendOperator(operator: string): void {
    if (!this.lastInputIsOperator) {
      this.expression.push(this.displayValue, operator);
      this.lastInputIsOperator = true;
    } else {
      // 替换最后一个运算符
      if (this.expression.length > 0) {
        this.expression[this.expression.length - 1] = operator;
      }
    }
  }

  private appendDecimal(): void {
    if (this.lastInputIsOperator) {
      this.displayValue = "0.";
      this.lastInputIsOperator = false;
    } else if (!this.displayValue.includes(".")) {
      this.displayValue += ".";
    }
  }

  private clearAll(): void {
    this.displayValue = "0";
    this.expression = [];
    this.lastInputIsOperator = false;
  }

  private clear(): void {
    this.displayValue = "0";
    this.lastInputIsOperator = false;
  }

  private calculateResult(): void {
    if (this.lastInputIsOperator || this.expression.length === 0) {
      return;
    }

    this.expression.push(this.displayValue);
    let result = this.evaluateExpression();
    this.displayValue = result.toString();
    this.expression = [];
    this.lastInputIsOperator = false;
  }

  private evaluateExpression(): number {
    let result = parseFloat(this.expression[0]);

    for (let i = 1; i < this.expression.length; i += 2) {
      let operator = this.expression[i];
      let operand = parseFloat(this.expression[i + 1]);

      switch (operator) {
        case "+":
          result += operand;
          break;
        case "-":
          result -= operand;
          break;
        case "×":
          result *= operand;
          break;
        case "/":
          if (operand === 0) {
            return NaN;
          }
          result /= operand;
          break;
      }
    }

    return result;
  }
}