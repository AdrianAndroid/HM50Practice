import { AppStorageV2 } from '@kit.ArkUI';
import { Sample2 } from './Sample2';

@Builder
export function Page2Builder() {
  StateV2Page2()
}


@Entry
@ComponentV2
struct StateV2Page2 {
  // 在AppStorageV2中创建一个key为Sample的键值对（如果存在，则返回AppStorageV2中的数据），并且和prop关联
  @Local prop: Sample2 = AppStorageV2.connect(Sample2, 'xxx', () => new Sample2())!;
  pathStack: NavPathStack = new NavPathStack();

  build() {
    NavDestination() {
      Column() {
        Blank()
          .height(100)
        Button('Page2 connect the key Sample1')
          .onClick(() => {
            // 在AppStorageV2中创建一个key为Sample1的键值对（如果存在，则返回AppStorageV2中的数据），并且和prop关联
            this.prop = AppStorageV2.connect(Sample2, 'Sample1', () => new Sample2())!;
          })

        Text(`Page2 add 1 to prop.p1: ${this.prop.p1}`)
          .fontSize(30)
          .onClick(() => {
            this.prop.p1++;
          })

        Text(`Page2 add 1 to prop.p2: ${this.prop.p2}`)
          .fontSize(30)
          .onClick(() => {
            // 页面不刷新，但是p2的值改变了；只有重新初始化才会改变
            this.prop.p2++;
          })

        // 获取当前AppStorageV2里面的所有key
        Text(`all keys in AppStorage: ${AppStorageV2.keys()}`)
          .fontSize(30)
      }
    }
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack;
    })
  }
}