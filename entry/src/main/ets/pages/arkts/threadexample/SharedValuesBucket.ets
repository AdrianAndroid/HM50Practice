// SharedValuesBucket.ets
export interface IValueBucket {
  id: number
  name: string
  age: number
  salary: number
}


@Sendable
export class SharedValuesBucket implements IValueBucket {
  id: number = 0
  name: string = ""
  age: number = 0
  salary: number = 0


  constructor(v: IValueBucket) {
    this.id = v.id;
    this.name = v.name;
    this.age = v.age;
    this.salary = v.salary
  }
}