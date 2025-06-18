import { AppStorageV2 } from '@kit.ArkUI';
import Constants from '../../common/Constants';
import { Sample2 } from './Sample2';

@Entry
@ComponentV2
struct StateV2Page {
  @Local prop: Sample2 = AppStorageV2.connect(Sample2, 'xxx', () => new Sample2())!
  pageStack: NavPathStack = new NavPathStack();

  build() {
    Navigation(this.pageStack) {
      Column() {
        Blank()
          .height(100)
        Button('Go to page2')
          .onClick(() => {
            this.pageStack.pushPathByName(Constants.PAGES_statev2_StateV2Page2, null);
          })

        Button('Page1 connect the key Sample')
          .onClick(() => {
            // 在AppStorageV2中创建一个key为Sample的键值对（如果存在，则返回AppStorageV2中的数据），并且和prop关联
            this.prop = AppStorageV2.connect(Sample2, 'Sample', () => new Sample2())!;
          })

        Button('Page1 remove the key Sample')
          .onClick(() => {
            // 从AppStorageV2中删除后，prop将不会再与key为Sample的值关联
            AppStorageV2.remove(Sample2);
          })

        Text(`Page1 add 1 to prop.p1: ${this.prop.p1}`)
          .fontSize(30)
          .onClick(() => {
            this.prop.p1++;
          })

        Text(`Page1 add 1 to prop.p2: ${this.prop.p2}`)
          .fontSize(30)
          .onClick(() => {
            // 页面不刷新，但是p2的值改变了
            this.prop.p2++;
          })

        // 获取当前AppStorageV2里面的所有key
        Text(`all keys in AppStorage: ${AppStorageV2.keys()}`)
          .fontSize(30)
      }
    }
  }
}