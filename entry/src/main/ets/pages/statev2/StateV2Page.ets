@Entry
@ComponentV2
struct StateV2Page {
  @Local title: string = "Title One";
  @Local fontColor: Color = Color.Red;

  build() {
    Column() {
      Child({
        title: this.title,
        fontColor: this.fontColor,
        changeFactory: (type: number) => {
          if (type == 1) {
            this.title = "Title One";
            this.fontColor = Color.Red;
          } else if (type == 2) {
            this.title = "Title Two";
            this.fontColor = Color.Green;
          }
        },
        changeFactory2: (type: number) => {
          return ""
        }
      })
    }
  }
}

@ComponentV2
struct Child {
  @Param title: string = '';
  @Param fontColor: Color = Color.Black;
  @Event changeFactory: (x: number) => void = (x: number) => {};
  @Event changeFactory2: (x: number) => string = (x: number) => { return '' };

  build() {
    Column() {
      Text(`${this.title}`)
        .fontColor(this.fontColor)
      Button("change to Title Two")
        .onClick(() => {
          this.changeFactory(2);
        })
      Button("change to Title One")
        .onClick(() => {
          this.changeFactory(1);
        })
    }
  }
}