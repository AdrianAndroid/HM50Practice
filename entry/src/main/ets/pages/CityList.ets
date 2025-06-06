import Constants from '../common/constants/Constants'

@Entry
@Component
struct CityList {
  build() {
    List() {
      ListItem() {
        Text('北京').fontSize(24)
      }
      ListItem() {
        Text('杭州').fontSize(24)
      }
      ListItem() {
        Text('上海').fontSize(24)
      }
      ListItem() {
        Row() {
          Image($r('app.media.icon'))
            .width(20)
            .height(20)
            .margin(10)

          Text('小明')
            .fontSize(20)
        }
      }

      ListItem() {
        Row() {
          Image($r('app.media.icon'))
            .width(20)
            .height(20)
            .margin(10)

          Text('小红')
            .fontSize(20)
        }
      }
    }
    .width(Constants.FULL_WIDTH)
    .height(Constants.FULL_HEIGHT)
    .backgroundColor('#FFF1F3F5')
    .alignListItem(ListItemAlign.Center)
  }
}