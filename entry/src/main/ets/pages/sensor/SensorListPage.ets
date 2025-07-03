@Entry
@Component
struct SensorListPage {
  @StorageProp('bottomRectHeight')
  bottomRectHeight: number = 0;
  @StorageProp('topRectHeight')
  topRectHeight: number = 0;

  build() {
    Scroll() {
      Column() {

      }
    }
    .height('100%')
    .width('100%')
  }
}