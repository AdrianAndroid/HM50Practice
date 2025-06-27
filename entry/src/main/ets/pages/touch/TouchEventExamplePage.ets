@Entry
@Component
struct TouchEventExamplePage {
  @State message: string = 'Hello World';
  @State flag: boolean = true;
  @State btnMsg: string = 'show';

  @State text: string = '';
  @State eventType: string = '';

  build() {
    Column() {
      Button(this.btnMsg).width(80).height(30).margin(30)
        .onClick(() => {
          if (this.flag) {
            this.btnMsg = 'hide';
          } else {
            this.btnMsg = 'show';
          }
          // 点击Button控制Image的显示和消失
          this.flag = !this.flag;
        })
      if (this.flag) {
        Image($r('app.media.icon')).width(200).height(200)
      }

      Button('Touch').height(40).width(100)
        .onTouch((event?: TouchEvent) => {
          if(event){
            if (event.type === TouchType.Down) {
              this.eventType = 'Down';
            }
            if (event.type === TouchType.Up) {
              this.eventType = 'Up';
            }
            if (event.type === TouchType.Move) {
              this.eventType = 'Move';
            }
            if (event.type === TouchType.Cancel) {
              this.eventType = 'Cancel';
            }
            this.text = 'TouchType:' + this.eventType + '\nDistance between touch point and touch element:\nx: '
              + event.touches[0].x + '\n' + 'y: ' + event.touches[0].y + '\nComponent globalPos:('
              + event.target.area.globalPosition.x + ',' + event.target.area.globalPosition.y + ')\nwidth:'
              + event.target.area.width + '\nheight:' + event.target.area.height
          }
        })
      Button('Touch').height(50).width(200).margin(20)
        .onTouch((event?: TouchEvent) => {
          if(event){
            if (event.type === TouchType.Down) {
              this.eventType = 'Down';
            }
            if (event.type === TouchType.Up) {
              this.eventType = 'Up';
            }
            if (event.type === TouchType.Move) {
              this.eventType = 'Move';
            }
            if (event.type === TouchType.Cancel) {
              this.eventType = 'Cancel';
            }
            this.text = 'TouchType:' + this.eventType + '\nDistance between touch point and touch element:\nx: '
              + event.touches[0].x + '\n' + 'y: ' + event.touches[0].y + '\nComponent globalPos:('
              + event.target.area.globalPosition.x + ',' + event.target.area.globalPosition.y + ')\nwidth:'
              + event.target.area.width + '\nheight:' + event.target.area.height
          }
        })
      Text(this.text)
    }
    .height('100%')
    .width('100%')
  }
}