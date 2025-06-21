// sdk/Calculator.ets
import { collections } from '@kit.ArkTS'


@Sendable
export class Calculator {
  history?: collections.Array<collections.Array<string>>
  totalCount: number = 0


  static init(): Calculator {
    let calc = new Calculator()
    calc.totalCount = 0
    calc.history = collections.Array.create(calc.totalCount, collections.Array.create(2, ""));
    return calc
  }


  add(a: number, b: number) {
    let result = a + b;
    this.newCalc(`${a} + ${b}`, `${result}`);
    return result
  }


  sub(a: number, b: number) {
    let result = a - b;
    this.newCalc(`${a} - ${b}`, `${result}`);
    return result
  }


  mul(a: number, b: number) {
    let result = a * b;
    this.newCalc(`${a} * ${b}`, `${result}`);
    return result
  }


  div(a: number, b: number) {
    let result = a / b;
    this.newCalc(`${a} / ${b}`, `${result}`);
    return result
  }


  getHistory(): collections.Array<collections.Array<string>> {
    return this.history!;
  }


  showHistory() {
    for (let i = 0; i < this.totalCount; i++) {
      console.info(`${i}: ${this.history![i][0]} = ${this.history![i][1]}`)
    }
  }


  private newCalc(opt: string, ret: string) {
    let newRecord = new collections.Array<string>(opt, ret)
    this.totalCount = this.history!.unshift(newRecord)
  }
}