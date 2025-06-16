@Entry
@Component
struct StateV1Page {
  list: DataObj[] = [new DataObj('a'), new DataObj('b'), new DataObj('c')];
  @State dataObjFromList: DataObj = this.list[0];

  build() {
    Column() {
      Blank()
        .height(300)
      ConsumerChild({ dataObj: this.dataObjFromList })
      Button('change to self').onClick(() => {
        this.dataObjFromList = this.list[0];
      })
    }
  }
}

@Component
struct ConsumerChild {
  @Link @Watch('onDataObjChange') dataObj: DataObj;

  onDataObjChange() {
    console.log("dataObj changed");
  }

  build() {
    Column() {
      Text(this.dataObj.name).fontSize(30)
    }
  }
}

class DataObj {
  name: string = 'default name';

  constructor(name: string) {
    this.name = name;
  }
}
