import Constants from '../../common/Constants';

@Entry
@ComponentV2
struct StateV2Page {
  @Local count: number = 0;
  @Local message: string = "Hello";
  @Local flag: boolean = false;
  build() {
    Column() {
      Text(`Local ${this.count}`)
      Text(`Local ${this.message}`)
      Text(`Local ${this.flag}`)
      Button("change Local")
        .onClick(()=>{
          // 对数据源的更改会同步给子组件
          this.count++;
          this.message += " World";
          this.flag = !this.flag;
        })
      Child({
        count: this.count,
        message: this.message,
        flag: this.flag
      })
    }
  }
}
@ComponentV2
struct Child {
  @Require @Param count: number;
  @Require @Param message: string;
  @Require @Param flag: boolean;
  build() {
    Column() {
      Text(`Param ${this.count}`)
      Text(`Param ${this.message}`)
      Text(`Param ${this.flag}`)
    }
  }
}