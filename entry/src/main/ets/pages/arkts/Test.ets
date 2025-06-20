// Test.ets
export function testAdd(arg: number) {
  return ++arg;
}


@Sendable
export class MyTestA {
  constructor(name: string) {
    this.name = name;
  }
  name: string = 'MyTestA';
}


export class MyTestB {
  static nameStr:string = 'MyTestB';
}