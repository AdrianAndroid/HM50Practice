import { KeyCode } from '@kit.InputKit';

@Entry
@Component
struct MouseEventPage {
  @State hoverText: string = 'Not Hover';
  @State Color: Color = Color.Gray;

  @State buttonText: string = '';
  @State columnText: string = '';
  @State isHovered:ish = new ish()


  build() {
    Scroll() {
      Column() {
        Text('onHover')
        Button(this.hoverText)
          .width(200).height(100)
          .backgroundColor(this.Color)
          .onHover((isHover?: boolean) => { // 使用onHover接口监听鼠标是否悬浮在Button组件上
            if (isHover) {
              this.hoverText = 'Hovered!';
              this.Color = Color.Green;
            }
            else {
              this.hoverText = 'Not Hover';
              this.Color = Color.Gray;
            }
          })
        Text('onMouse')
        Column() {
          Button(this.hoverText)
            .width(200)
            .height(100)
            .backgroundColor(this.Color)
            .onHover((isHover?: boolean) => {
              if (isHover) {
                this.hoverText = 'Hovered!';
                this.Color = Color.Green;
              }
              else {
                this.hoverText = 'Not Hover';
                this.Color = Color.Gray;
              }
            })
            .onMouse((event?: MouseEvent) => { // 设置Button的onMouse回调
              if (event) {
                this.buttonText = 'Button onMouse:\n' + '' +
                  'button = ' + event.button + '\n' +
                  'action = ' + event.action + '\n' +
                  'x,y = (' + event.x + ',' + event.y + ')' + '\n' +
                  'windowXY=(' + event.windowX + ',' + event.windowY + ')';
              }
            })
          Divider()
          Text(this.buttonText).fontColor(Color.Green)
          Divider()
          Text(this.columnText).fontColor(Color.Red)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .borderWidth(2)
        .borderColor(Color.Red)
        .onMouse((event?: MouseEvent) => { // Set the onMouse callback for the column.
          if (event) {
            this.columnText = 'Column onMouse:\n' + '' +
              'button = ' + event.button + '\n' +
              'action = ' + event.action + '\n' +
              'x,y = (' + event.x + ',' + event.y + ')' + '\n' +
              'windowXY=(' + event.windowX + ',' + event.windowY + ')';
          }
        })

        Text('stopPropagation')
        Column(){
          Button(this.isHovered ? 'Hovered!' : 'Not Hover')
            .width(200)
            .height(100)
            .backgroundColor(this.isHovered ? Color.Green : Color.Gray)
            .onHover((isHover?: boolean) => {
              if(isHover) {
                let ishset = new ish()
                ishset.set(isHover)
              }
            })
            .onMouse((event?: MouseEvent) => {
              if (event) {
                if (event.stopPropagation) {
                  event.stopPropagation(); // 在Button的onMouse事件中设置阻止冒泡
                }
                let butset = new butf()
                butset.set('Button onMouse:\n' + '' +
                  'button = ' + event.button + '\n' +
                  'action = ' + event.action + '\n' +
                  'x,y = (' + event.x + ',' + event.y + ')' + '\n' +
                  'windowXY=(' + event.windowX + ',' + event.windowY + ')');
              }
            })
        }

        Text('hoverEffect')
        Button('Auto')
          .width(170).height(70)
        Button('Scale')
          .width(170).height(70)
          .hoverEffect(HoverEffect.Scale)
        Button('Highlight')
          .width(170).height(70)
          .hoverEffect(HoverEffect.Highlight)
        Button('None')
          .width(170).height(70)
          .hoverEffect(HoverEffect.None)

        Text('onKeyEvent & onKeyPreIme')
        Column() {
          Button('onKeyEvent')
            .defaultFocus(true)
            .width(140).height(70)
            .onKeyEvent((event?: KeyEvent) => { // 给Button设置onKeyEvent事件
              if(event){
                if (event.type === KeyType.Down) {
                  this.buttonType = 'Down';
                }
                if (event.type === KeyType.Up) {
                  this.buttonType = 'Up';
                }
                this.buttonText = 'Button: \n' +
                  'KeyType:' + this.buttonType + '\n' +
                  'KeyCode:' + event.keyCode + '\n' +
                  'KeyText:' + event.keyText;
              }
            })

          Divider()
          Text(this.buttonText).fontColor(Color.Green)

          Divider()
          Text(this.columnText).fontColor(Color.Red)
        }.width('100%').height('50%').justifyContent(FlexAlign.Center)
        .onKeyEvent((event?: KeyEvent) => { // 给父组件Column设置onKeyEvent事件
          if(event){
            if (event.type === KeyType.Down) {
              this.columnType = 'Down';
            }
            if (event.type === KeyType.Up) {
              this.columnType = 'Up';
            }
            this.columnText = 'Column: \n' +
              'KeyType:' + this.buttonType + '\n' +
              'KeyCode:' + event.keyCode + '\n' +
              'KeyText:' + event.keyText;
          }
        })

        Text('stopPropagation')
        Column() {
          Button('onKeyEvent')
            .defaultFocus(true)
            .width(140).height(70)
            .onKeyEvent((event?: KeyEvent) => {
              // 通过stopPropagation阻止事件冒泡
              if(event){
                if(event.stopPropagation){
                  event.stopPropagation();
                }
                if (event.type === KeyType.Down) {
                  this.buttonType = 'Down';
                }
                if (event.type === KeyType.Up) {
                  this.buttonType = 'Up';
                }
                this.buttonText = 'Button: \n' +
                  'KeyType:' + this.buttonType + '\n' +
                  'KeyCode:' + event.keyCode + '\n' +
                  'KeyText:' + event.keyText;
              }
            })

          Divider()
          Text(this.buttonText).fontColor(Color.Green)

          Divider()
          Text(this.columnText).fontColor(Color.Red)
        }.width('100%').height('100%').justifyContent(FlexAlign.Center)
        .onKeyEvent((event?: KeyEvent) => { // 给父组件Column设置onKeyEvent事件
          if(event){
            if (event.type === KeyType.Down) {
              this.columnType = 'Down';
            }
            if (event.type === KeyType.Up) {
              this.columnType = 'Up';
            }
            this.columnText = 'Column: \n' +
              'KeyType:' + this.buttonType + '\n' +
              'KeyCode:' + event.keyCode + '\n' +
              'KeyText:' + event.keyText;
          }
        })

        Text('OnKeyPreIme屏蔽')
        Search({
          placeholder: "Search..."
        })
          .width("80%")
          .height("40vp")
          .border({ radius:"20vp" })
          .onKeyPreIme((event:KeyEvent) => {
            if (event.keyCode == KeyCode.KEYCODE_DPAD_LEFT) {
              return true;
            }
            return false;
          })
      }
    }
    .height('100%')
    .width('100%')
  }

  @State buttonType: string = '';
  @State columnType: string = '';
}

class ish{
  isHovered:boolean = false
  set(val:boolean){
    this.isHovered = val;
  }
}
class butf{
  buttonText:string = ''
  set(val:string){
    this.buttonText = val
  }
}