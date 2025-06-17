Environment.envProp('languageCode', 'zh');

@Entry()
@Component
struct StateV1Page {
  @StorageProp('languageCode') languageCode: string = 'en';

  build() {
    Row() {
      Column() {
        Blank().height(100)
        // 输出当前设备的languageCode
        Text(this.languageCode)
      }
    }
  }
}