@Entry
@Component
struct RecordPage {
  @State message: string = 'Hello World';

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('RecordPageHelloWorld')
        .fontSize($r('app.float.page_text_font_size'))
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(() => {
          this.message = 'Welcome';
        })
    }
    .height('100%')
    .width('100%')
  }

  example() {
    let res: Record<string, string> = { 'item1': '1', 'item2': '2' };
    let myMap: Map<string, string> = recordToMap(res);
    myMap.set('item3', '3');
    myMap.delete('item1');
    let myRecord = mapToRecord(myMap)
  }
}

export function mapToRecord(myMap: Map<string, string>): Record<string, string> {
  let record: Record<string, string> = {};
  myMap.forEach((value, key) => record[key] = value);
  return record;
}

export function recordToMap(myRecord: Record<string, string>): Map<string, string> {
  return myRecord ? new Map(Object.entries(myRecord)) : new Map();
}