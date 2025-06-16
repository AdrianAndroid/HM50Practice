import { UIUtils } from "@kit.ArkUI";

@Entry
@Component
struct StateV1Page {
  list: DataObj[] = [new DataObj('a'), new DataObj('b'), new DataObj('c')];
  @State dataObjFromList: DataObj = this.list[0];

  build() {
    Column() {
      ConsumerChild({ dataObj: this.dataObjFromList })
      Button('change to self').onClick(() => {
        // 获取原始对象来和新值做对比
        if (UIUtils.getTarget(this.dataObjFromList) !== this.list[0]) {
          this.dataObjFromList = this.list[0];
        }
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
