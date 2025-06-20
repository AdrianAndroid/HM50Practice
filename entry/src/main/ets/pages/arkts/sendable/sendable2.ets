// sendable.ets
// 定义模拟类Test，模仿开发过程中需传递带方法的class
import { lang, collections } from '@kit.ArkTS'


export type ISendable = lang.ISendable;


@Sendable
export class SendableTestClass {
  name: string = 'John';
  age: number = 20;
  sex: string = "man";
  arr: collections.Array<number> = new collections.Array<number>(1, 2, 3);
  constructor() {
  }
  setAge(age: number) : void {
    this.age = age;
  }


  printName(): string {
    return this.name;
  }


  printAge(): number {
    return this.age;
  }


  printSex(): string {
    return this.sex;
  }
}