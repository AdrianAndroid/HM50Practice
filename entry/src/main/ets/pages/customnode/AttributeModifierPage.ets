export class MyButtonModifier1 implements AttributeModifier<ButtonAttribute> {
  // 可以实现一个Modifier，定义私有的成员变量，外部可动态修改
  isDark: boolean = false

  // 通过构造函数，创建时传参
  constructor(dark?: boolean) {
    this.isDark = dark ? dark : false
  }

  applyNormalAttribute(instance: ButtonAttribute): void {
    // instance为Button的属性对象，可以通过instance对象对属性进行修改
    if (this.isDark) { // 支持业务逻辑的编写
      // 属性变化触发apply函数时，变化前已设置并且变化后未设置的属性会恢复为默认值
      instance.backgroundColor('#707070')
    } else {
      // 支持属性的链式调用
      instance.backgroundColor('#17A98D')
        .borderColor('#707070')
        .borderWidth(2)
    }
  }
}

export class MyButtonModifier2 implements AttributeModifier<ButtonAttribute> {
  // 可以实现一个Modifier，定义私有的成员变量，外部可动态修改
  isDark: boolean = false

  // 通过构造函数，创建时传参
  constructor(dark?: boolean) {
    this.isDark = dark ? dark : false
  }

  applyNormalAttribute(instance: ButtonAttribute): void {
    // instance为Button的属性对象，可以通过instance对象对属性进行修改
    if (this.isDark) { // 支持业务逻辑的编写
      // 属性变化触发apply函数时，变化前已设置并且变化后未设置的属性会恢复为默认值
      instance.backgroundColor('#707070')
    } else {
      // 支持属性的链式调用
      instance.backgroundColor('#17A98D')
        .borderColor('#707070')
        .borderWidth(2)
    }
  }
}

export class MyButtonModifier3 implements AttributeModifier<ButtonAttribute> {
  isDark: boolean = false

  constructor(dark?: boolean) {
    this.isDark = dark ? dark : false
  }

  applyNormalAttribute(instance: ButtonAttribute): void {
    if (this.isDark) {
      instance.backgroundColor(Color.Black)
        .width(200)
    } else {
      instance.backgroundColor(Color.Red)
        .width(100)
    }
  }
}

export class MyButtonModifier4 implements AttributeModifier<ButtonAttribute> {
  isDark2: boolean = false

  constructor(dark?: boolean) {
    this.isDark2 = dark ? dark : false
  }

  applyNormalAttribute(instance: ButtonAttribute): void {
    if (this.isDark2) {
      instance.backgroundColor('#2787D9')
    } else {
      instance.backgroundColor('#707070')
    }
  }
}

export class MyButtonModifier5 implements AttributeModifier<ButtonAttribute> {
  applyNormalAttribute(instance: ButtonAttribute): void {
    // instance为Button的属性对象，设置正常状态下属性值
    instance.backgroundColor('#17A98D')
      .borderColor('#707070')
      .borderWidth(2)
  }

  applyPressedAttribute(instance: ButtonAttribute): void {
    // instance为Button的属性对象，设置按压状态下属性值
    instance.backgroundColor('#2787D9')
      .borderColor('#FFC000')
      .borderWidth(5)
  }
}

@Entry
@Component
struct AttributeModifierPage {
  // 支持用状态装饰器修饰，行为和普通的对象一致
  @State modifier1: MyButtonModifier1 = new MyButtonModifier1(true);
  @State modifier2: MyButtonModifier2 = new MyButtonModifier2(true);
  @State modifier3: MyButtonModifier3 = new MyButtonModifier3(true);
  @State modifier4: MyButtonModifier4 = new MyButtonModifier4(true);
  @State modifier5: MyButtonModifier5 = new MyButtonModifier5();
  build() {
    Row() {
      Column() {
        Button("Button")
          .attributeModifier(this.modifier1)
          .onClick(() => {
            // 对象的一层属性被修改时，会触发UI刷新，重新执行applyNormalAttribute
            this.modifier1.isDark = !this.modifier1.isDark
          })
        // 先设置属性，后设置modifier，按钮颜色会跟随modifier的值改变
        Button("Button")
          .backgroundColor('#2787D9')
          .attributeModifier(this.modifier2)
          .onClick(() => {
            this.modifier2.isDark = !this.modifier2.isDark
          })
        Text('设置和修改组件属性')
        Button("Button")
          .attributeModifier(this.modifier3)
          .attributeModifier(this.modifier4)
          .onClick(() => {
            this.modifier3.isDark = !this.modifier3.isDark
            this.modifier4.isDark2 = !this.modifier4.isDark2
          })
        Text('设置多态样式、事件')
        Button("Button")
          .attributeModifier(this.modifier5)
      }
      .width('100%')
    }
    .height('100%')
  }
}

