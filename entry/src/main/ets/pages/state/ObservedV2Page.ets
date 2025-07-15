import { promptAction } from '@kit.ArkUI'

@Entry
@ComponentV2
struct ObservedV2Page {
  @Local num: number = 1

  @Builder
  buildRadio(num: number) {
    Column() {
      Radio({ value: num.toString(), group: 'radioGroup' })
        .checked(this.num === num)
        .onChange(() => {
          this.num = num
        })
      Text(num.toString())
    }
  }

  build() {
    Column() {
      Blank().height(100)
      Row() {
        this.buildRadio(1)
        this.buildRadio(2)
        this.buildRadio(3)
        this.buildRadio(4)
        this.buildRadio(5)
        this.buildRadio(6)
        this.buildRadio(7)
        this.buildRadio(8)
      }

      Blank().height(50)

      if (this.num === 1) {
        Example1Page()
      } else if (this.num === 2) {
        Example2Page()
      } else if (this.num === 3) {
        Example3Page()
      } else if (this.num === 4) {
        Example4Page()
      } else if (this.num === 5) {
        Example5Page()
      } else if (this.num === 6) {
        Example6Page()
      } else if (this.num === 7) {
        Example7Page()
      } else if (this.num === 8) {
        Example8Page()
      } else if (this.num === 9) {
        Example9Page()
      } else if (this.num === 10) {
        Example10Page()
      } else if (this.num === 11) {
      }
    }
    .height('100%')
    .width('100%')
  }
}




///////////////////////////////////////////////////
// @Trace装饰Date类型
// @Trace装饰的Date类型属性可以观测调用API带来的变化，包括 setFullYear、setMonth、setDate、setHours、setMinutes、setSeconds、setMilliseconds、setTime、setUTCFullYear、setUTCMonth、setUTCDate、setUTCHours、setUTCMinutes、setUTCSeconds、setUTCMilliseconds。
// 因为Info类被@ObservedV2装饰且属性selectedDate被@Trace装饰，点击Button('set selectedDate to 2023-07-08')对selectedDate赋值也可以观测到变化。
///////////////////////////////////////////////////
@ObservedV2
class Info {
  @Trace selectedDate: Date = new Date('2021-08-08')
}
@ComponentV2
struct Example10Page {
  info: Info = new Info()
  build() {
    Column() {
      Button('set selectedDate to 2023-07-08')
        .margin(10)
        .onClick(() => {
          this.info.selectedDate = new Date('2023-07-08');
        })
      Button('increase the year by 1')
        .margin(10)
        .onClick(() => {
          this.info.selectedDate.setFullYear(this.info.selectedDate.getFullYear() + 1);
        })
      Button('increase the month by 1')
        .margin(10)
        .onClick(() => {
          this.info.selectedDate.setMonth(this.info.selectedDate.getMonth() + 1);
        })
      Button('increase the day by 1')
        .margin(10)
        .onClick(() => {
          this.info.selectedDate.setDate(this.info.selectedDate.getDate() + 1);
        })
      DatePicker({
        start: new Date('1970-1-1'),
        end: new Date('2100-1-1'),
        selected: this.info.selectedDate
      })
    }.width('100%')
  }
}


