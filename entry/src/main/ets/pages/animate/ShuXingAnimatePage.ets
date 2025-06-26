import { curves } from '@kit.ArkUI';

// 第一步：使用@AnimatableExtend装饰器，自定义可动画属性接口
@AnimatableExtend(Text)
function animatableWidth(width: number) {
  .width(width) // 调用系统属性接口，逐帧回调函数每帧修改可动画属性的值，实现逐帧布局的效果。
}

declare type Point = number[];

// 定义可动画属性接口的参数类型，实现AnimatableArithmetic<T>接口中加法、减法、乘法和判断相等函数
class PointClass extends Array<number> {
  constructor(value: Point) {
    super(value[0], value[1])
  }

  add(rhs: PointClass): PointClass {
    let result: Point = new Array<number>() as Point;
    for (let i = 0; i < 2; i++) {
      result.push(rhs[i] + this[i])
    }
    return new PointClass(result);
  }

  subtract(rhs: PointClass): PointClass {
    let result: Point = new Array<number>() as Point;
    for (let i = 0; i < 2; i++) {
      result.push(this[i] - rhs[i]);
    }
    return new PointClass(result);
  }

  multiply(scale: number): PointClass {
    let result: Point = new Array<number>() as Point;
    for (let i = 0; i < 2; i++) {
      result.push(this[i] * scale)
    }
    return new PointClass(result);
  }
}

// 定义可动画属性接口的参数类型，实现AnimatableArithmetic<T>接口中加法、减法、乘法和判断相等函数
// 模板T支持嵌套实现AnimatableArithmetic<T>的类型
class PointVector extends Array<PointClass> implements AnimatableArithmetic<Array<Point>> {
  constructor(initialValue: Array<Point>) {
    super();
    if (initialValue.length) {
      initialValue.forEach((p: Point) => this.push(new PointClass(p)))
    }
  }

  // implement the IAnimatableArithmetic interface
  plus(rhs: PointVector): PointVector {
    let result = new PointVector([]);
    const len = Math.min(this.length, rhs.length)
    for (let i = 0; i < len; i++) {
      result.push(this[i].add(rhs[i]))
    }
    return result;
  }

  subtract(rhs: PointVector): PointVector {
    let result = new PointVector([]);
    const len = Math.min(this.length, rhs.length)
    for (let i = 0; i < len; i++) {
      result.push(this[i].subtract(rhs[i]))
    }
    return result;
  }

  multiply(scale: number): PointVector {
    let result = new PointVector([]);
    for (let i = 0; i < this.length; i++) {
      result.push(this[i].multiply(scale))
    }
    return result;
  }

  equals(rhs: PointVector): boolean {
    if (this.length !== rhs.length) {
      return false;
    }
    for (let index = 0, size = this.length; index < size; ++index) {
      if (this[index][0] !== rhs[index][0] || this[index][1] !== rhs[index][1]) {
        return false;
      }
    }
    return true;
  }
}

// 自定义可动画属性接口
@AnimatableExtend(Polyline)
function animatablePoints(points: PointVector) {
  .points(points)
}

@Entry
@Component
struct ShuXingAnimatePage {
  @State message: string = 'Hello World';
  @State animate: boolean = false;
  // 第一步: 声明相关状态变量
  @State rotateValue: number = 0; // 组件一旋转角度
  @State translateX: number = 0; // 组件二偏移量
  @State opacityValue: number = 1; // 组件二透明度
  @State textWidth: number = 80;

  squareStartPointX: number = 75;
  squareStartPointY: number = 25;
  squareWidth: number = 150;
  squareEndTranslateX: number = 50;
  squareEndTranslateY: number = 50;
  pointVec1: PointVector = new PointVector([
    [this.squareStartPointX, this.squareStartPointY],
    [this.squareStartPointX + this.squareWidth, this.squareStartPointY],
    [this.squareStartPointX + this.squareWidth, this.squareStartPointY + this.squareWidth],
    [this.squareStartPointX, this.squareStartPointY + this.squareWidth]
  ]);
  pointVec2: PointVector = new PointVector([
    [this.squareStartPointX + this.squareEndTranslateX, this.squareStartPointY + this.squareStartPointY],
    [this.squareStartPointX + this.squareWidth + this.squareEndTranslateX, this.squareStartPointY + this.squareStartPointY],
    [this.squareStartPointX + this.squareWidth, this.squareStartPointY + this.squareWidth],
    [this.squareStartPointX, this.squareStartPointY + this.squareWidth]
  ]);
  @State color: Color = Color.Green;
  @State fontSize: number = 20.0;
  @State polyline1Vec: PointVector = this.pointVec1;
  @State polyline2Vec: PointVector = this.pointVec2;

