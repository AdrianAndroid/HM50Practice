import { AttributeUpdater } from '@ohos.arkui.modifier'

class MyButtonModifier extends AttributeUpdater<ButtonAttribute> {
  // 首次绑定时触发initializeModifier方法，进行属性初始化
  initializeModifier(instance: ButtonAttribute): void {
    instance.backgroundColor('#2787D9')
      .width('50%')
      .height(30)
  }
}

class MyTextModifier extends AttributeUpdater<TextAttribute, TextInterface> {
  initializeModifier(instance: TextAttribute): void {
  }
}


@Entry
@Component
struct AttributeUpdaterPage {
  @State message: string = 'Hello World';
  modifier: MyButtonModifier = new MyButtonModifier()
  modifier2: MyTextModifier = new MyTextModifier()

  build() {
    Row() {
      Column() {
        Text('通过modifier直接修改属性')
        Button("Button")
          .attributeModifier(this.modifier)
          .onClick(() => {
            // 通过attribute，直接修改组件属性，并立即触发组件属性更新
            this.modifier.attribute?.backgroundColor('#17A98D').width('30%')
          })

        Text('通过modifier更新组件的构造参数')
        Text("Text")
          .attributeModifier(this.modifier2)
          .fontColor(Color.White)
          .fontSize(14)
          .border({ width: 1 })
          .textAlign(TextAlign.Center)
          .lineHeight(20)
          .width(200)
          .height(50)
          .backgroundColor('#2787D9')
          .onClick(() => {
            // 调用updateConstructorParams方法，直接更新组件的构造参数
            this.modifier2.updateConstructorParams('Update');
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}

