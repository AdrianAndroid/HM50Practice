@Entry
@Component
struct FlexExamplePage {
  @State message: string = 'Hello World';

  build() {
    Stack() {
      this.flexExample9()
      // this.flexExample1()
    }
    .height('100%')
    .width('100%')
  }


  @Builder
  flexExample9() {
    Flex({ direction: FlexDirection.Row }) {
      Text('flexShrink(3)')
        .flexShrink(1)
        .width(200)
        .height(100)
        .backgroundColor(0xF5DEB3)

      Text('no flexShrink')
        .width(200)
        .height(100)
        .backgroundColor(0xD2B48C)


      Text('flexShrink(2)')
        .flexShrink(1)
        .width(200)
        .height(100)
        .backgroundColor(0xF5DEB3)
    }.width(400).height(120).padding(10).backgroundColor(0xAFEEEE)
  }

  @Builder
  flexExample8() {
    Flex() {
      Text('flexGrow(2)')
        .flexGrow(2)
        .width(100)
        .height(100)
        .backgroundColor(0xF5DEB3)
      Text('flexGrow(3)')
        .flexGrow(3)
        .width(100)
        .height(100)
        .backgroundColor(0xD2B48C)


      Text('no flexGrow')
        .width(100)
        .height(100)
        .backgroundColor(0xF5DEB3)
    }.width(420).height(120).padding(10).backgroundColor(0xAFEEEE)
  }

  @Builder
  flexExample7() {
    Flex() {
      Text('flexBasis("auto")')
        .flexBasis('auto') // 未设置width以及flexBasis值为auto，内容自身宽度
        .height(100)
        .backgroundColor(0xF5DEB3)
      Text('flexBasis("auto")'+' width("40%")')
        .width('40%')
        .flexBasis('auto') //设置width以及flexBasis值auto，使用width的值
        .height(100)
        .backgroundColor(0xD2B48C)


      Text('flexBasis(100)')  // 未设置width以及flexBasis值为100，宽度为100vp
        .flexBasis(50)
        .height(100)
        .backgroundColor(0xF5DEB3)


      Text('flexBasis(100)')
        .flexBasis(50)
        .width(200) // flexBasis值为100，覆盖width的设置值，宽度为100vp
        .height(100)
        .backgroundColor(0xD2B48C)
    }.width('90%').height(120).padding(10).backgroundColor(0xAFEEEE)
  }

  @Builder
  flexExample6() {
    Flex({ justifyContent: FlexAlign.SpaceBetween, wrap: FlexWrap.Wrap, alignContent: FlexAlign.Center }) {
      Text('1').width('30%').height(20).backgroundColor(0xF5DEB3)
      Text('2').width('60%').height(20).backgroundColor(0xD2B48C)
      Text('3').width('40%').height(20).backgroundColor(0xD2B48C)
      Text('4').width('30%').height(20).backgroundColor(0xF5DEB3)
      Text('5').width('20%').height(20).backgroundColor(0xD2B48C)
    }
    .width('90%')
    .height(100)
    .backgroundColor(0xAFEEEE)
  }
  @Builder
  flexExample5() {
    Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center }) { // 容器组件设置子元素居中
      Text('alignSelf Start').width('25%').height(80)
        .alignSelf(ItemAlign.Start)
        .backgroundColor(0xF5DEB3)
      Text('alignSelf Baseline')
        .alignSelf(ItemAlign.Baseline)
        .width('25%')
        .height(80)
        .backgroundColor(0xD2B48C)
      Text('alignSelf Baseline').width('25%').height(100)
        .backgroundColor(0xF5DEB3)
        .alignSelf(ItemAlign.Baseline)
      Text('no alignSelf').width('25%').height(100)
        .backgroundColor(0xD2B48C)
      Text('no alignSelf').width('25%').height(100)
        .backgroundColor(0xF5DEB3)


    }.width('90%').height(220).backgroundColor(0xAFEEEE)
  }

  @Builder
  flexExample4() {
    Flex({ alignItems: ItemAlign.Baseline }) {
      Text('1').width('33%').height(30).backgroundColor(0xF5DEB3)
      Text('2').width('33%').height(40).backgroundColor(0xD2B48C)
      Text('3').width('33%').height(50).backgroundColor(0xF5DEB3)
    }
    .size({ width: '90%', height: 80 })
    .padding(10)
    .backgroundColor(0xAFEEEE)
  }

  @Builder
  flexExample3() {
    Flex({ justifyContent: FlexAlign.Center }) {
      Text('1').width('20%').height(50).backgroundColor(0xF5DEB3)
      Text('2').width('20%').height(50).backgroundColor(0xD2B48C)
      Text('3').width('20%').height(50).backgroundColor(0xF5DEB3)
    }
    .width('90%')
    .padding({ top: 10, bottom: 10 })
    .backgroundColor(0xAFEEEE)
  }

  @Builder
  flexExample2() {
    Flex({ wrap: FlexWrap.WrapReverse }) {
      Text('1').width('50%').height(50).backgroundColor(0xF5DEB3)
      Text('2').width('50%').height(50).backgroundColor(0xD2B48C)
      Text('3').width('50%').height(50).backgroundColor(0xF5DEB3)
    }
    .width('90%')
    .padding(10)
    .backgroundColor(0xAFEEEE)
  }
  @Builder
  flexExample1() {
    Flex({ direction: FlexDirection.Row }) {
      Text('1').width('20%').height(50).backgroundColor(0xF5DEB3)
      Text('2').width('20%').height(50).backgroundColor(0xD2B48C)
      Text('3').width('20%').height(50).backgroundColor(0xF5DEB3)
    }
    .height(170)
    .width('90%')
    .padding(10)
    .backgroundColor(0xAFEEEE)
  }
}