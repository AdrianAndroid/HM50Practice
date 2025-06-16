@Entry
@Component
struct StateV1Page {
  @State message: string = '上海';
  @State info: Info = new Info();

  aboutToAppear(): void {
    this.info.address = this.message;
  }

  build() {
    Column() {
      Blank()
        .height(300)
      Text(`${this.message}`);
      Text(`${this.info.address}`);
      Button('change')
        .onClick(() => {
          this.info.address = '北京';
        })
    }
  }
}

class Info {
  address: string = '杭州';
}
