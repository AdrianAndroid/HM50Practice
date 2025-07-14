import { AppStorageV2 } from '@kit.ArkUI';
import Logger from '../../common/Logger';

@ObservedV2
class Sample {
  @Trace p1: number = 0
  p2: number = 10
  constructor() {
    Logger.info('Sample constructor create')
  }
}

/**
 * https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/arkts-new-appstoragev2
 */
@Entry
@ComponentV2
struct AppStorageV2Page {
  // 在AppStorageV2中创建一个key为Sample的键值对（如果存在，则返回AppStorageV2中的数据），并且和prop关联
  @Local prop: Sample = AppStorageV2.connect(Sample, () => new Sample())!;
  pageStack: NavPathStack = new NavPathStack();
  @Local allKeys: string = ''

  @Builder
  pageMap(name: string, param: Map<string, object>) {
    Page2()
  }

  test (){
  }

  build() {
    Navigation(this.pageStack) {
      Stack() {
        Column({space: 5}) {
          Blank().height(50)
          Button('Go to page2')
            .onClick(() => {
              this.pageStack.pushPathByName('Page2', null);
            })

          Button('Page1 connect the key Sample')
            .onClick(() => {
              // 在AppStorageV2中创建一个key为Sample的键值对（如果存在，则返回AppStorageV2中的数据），并且和prop关联
              this.prop = AppStorageV2.connect(Sample, 'Sample', () => new Sample())!;
            })

          Button('Page1 remove the key Sample')
            .onClick(() => {
              // 从AppStorageV2中删除后，prop将不会再与key为Sample的值关联
              AppStorageV2.remove(Sample);
            })

          Text(`Page1 add 1 to prop.p1: ${this.prop.p1}`)
            .fontSize(30)
            .onClick(() => {
              this.prop.p1++;
            })

          Text(`Page1 add 1 to prop.p2: ${this.prop.p2}`)
            .borderWidth(2)
            .onClick(() => {
              // 页面不刷新，但是p2的值改变了
              this.prop.p2++;
            })

          // 获取当前AppStorageV2里面的所有key
          Text(`all keys in AppStorage: ${this.allKeys}`)
            .borderWidth(2)
            .onClick(() => {
              this.allKeys = AppStorageV2.keys().toString()
            })
        }
      }
    }
    .navDestination(this.pageMap)
    .height('100%')
    .width('100%')
  }
}

@ComponentV2
struct Page2 {
  // 在AppStorageV2中创建一个key为Sample的键值对（如果存在，则返回AppStorageV2中的数据），并且和prop关联
  @Local prop: Sample = AppStorageV2.connect(Sample, () => new Sample())!;
  pathStack: NavPathStack = new NavPathStack();

  build() {
    NavDestination() {
      Stack() {
        Column({space: 5}) {
          Blank().height(50)
          Button('Page2 connect the key Sample1')
            .onClick(() => {
              // 在AppStorageV2中创建一个key为Sample1的键值对（如果存在，则返回AppStorageV2中的数据），并且和prop关联
              this.prop = AppStorageV2.connect(Sample, 'Sample1', () => new Sample())!;
            })

          Text(`Page2 add 1 to prop.p1: ${this.prop.p1}`)
            .borderWidth(2)
            .onClick(() => {
              this.prop.p1++;
            })

          Text(`Page2 add 1 to prop.p2: ${this.prop.p2}`)
            .borderWidth(2)
            .onClick(() => {
              // 页面不刷新，但是p2的值改变了；只有重新初始化才会改变
              this.prop.p2++;
            })

          // 获取当前AppStorageV2里面的所有key
          Text(`all keys in AppStorage: ${AppStorageV2.keys()}`)
            .borderWidth(2)
        }
      }
    }
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack;
    })
  }
}