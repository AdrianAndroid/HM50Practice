// xxx.ets
import { webview } from '@kit.ArkWeb';
import { BusinessError } from '@kit.BasicServicesKit';
import { abilityAccessCtrl, common } from '@kit.AbilityKit';


let context = getContext(this) as common.UIAbilityContext;
let atManager = abilityAccessCtrl.createAtManager();


// 向用户请求位置权限设置。
atManager.requestPermissionsFromUser(context, ["ohos.permission.APPROXIMATELY_LOCATION"]).then((data) => {
  console.info('data:' + JSON.stringify(data));
  console.info('data permissions:' + data.permissions);
  console.info('data authResults:' + data.authResults);
}).catch((error: BusinessError) => {
  console.error(`Failed to request permissions from user. Code is ${error.code}, message is ${error.message}`);
})


@Entry
@Component
struct WebComponent {
  controller: webview.WebviewController = new webview.WebviewController();

  build() {
    Column() {
      Blank().height(200)
      Web({ src: $rawfile('getLocation.html'), controller: this.controller })
        .geolocationAccess(true)
        .onGeolocationShow((event) => { // 地理位置权限申请通知
          AlertDialog.show({
            title: '位置权限请求',
            message: '是否允许获取位置信息',
            primaryButton: {
              value: 'cancel',
              action: () => {
                if (event) {
                  event.geolocation.invoke(event.origin, false, false); // 不允许此站点地理位置权限请求
                }
              }
            },
            secondaryButton: {
              value: 'ok',
              action: () => {
                if (event) {
                  event.geolocation.invoke(event.origin, true, false); // 允许此站点地理位置权限请求
                }
              }
            },
            cancel: () => {
              if (event) {
                event.geolocation.invoke(event.origin, false, false); // 不允许此站点地理位置权限请求
              }
            }
          })
        })
    }
  }
}