  // 第二步：将状态变量设置到相关可动画属性接口
  build() {
    Column({space: 10}) {
      Text('使用animateTo产生属性动画')
      this.useAnimateTo()
      Text('使用animation产生属性动画')
      this.useAnimate()
      Text('使用number数据类型和@AnimatableExtend装饰器改变Text组件宽度实现逐帧布局的效果')
      this.custom1Animation()
      Text('使用自定义数据类型和@AnimatableExtend装饰器改变图形形状')
      this.custom2Animation()
    }
    .height('100%')
    .width('100%')
  }

  @Builder
  custom2Animation() {
    Row() {
      Polyline()
        .width(300)
        .height(200)
        .backgroundColor("#0C000000")
        .fill('#317AF7')
        .animatablePoints(this.polyline1Vec)
        .animation({ duration: 2000, delay: 0, curve: Curve.Ease })
        .onClick(() => {

          if (this.polyline1Vec.equals(this.pointVec1)) {
            this.polyline1Vec = this.pointVec2;
          } else {
            this.polyline1Vec = this.pointVec1;
          }
        })
    }
    .width('100%').justifyContent(FlexAlign.Center)
  }

  @Builder
  custom1Animation() {
    Row() {
      Text("AnimatableProperty")
        .animatableWidth(this.textWidth)// 第二步：将自定义可动画属性接口设置到组件上
        .animation({ duration: 2000, curve: Curve.Ease }) // 第三步:为自定义可动画属性接口绑定动画
      Button("Play")
        .onClick(() => {
          this.textWidth = this.textWidth == 80 ? 160 : 80; // 第四步：改变自定义可动画属性的参数，产生动画
        })
    }
  }

  @Builder
  private useAnimateTo() {
    Row() {
      // 组件一
      Column() {
      }
      .rotate({ angle: this.rotateValue })
      .backgroundColor('#317AF7')
      .justifyContent(FlexAlign.Center)
      .width(100)
      .height(100)
      .borderRadius(30)
      .onClick(() => {
        this.getUIContext()?.animateTo({ curve: curves.springMotion() }, () => {
          this.animate = !this.animate;
          // 第三步：闭包内通过状态变量改变UI界面
          // 这里可以写任何能改变UI的逻辑比如数组添加，显隐控制，系统会检测改变后的UI界面与之前的UI界面的差异，对有差异的部分添加动画
          // 组件一的rotate属性发生变化，所以会给组件一添加rotate旋转动画
          this.rotateValue = this.animate ? 90 : 0;
          // 组件二的透明度发生变化，所以会给组件二添加透明度的动画
          this.opacityValue = this.animate ? 0.6 : 1;
          // 组件二的translate属性发生变化，所以会给组件二添加translate偏移动画
          this.translateX = this.animate ? 50 : 0;
        })
      })

      // 组件二
      Column() {

      }
      .justifyContent(FlexAlign.Center)
      .width(100)
      .height(100)
      .backgroundColor('#D94838')
      .borderRadius(30)
      .opacity(this.opacityValue)
      .translate({ x: this.translateX })
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  private useAnimate() {
    Row() {
      // 组件一
      Column() {
      }
      .opacity(this.opacityValue)
      .rotate({ angle: this.rotateValue })
      // 第三步：通过属性动画接口开启属性动画
      .animation({ curve: curves.springMotion() })
      .backgroundColor('#317AF7')
      .justifyContent(FlexAlign.Center)
      .width(100)
      .height(100)
      .borderRadius(30)
      .onClick(() => {
        this.animate = !this.animate;
        // 第四步：闭包内通过状态变量改变UI界面
        // 这里可以写任何能改变UI的逻辑比如数组添加，显隐控制，系统会检测改变后的UI界面与之前的UI界面的差异，对有差异的部分添加动画
        // 组件一的rotate属性发生变化，所以会给组件一添加rotate旋转动画
        this.rotateValue = this.animate ? 90 : 0;
        // 组件二的translate属性发生变化，所以会给组件二添加translate偏移动画
        this.translateX = this.animate ? 50 : 0;
        // 父组件column的opacity属性有变化，会导致其子节点的透明度也变化，所以这里会给column和其子节点的透明度属性都加动画
        this.opacityValue = this.animate ? 0.6 : 1;
      })

      // 组件二
      Column() {
      }
      .justifyContent(FlexAlign.Center)
      .width(100)
      .height(100)
      .backgroundColor('#D94838')
      .borderRadius(30)
      .opacity(this.opacityValue)
      .translate({ x: this.translateX })
      .animation({ curve: curves.springMotion() })
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
  }
}