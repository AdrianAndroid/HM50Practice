import { UIUtils } from "@kit.ArkUI";

@Entry
@Component
struct StateV1Page {
  @Provide("reviewVotes") reviewVotes: number = 40;

  build() {
    Column() {
      Blank()
        .height(100)
      Button(`reviewVotes(${this.reviewVotes}), give +1`)
        .onClick(() => this.reviewVotes += 1)
      Parent()
    }
  }
}


@Component
struct GrandSon {
  // @Consume装饰的变量通过相同的属性名绑定其祖先内的@Provide装饰的变量
  @Consume("reviewVotes") reviewVotes: number;

  build() {
    Column() {
      Text(`reviewVotes(${this.reviewVotes})`) // Text显示10
      Button(`reviewVotes(${this.reviewVotes}), give +1`)
        .onClick(() => this.reviewVotes += 1)
    }
    .width('50%')
  }
}

@Component
struct Child {
  @Provide({ allowOverride: "reviewVotes" }) reviewVotes: number = 10;

  build() {
    Row({ space: 5 }) {
      GrandSon()
    }
  }
}

@Component
struct Parent {
  @Provide({ allowOverride: "reviewVotes" }) reviewVotes: number = 20;

  build() {
    Child()
  }
}