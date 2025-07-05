import Logger from '../../common/Logger'

function factorial(n: number) : number {
  return n <= 0 ? 1 : (n * factorial(n - 1))
}

let func = (x: Object) => {
  if (typeof x == "number") {
    Logger.log(x + " 是一个数字")
  } else if (typeof x == "string") {
    Logger.log(x + " 是一个字符串")
  }
}

func(12)
func('Tome')

function disp(s1: string, s2?: string): void {}
// function disp(s1: string, s2: string) {}
disp('hello', 'hhh')


@Entry
@Component
struct TSExamplePage {
  @State message: string = 'Hello World';

  build() {
    Scroll() {
      Column() {
        Button('Number对象属性')
          .onClick(() => {
            Logger.log("TypeScript Number 属性: ");
            Logger.log("最大值为: " + Number.MAX_VALUE);
            Logger.log("最小值为: " + Number.MIN_VALUE);
            Logger.log("负无穷大: " + Number.NEGATIVE_INFINITY);
            Logger.log("正无穷大:" + Number.POSITIVE_INFINITY);
            Logger.log("toLocaleString:" + Number(1555).toLocaleString());
            Logger.log("toPrecision:" + Number(17.123456).toPrecision(2));
          })
        Button('Array')
          .onClick(() => {
            let sites1:string[];
            sites1 = ["Google","Runoob","Taobao"]
            Logger.log(sites1[0]);
            Logger.log(sites1[1]);

            let arr_names:number[] = new Array(4)
            for(let i = 0; i<arr_names.length; i++) {
              arr_names[i] = i * 2
              Logger.log(arr_names[i].toString())
            }

            let sites2:string[] = new Array("Google","Runoob","Taobao","Facebook")
            for(let i = 0;i<sites2.length;i++) {
              Logger.log(sites2[i])
            }

            let nums:number[] = [1001,1002,1003,1004]
            nums.forEach((value, index, array) => {
              Logger.log(value.toLocaleString());
            })

            let alpha = ["a", "b", "c"];
            let numeric = ['1', '2', '3'];
            let alphaNumeric = alpha.concat(numeric);
            Logger.log("alphaNumeric : " + alphaNumeric );    // a,b,c,1,2,3

            // isBigEnough(element, index, array) {
            //   return (element >= 10);
            // }

            let passed = [12, 5, 8, 130, 44].every((element, index, array) => {
              return element >= 10
            });
            Logger.log("Test Value : " + passed ); // false


            let numbers = [1, 4, 9];
            let roots = numbers.map(Math.sqrt);
            Logger.log("roots is : " + roots );  // 1,2,3

            let total = [0, 1, 2, 3].reduce((a, b) => {return a + b;});
            Logger.log("total is : " + total); // 6


            let arr1 = [10, 1, 2, 3].shift();
            Logger.log("Shifted value is : " + arr1 );  // 10

            let arr2 = ["orange", "mango", "banana", "sugar", "tea"];
            console.log("arr.slice( 1, 2) : " + arr2.slice( 1, 2) );  // mango
            console.log("arr.slice( 1, 3) : " + arr2.slice( 1, 3) );  // mango,banana

            let arr3 = ["orange", "mango", "banana", "sugar", "tea"];
            let removed = arr3.splice(2, 0, "water");
            console.log("After adding 1: " + arr3 );    // orange,mango,water,banana,sugar,tea
            console.log("removed is: " + removed);
            removed = arr3.splice(3, 1);
            console.log("After removing 1: " + arr3 );  // orange,mango,water,sugar,tea
            console.log("removed is: " + removed);  // banana

          })
        Button('Map')
          .onClick(() => {
            
          })
      }
    }
    .height('100%')
    .width('100%')
  }
}