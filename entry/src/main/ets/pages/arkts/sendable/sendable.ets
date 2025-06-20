// sendable.ets
// 将数据量较大的数据在Sendable class中组装
@Sendable
export class testTypeA {
  name: string = "A";
  constructor(name: string) {
    this.name = name;
  }
}


@Sendable
export class testTypeB {
  name: string = "B";
  constructor(name: string) {
    this.name = name;
  }
}


@Sendable
export class Test {
  data1: testTypeA;
  data2: testTypeB;
  constructor(arg1: testTypeA, arg2: testTypeB) {
    this.data1 = arg1;
    this.data2 = arg2;
  }
}