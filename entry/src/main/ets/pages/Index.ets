import { router, UIObserver, uiObserver } from '@kit.ArkUI'
import { BusinessError } from '@kit.BasicServicesKit'
import Constants from '../common/constants/Constants';

class MyData {
  str: string;
  constructor(str: string) {
    this.str = str;
  }
}

@Entry
@Component
struct Index {
  @State data1: MyData|undefined = new MyData("branch 0");
  @State data2: MyData|undefined = new MyData("branch 1");

  build() {
    Column() {
      if (this.data1) {
        // 如果在动画中增加/删除，会给Text增加默认转场
        // 对于删除时，增加默认透明度转场后，会延长组件的生命周期，Text组件没有真正删除，而是等转场动画做完后才删除
        Text(this.data1.str)
          .id("1")
      } else if (this.data2) {
        // 如果在动画中增加/删除，会给Text增加默认转场
        Text(this.data2.str)
          .id("2")
      }

      Button("play with animation")
        .onClick(() => {
          animateTo({}, ()=>{
            // 在animateTo中修改if条件，在动画当中，会给if下的第一层组件默认转场
            if (this.data1) {
              this.data1 = undefined;
              this.data2 = new MyData("branch 1");
            } else {
              this.data1 = new MyData("branch 0");
              this.data2 = undefined;
            }
          })
        })

      Button("play directlp")
        .onClick(() => {
          // 直接改if条件，不在动画当中，可以正常切换，也不会加默认转场
          if (this.data1) {
            this.data1 = undefined;
            this.data2 = new MyData("branch 1");
          } else {
            this.data1 = new MyData("branch 0");
            this.data2 = undefined;
          }
        })
    }.width("100%")
    .padding(10)
  }
}