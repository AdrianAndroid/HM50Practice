import Constants from '../../common/Constants';

@Entry
@ComponentV2
struct StateV2Page {
  @Local numArr: number[] = [1,2,3,4,5];
  @Local dimensionTwo: number[][] = [[1,2,3],[4,5,6]];

  build() {
    Column() {
      Text(`${this.numArr[0]}`)
      Text(`${this.numArr[1]}`)
      Text(`${this.numArr[2]}`)
      Text(`${this.dimensionTwo[0][0]}`)
      Text(`${this.dimensionTwo[1][1]}`)
      Button("change array item")
        .onClick(() => {
          this.numArr[0]++;
          this.numArr[1] += 2;
          this.dimensionTwo[0][0] = 0;
          this.dimensionTwo[1][1] = 0;
        })
      Button("change whole array")
        .onClick(() => {
          this.numArr = [5,4,3,2,1];
          this.dimensionTwo = [[7,8,9],[0,1,2]];
        })
    }
  }
}