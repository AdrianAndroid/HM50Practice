// WindowUtils.ets
// 窗口信息
import { window } from '@kit.ArkUI';
import Logger from '../common/Logger';
import { BusinessError } from '@kit.BasicServicesKit';


export class WindowUtils {
  public static window: window.Window;
  public static windowWidth_px: number;
  public static windowHeight_px: number;
  public static topAvoidAreaHeight_px: number;
  public static navigationIndicatorHeight_px: number;
  public static vpWindowWidth = () => {
    px2vp(WindowUtils.windowWidth_px)
  }
  public static vpWindowHeight = () => {
    px2vp(WindowUtils.windowHeight_px)
  }
  public static vpTopAvoidAreaHeight = () => {
    px2vp(WindowUtils.topAvoidAreaHeight_px)
  }
  public static vpNavigationIndicatorHeight = () => {
    px2vp(WindowUtils.navigationIndicatorHeight_px)
  }

  public static initWindowUtils(windowStage: window.WindowStage) {
    let windowClass: window.Window = windowStage.getMainWindowSync()
    // 1. 设置窗口全屏
    windowClass.setWindowLayoutFullScreen(true)
      .then(() => {
        Logger.info('Succeeded in setting the window layout to full-screen mode.');
      })
      .catch((err: BusinessError) => {
        Logger.error('Failed to set the window layout to full-screen mode. Cause:' + JSON.stringify(err));
      })
    // 2. 获取窗口信息
    WindowUtils.window = windowClass;
    WindowUtils.windowWidth_px = windowClass.getWindowProperties().windowRect.width
    WindowUtils.windowHeight_px = windowClass.getWindowProperties().windowRect.height
    // 3. 获取顶部安全区高度和获取底部导航栏高度
    WindowUtils.topAvoidAreaHeight_px = windowClass.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM).topRect.height
    WindowUtils.navigationIndicatorHeight_px =
      windowClass.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR).bottomRect.height

    windowClass.on('avoidAreaChange', (data) => {
      if (data.type === window.AvoidAreaType.TYPE_SYSTEM) {
        WindowUtils.topAvoidAreaHeight_px =
          windowClass.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM).topRect.height
        Logger.info('avoidAreaChange => window.AvoidAreaType.TYPE_SYSTEM')
      } else if (data.type == window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR) {
        WindowUtils.navigationIndicatorHeight_px =
          windowClass.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR).bottomRect.height
        Logger.info('avoidAreaChange => window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR')
      } else {
        Logger.info('avoidAreaChange => other')
      }
    });
  }

  public static setTopRectHide(isHide: boolean) {
    // 设置状态栏隐藏
    if (canIUse('SystemCapability.Window.SessionManager')) {
      WindowUtils.window.setSpecificSystemBarEnabled('status', false).then(() => {
        Logger.info('Succeeded in setting the status bar to be invisible.');
      }).catch((err: BusinessError) => {
        Logger.error(`Failed to set the status bar to be invisible. Code is ${err.code}, message is ${err.message}`);
      });
    } else {
      Logger.warn('当前设备不支持系统栏状态修改');
    }
  }

  public static setNavigationHide(isHide: boolean) {
    // 设置导航条隐藏
    if (canIUse('SystemCapability.Window.SessionManager')) {
      WindowUtils.window.setSpecificSystemBarEnabled('navigationIndicator', false).then(() => {
        console.info('Succeeded in setting the navigation indicator to be invisible.');
      }).catch((err: BusinessError) => {
        console.error(`Failed to set the navigation indicator to be invisible. Code is ${err.code}, message is ${err.message}`);
      });
    } else {
      console.warn('当前设备不支持系统栏状态修改');
    }
  }

  public static destroyWindowUtils() {

  }
}