import Constants from '../../common/Constants';

let localStorage1: LocalStorage = new LocalStorage();
localStorage1.setOrCreate('PropA', 'PropA');

let localStorage2: LocalStorage = new LocalStorage();
localStorage2.setOrCreate('PropB', 'PropB');

@Entry({ storage: localStorage1 })
@Component
struct StateV1Page {
  @LocalStorageLink('PropA') PropA: string = 'Hello World';
  @State count: number = 0

  build() {
    Row() {
      Column() {
        Text(this.PropA)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        Button('Click Parent')
          .onClick(() => {
            this.PropA = 'Parent'
          })
        Child({count: this.count}, localStorage2)
        Child2({}, localStorage2)
      }
      .width(Constants.FULL_PERCENT)
    }
    .height(Constants.FULL_PERCENT)
  }
}

@Component
struct Child {
  @Link count: number
  @LocalStorageLink('PropB') PropB: string = 'Hello World';
  build() {
    Column() {
      Text(this.PropB)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)

      Button('Child Click')
        .onClick(() => {
          this.PropB = 'Child'
        })
    }
  }
}

@Component
struct Child2 {
  @State count: number = 2
  @LocalStorageLink('PropB') PropB: string = 'Hello World';
  build() {
    Column() {
      Text(this.PropB)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)

      Button('Child Click')
        .onClick(() => {
          this.PropB = 'Child'
        })
    }
  }
}