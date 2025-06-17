import { UIUtils } from "@kit.ArkUI";

@Entry
@Component
struct StateV1Page {
  @State newData: NewDate = new NewDate(new DateClass('2023-1-1'));

  build() {
    Column() {
      Child({ label: 'date', data: this.newData.data })

      Button(`parent update the new date`)
        .onClick(() => {
          this.newData.data = new DateClass('2023-07-07');
        })
      Button(`ViewB: this.newData = new NewDate(new DateClass('2023-08-20'))`)
        .onClick(() => {
          this.newData = new NewDate(new DateClass('2023-08-20'));
        })
    }
  }
}

@Observed
class DateClass extends Date {
  constructor(args: number | string) {
    super(args);
  }
}

@Observed
class NewDate {
  public data: DateClass;

  constructor(data: DateClass) {
    this.data = data;
  }
}

@Component
struct Child {
  label: string = 'date';
  @ObjectLink data: DateClass;

  build() {
    Column() {
      Button(`child increase the day by 1`)
        .onClick(() => {
          this.data.setDate(this.data.getDate() + 1);
        })
      DatePicker({
        start: new Date('1970-1-1'),
        end: new Date('2100-1-1'),
        selected: this.data
      })
    }
  }
}