@Entry
@ComponentV2
struct StateV2Page {
  @Local firstName: string = 'Li';
  @Local lastName: string = 'Hua';
  age: number = 20; // 无法触发Computed

  @Computed
  get fullName() {
    console.info("---------Computed----------");
    return this.firstName + ' ' + this.lastName + this.age;
  }

  build() {
    Column() {
      Blank()
        .height(100)
      Text(this.lastName + ' ' + this.firstName)
      Text(this.lastName + ' ' + this.firstName)
      Divider()
      Text(this.fullName)
      Text(this.fullName)
      Button('changed lastName').onClick(() => {
        this.lastName += 'a';
      })

      Button('changed age').onClick(() => {
        this.age++;  // 无法触发Computed
      })
    }
  }
}