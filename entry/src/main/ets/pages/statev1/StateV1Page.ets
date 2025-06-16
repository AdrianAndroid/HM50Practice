@Entry
@Component
struct StateV1Page {
  @State info: Info = new Info('上海');
  @State user: User = new User();

  aboutToAppear(): void {
    this.user.info = this.info;
  }

  build() {
    Column() {
      Blank()
        .height(300)
      Text(`${this.info.address}`);
      Text(`${this.user.info.address}`);
      Button('change')
        .onClick(() => {
          this.user.info.address = '北京';
        })
    }
  }
}

class Info {
  address: string = '杭州';

  constructor(address: string) {
    this.address = address;
  }
}

class User {
  info: Info = new Info('天津');
}
