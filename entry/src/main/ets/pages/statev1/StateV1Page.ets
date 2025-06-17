import { UIUtils } from "@kit.ArkUI";

@Entry
@Component
struct StateV1Page {
  // @Provide装饰的联合类型count由入口组件Ancestors提供其后代组件
  @Provide count: string | undefined = 'Child';

  build() {
    Column() {
      Button(`count(${this.count}), Child`)
        .onClick(() => this.count = undefined)
      Parent()
    }
  }
}


@Component
struct Child {
  // @Consume装饰的变量通过相同的属性名绑定其祖先组件Ancestors内的@Provide装饰的变量
  @Consume count: string | undefined;

  build() {
    Column() {
      Text(`count(${this.count})`)
      Button(`count(${this.count}), Child`)
        .onClick(() => this.count = 'Ancestors')
    }
    .width('50%')
  }
}

@Component
struct Parent {
  build() {
    Row({ space: 5 }) {
      Child()
    }
  }
}