///////////////////////////////////////////////////
// @Trace装饰Set类型
// 被@Trace装饰的Set类型属性可以观测到调用API带来的变化，包括 add, clear, delete。
// 因为Info类被@ObservedV2装饰且属性memberSet被@Trace装饰，点击Button('init set')对memberSet赋值也可以观察变化。
///////////////////////////////////////////////////
@ObservedV2
class Info9 {
  @Trace memberSet: Set<number> = new Set([0, 1, 2, 3, 4]);
}
@ComponentV2
struct Example9Page {
  info: Info9 = new Info9();
  build() {
    Row() {
      Column() {
        ForEach(Array.from(this.info.memberSet.entries()), (item: [number, number]) => {
          Text(`${item[0]}`)
            .fontSize(30)
          Divider()
        })
        Button('init set')
          .onClick(() => {
            this.info.memberSet = new Set([0, 1, 2, 3, 4]);
          })
        Button('set new one')
          .onClick(() => {
            this.info.memberSet.add(5);
          })
        Button('clear')
          .onClick(() => {
            this.info.memberSet.clear();
          })
        Button('delete the first one')
          .onClick(() => {
            this.info.memberSet.delete(0);
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}



///////////////////////////////////////////////////
// @Trace装饰Map类型
// 被@Trace装饰的Map类型属性可以观测到调用API带来的变化，包括 set、clear、delete。
// 因为Info类被@ObservedV2装饰且属性memberMap被@Trace装饰，点击Button('init map')对memberMap赋值也可以观测到变化。
///////////////////////////////////////////////////
@ObservedV2
class Info8 {
  @Trace memberMap: Map<number, string> = new Map([[0, "a"], [1, "b"], [3, "c"]]);
}
@ComponentV2
struct Example8Page {
  info: Info8 = new Info8();
  build() {
    Row() {
      Column() {
        ForEach(Array.from(this.info.memberMap.entries()), (item: [number, string]) => {
          Text(`${item[0]}`)
            .fontSize(30)
          Text(`${item[1]}`)
            .fontSize(30)
          Divider()
        })
        Button('init map')
          .onClick(() => {
            this.info.memberMap = new Map([[0, "a"], [1, "b"], [3, "c"]]);
          })
        Button('set new one')
          .onClick(() => {
            this.info.memberMap.set(4, "d");
          })
        Button('clear')
          .onClick(() => {
            this.info.memberMap.clear();
          })
        Button('set the key: 0')
          .onClick(() => {
            this.info.memberMap.set(0, "aa");
          })
        Button('delete the first one')
          .onClick(() => {
            this.info.memberMap.delete(0);
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}



///////////////////////////////////////////////////
// @Trace装饰对象数组
// @Trace装饰对象数组personList以及Person类中的age属性，因此当personList、age改变时均可以观测到变化。
// 点击Text组件更改age时，Text组件会刷新。
///////////////////////////////////////////////////
@ObservedV2
class Person {
  @Trace age: number = 0;
  constructor(age: number) {
    this.age = age;
  }
}
@ObservedV2
class Info7 {
  id: number = 0;
  @Trace personList: Person[] = [];
  constructor() {
    this.id = nextId++;
    this.personList = [new Person(0), new Person(1), new Person(2)];
  }
}
@ComponentV2
struct Example7Page {
  info: Info7 = new Info7();
  build() {
    Column() {
      Text(`length: ${this.info.personList.length}`)
      Divider()
      if (this.info.personList.length >= 3) {
        Text(`${this.info.personList[0].age}`)
          .borderWidth(1)
          .fontSize(30)
          .onClick(() => {
            this.info.personList[0].age++;
          })
        Text(`${this.info.personList[1].age}`)
          .borderWidth(1)
          .fontSize(30)
          .onClick(() => {
            this.info.personList[1].age++;
          })
        Text(`${this.info.personList[2].age}`)
          .borderWidth(1)
          .fontSize(30)
          .onClick(() => {
            this.info.personList[2].age++;
          })
      }
      Divider()
      ForEach(this.info.personList, (item: Person, index: number) => {
        Text(`${index} ${item.age}`)
          .borderWidth(1)
          .fontSize(30)
      })
    }
  }
}

///////////////////////////////////////////////////
// @Trace装饰基础类型的数组
// @Trace装饰数组时，使用支持的API能够观测到变化。支持的API见观察变化。
// 在下面的示例中@ObservedV2装饰的Arr类中的属性numberArr是@Trace装饰的数组，当使用数组API操作numberArr时，可以观测到对应的变化。注意使用数组长度进行判断以防越界访问。
///////////////////////////////////////////////////
let nextId: number = 0;
@ObservedV2
class Arr {
  id: number = 0;
  @Trace numberArr: number[] = [];
  constructor() {
    this.id = nextId++;
    this.numberArr = [0, 1, 2];
  }
}
@ComponentV2
struct Example6Page {
  arr: Arr = new Arr();
  build() {
    Column() {
      Text(`length: ${this.arr.numberArr.length}`)
        .fontSize(40)
      Divider()
      Row() {
        Column() {
          Button('push')
            .onClick(() => {
              this.arr.numberArr.push(50);
            })
          Button('pop')
            .onClick(() => {
              this.arr.numberArr.pop();
            })
          Button('shift')
            .onClick(() => {
              this.arr.numberArr.shift();
            })
          Button('splice')
            .onClick(() => {
              this.arr.numberArr.splice(1, 0, 60);
            })
          Button('unshift')
            .onClick(() => {
              this.arr.numberArr.unshift(100);
            })
          Button('copywithin')
            .onClick(() => {
              this.arr.numberArr.copyWithin(0, 1, 2);
            })
          Button('fill')
            .onClick(() => {
              this.arr.numberArr.fill(0, 2, 4);
            })
          Button('reverse')
            .onClick(() => {
              this.arr.numberArr.reverse();
            })
          Button('sort')
            .onClick(() => {
              this.arr.numberArr.sort();
            })
        }
        Column() {
          Divider()
          if (this.arr.numberArr.length >= 3) {
            Text(`${this.arr.numberArr[0]}`)
              .fontSize(40)
              .onClick(() => {
                this.arr.numberArr[0]++;
              })
            Text(`${this.arr.numberArr[1]}`)
              .fontSize(40)
              .onClick(() => {
                this.arr.numberArr[1]++;
              })
            Text(`${this.arr.numberArr[2]}`)
              .fontSize(40)
              .onClick(() => {
                this.arr.numberArr[2]++;
              })
          }
          ForEach(this.arr.numberArr, (item: number, index: number) => {
            Text(`${index} ${item}`)
              .fontSize(30)
          })
        }
        .layoutWeight(1)
      }
    }
  }
}

///////////////////////////////////////////////////
// 继承类场景
// 创建类Son和类Cousin的实例，点击Button('change Son age')和Button('change Cousin age')可以触发UI的刷新。
///////////////////////////////////////////////////
@ObservedV2
class GrandFather {
  @Trace age: number = 0;
  constructor(age: number) {
    this.age = age;
  }
}
class Father extends GrandFather{
  constructor(father: number) {
    super(father);
  }
}
class Uncle extends GrandFather {
  constructor(uncle: number) {
    super(uncle);
  }
}
class Son extends Father {
  constructor(son: number) {
    super(son);
  }
}
class Cousin extends Uncle {
  constructor(cousin: number) {
    super(cousin);
  }
}
@ComponentV2
struct Example5Page {
  son: Son = new Son(0);
  cousin: Cousin = new Cousin(0);
  renderTimes: number = 0;
  isRender(id: number): number {
    console.info(`id: ${id} renderTimes: ${this.renderTimes}`);
    promptAction.showToast({ message: `id: ${id} renderTimes: ${this.renderTimes}` })
    this.renderTimes++;
    return 40;
  }
  build() {
    Row() {
      Column() {
        Text(`Son ${this.son.age}`)
          .fontSize(this.isRender(1))
          .fontWeight(FontWeight.Bold)
        Text(`Cousin ${this.cousin.age}`)
          .fontSize(this.isRender(2))
          .fontWeight(FontWeight.Bold)
        Button('change Son age')
          .onClick(() => {
            this.son.age++;
          })
        Button('change Cousin age')
          .onClick(() => {
            this.cousin.age++;
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}

///////////////////////////////////////////////////
// 嵌套类场景
// 点击Button("change length")，length是被@Trace装饰的属性，它的变化可以触发关联的UI组件，即UINode (1)的刷新，并输出"id: 1 renderTimes: x"的日志，其中x根据点击次数依次增长。
// 自定义组件Page中的son是常规变量，因此点击Button("assign Son")并不会观测到变化。
// 当点击Button("assign Son")后，再点击Button("change length")并不会引起UI刷新。因为此时son的地址改变，其关联的UI组件并没有关联到最新的son。
///////////////////////////////////////////////////
@ObservedV2
class Pencil4 {
  @Trace length: number = 21; // 当length变化时，会刷新关联的组件
}
class Bag4 {
  width: number = 50;
  height: number = 60;
  pencil: Pencil4 = new Pencil4();
}
class Son4 {
  age: number = 5;
  school: string = "some";
  bag: Bag4 = new Bag4();
}
@ComponentV2
struct Example4Page {
  son: Son4 = new Son4();
  renderTimes: number = 0;
  isRender(id: number): number {
    console.info(`id: ${id} renderTimes: ${this.renderTimes}`);
    this.renderTimes++;
    return 40;
  }
  build() {
    Column() {
      Text('pencil length'+ this.son.bag.pencil.length)
        .fontSize(this.isRender(1))   // UINode (1)
      Button("change length")
        .onClick(() => {
          // 点击更改length值，UINode（1）会刷新
          this.son.bag.pencil.length += 100;
        })
      Button("assign Son")
        .onClick(() => {
          // 由于变量son非状态变量，因此无法刷新UINode（1）
          this.son = new Son4();
        })
    }
  }
}




///////////////////////////////////////////////////
///@Trace装饰内置类型时，可以观测各自API导致的变化：////
///////////////////////////////////////////////////
// 类型	  |  可观测变化的API
// Array	|  push、pop、shift、unshift、splice、copyWithin、fill、reverse、sort
// Date	  |  setFullYear, setMonth, setDate, setHours, setMinutes, setSeconds, setMilliseconds, setTime, setUTCFullYear, setUTCMonth, setUTCDate, setUTCHours, setUTCMinutes, setUTCSeconds, setUTCMilliseconds
// Map	  |  set, clear, delete
// Set	  |  add, clear, delete

///////////////////////////////////////////////////
///类中使用@Trace装饰的静态属性具有被观测变化的能力。////
///////////////////////////////////////////////////
@ObservedV2
class Manager3 {
  @Trace static count: number = 1;
}
@ComponentV2
struct Example3Page {
  build() {
    Column() {
      // 当点击改变count时，Text组件会刷新
      Text(`${Manager3.count}`)
        .fontSize(40)
        .onClick(() => {
          Manager3.count++;
        })
    }
  }
}

///////////////////////////////////////////////////
///在继承类中使用@Trace装饰的属性具有被观测变化的能力。////
///////////////////////////////////////////////////
@ObservedV2
class Father2 {
  @Trace name: string = 'Tome'
}
class Son2 extends Father2 {
}
@ComponentV2
struct Example2Page {
  son: Son2 = new Son2();
  build() {
    Column() {
      // 当点击改变name时，Text组件会刷新
      Text(`${this.son.name}`)
        .onClick(() => {
          this.son.name = "Jack";
        })
    }
  }
}

////////////////////////////////////////////////////
//// 在嵌套类中使用@Trace装饰的属性具有被观测变化的能力。//
///////////////////////////////////////////////////
@ObservedV2
class Son1 {
  @Trace age: number = 10
}
class Father1 {
  son: Son1 = new Son1()
}
@ComponentV2
struct Example1Page {
  father: Father1 = new Father1();

  build() {
    // 当点击改变age时，Text组件会刷新
    Text(`${this.father.son.age}`)
      .fontSize(50)
      .onClick(() => {
        this.father.son.age++;
      })
  }
}