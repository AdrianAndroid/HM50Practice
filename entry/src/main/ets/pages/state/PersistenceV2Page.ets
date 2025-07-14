import { AppStorageV2, PersistenceV2, Type } from '@kit.ArkUI';
import Logger from '../../common/Logger';
import { FULL_PERCENT } from '../../model/ConstantsData';

@ObservedV2
class SampleChild {
  @Trace p1: number = 0
  p2: number = 10
}

@ObservedV2
class Sample {
  // 对于复杂对象需要@Type修饰，确保序列化成功
  @Type(SampleChild)
  @Trace f: SampleChild = new SampleChild()
}

PersistenceV2.notifyOnError((key: string, reason: string, msg: string) => {
  Logger.error(`PersistenceV2Page error key: ${key}, reason: ${reason}, message: ${msg}`);
})


/**
 * https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/arkts-new-persistencev2
 */
@Entry
@ComponentV2
struct PersistenceV2Page {
  // 在PersistenceV2中创建一个key为Sample的键值对（如果存在，则返回PersistenceV2中的数据），并且和prop关联
  // 对于需要换connect对象的prop属性，需要加@Local修饰（不建议对属性换connect的对象）
  @Local prop: Sample = PersistenceV2.connect(Sample, () => new Sample())!;
  pageStack: NavPathStack = new NavPathStack();

  @Builder
  pageMap(name: string, param: object) {
    Page2()
  }

  build() {
    Navigation(this.pageStack) {
      Column() {
        Blank().height(100)
        Button('Go to page2')
          .onClick(() => {
            this.pageStack.pushPathByName('Page2', null);
          })

        Button('Page1 connect the key Sample')
          .onClick(() => {
            // 在PersistenceV2中创建一个key为Sample的键值对（如果存在，则返回PersistenceV2中的数据），并且和prop关联
            // 不建议对prop属性换connect的对象
            this.prop = PersistenceV2.connect(Sample, 'Sample', () => new Sample())!;
          })

        Button('Page1 remove the key Sample')
          .onClick(() => {
            // 从PersistenceV2中删除后，prop将不会再与key为Sample的值关联
            PersistenceV2.remove(Sample);
          })

        Button('Page1 save the key Sample')
          .onClick(() => {
            // 如果处于connect状态，持久化key为Sample的键值对
            PersistenceV2.save(Sample);
          })

        Text(`Page1 add 1 to prop.p1: ${this.prop.f.p1}`)
          .fontSize(30)
          .onClick(() => {
            this.prop.f.p1++;
          })

        Text(`Page1 add 1 to prop.p2: ${this.prop.f.p2}`)
          .fontSize(30)
          .onClick(() => {
            // 页面不刷新，但是p2的值改变了
            this.prop.f.p2++;
          })

        // 获取当前PersistenceV2里面的所有key
        Text(`all keys in PersistenceV2: ${PersistenceV2.keys()}`)
          .fontSize(30)
      }
    }
    .navDestination(this.pageMap)
    .width(FULL_PERCENT)
    .height(FULL_PERCENT)
  }
}

@ComponentV2
struct Page2 {
  // 在PersistenceV2中创建一个key为Sample的键值对（如果存在，则返回PersistenceV2中的数据），并且和prop关联
  // 对于需要换connect对象的prop属性，需要加@Local修饰（不建议对属性换connect的对象）
  @Local prop: Sample = PersistenceV2.connect(Sample, () => new Sample())!;
  pathStack: NavPathStack = new NavPathStack();
  build() {
    NavDestination() {
      Column() {
        Button('Page2 connect the key Sample1')
          .onClick(() => {
            // 在PersistenceV2中创建一个key为Sample1的键值对（如果存在，则返回PersistenceV2中的数据），并且和prop关联
            // 不建议对prop属性换connect的对象
            this.prop = PersistenceV2.connect(Sample, 'Sample1', () => new Sample())!;
          })

        Text(`Page2 add 1 to prop.p1: ${this.prop.f.p1}`)
          .onClick(() => {
            this.prop.f.p1++;
          })

        Text(`Page2 add 1 to prop.p2: ${this.prop.f.p2}`)
          .borderWidth(1)
          .onClick(() => {
            // 页面不刷新，但是p2的值改变了；只有重新初始化才会改变
            this.prop.f.p2++;
          })

        // 获取当前PersistenceV2里面的所有key
        Text(`all keys in PersistenceV2: ${PersistenceV2.keys()}`)
          .borderWidth(1)
          .fontSize(30)
      }
    }
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack;
    })
  }
}