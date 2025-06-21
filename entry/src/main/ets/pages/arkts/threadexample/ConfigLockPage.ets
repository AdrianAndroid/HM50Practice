import { config } from './Config'
import { taskpool } from '@kit.ArkTS';

@Concurrent
async function download() {
  if (!await config.isWifiOn()) {
    console.info("wifi is off")
    return false;
  }
  if (!await config.getIsLogin()) {
    console.info("not login")
    return false;
  }
  console.info(`User[${await config.getUser()}] start download ...`)
  return true;
}

@Entry
@Component
struct ConfigTaskPoolPage {
  @State message: string = 'not login';
  @State wifiState: string = "wifi off";
  @State downloadResult: string = "";
  input: string = ""

  build() {
    Row() {
      Column({space: 10}) {
        Blank().height(100)
        Button(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .alignRules({
            center: { anchor: '__container__', align: VerticalAlign.Center },
            middle: { anchor: '__container__', align: HorizontalAlign.Center }
          })
        TextInput({ placeholder: "请输入用户名" })
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .alignRules({
            center: { anchor: '__container__', align: VerticalAlign.Center },
            middle: { anchor: '__container__', align: HorizontalAlign.Center }
          })
          .onChange((value) => {
            this.input = value;
          })
        Button("login")
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .alignRules({
            center: { anchor: '__container__', align: VerticalAlign.Center },
            middle: { anchor: '__container__', align: HorizontalAlign.Center }
          })
          .onClick(async () => {
            if (!await config.getIsLogin() && this.input) {
              this.message = "login: " + this.input
              config.login(this.input)
            }
          })
          .backgroundColor(0xcccccc)
        Button("logout")
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .alignRules({
            center: { anchor: '__container__', align: VerticalAlign.Center },
            middle: { anchor: '__container__', align: HorizontalAlign.Center }
          })
          .onClick(async () => {
            if (await config.getIsLogin()) {
              this.message = "not login"
              config.logout()
            }
          })
          .backgroundColor(0xcccccc)
        Button(this.wifiState)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .alignRules({
            center: { anchor: '__container__', align: VerticalAlign.Center },
            middle: { anchor: '__container__', align: HorizontalAlign.Center }
          })
        Toggle({ type: ToggleType.Switch })
          .onChange(async (isOn: boolean) => {
            await config.setWifiState(isOn)
            this.wifiState = isOn ? "wifi on" : "wifi off";
          })
        Button("download")
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .alignRules({
            center: { anchor: '__container__', align: VerticalAlign.Center },
            middle: { anchor: '__container__', align: HorizontalAlign.Center }
          })
          .onClick(async () => {
            let ret = await taskpool.execute(download)
            this.downloadResult = ret ? "download success" : "download fail";
          })
        Button(this.downloadResult)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .alignRules({
            center: { anchor: '__container__', align: VerticalAlign.Center },
            middle: { anchor: '__container__', align: HorizontalAlign.Center }
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}