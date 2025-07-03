import { geoLocationManager } from '@kit.LocationKit';
import { promptAction } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';


// 获取当前位置信息
function getCurrentLocationInfo() {
  const requestInfo: geoLocationManager.LocationRequest = {
    'priority': geoLocationManager.LocationRequestPriority.FIRST_FIX,
    'scenario': geoLocationManager.LocationRequestScenario.UNSET,
    'timeInterval': 1,
    'distanceInterval': 0,
    'maxAccuracy': 0
  };
  try {
    geoLocationManager.getCurrentLocation(requestInfo)
      .then((location: geoLocationManager.Location) => {
        promptAction.showToast({ message: JSON.stringify(location) });
      })
      .catch((err: BusinessError) => {
        console.error(`Failed to get current location. Code is ${err.code}, message is ${err.message}`);
      });
  } catch (err) {
    console.error(`Failed to get current location. Code is ${err.code}, message is ${err.message}`);
  }
}


@Entry
@Component
struct GeoLocationManagerPage {
  build() {
    Row() {
      Column({ space: 10 }) {
        LocationButton({
          icon: LocationIconStyle.LINES,
          text: LocationDescription.CURRENT_LOCATION,
          buttonType: ButtonType.Normal
        })
          .padding({top: 12, bottom: 12, left: 24, right: 24})
          .onClick((event: ClickEvent, result: LocationButtonOnClickResult) => {
            if (result === LocationButtonOnClickResult.SUCCESS) {
              // 免去权限申请和权限请求等环节，获得临时授权，获取位置信息授权
              getCurrentLocationInfo();
            } else {
              promptAction.showToast({ message: '获取位置信息失败！' })
            }
          })
      }
      .width('100%')
    }
    .height('100%')
    .backgroundColor(0xF1F3F5)
  }
}