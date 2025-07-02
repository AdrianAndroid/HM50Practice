import {
  AbilityConstant,
  AbilityLifecycleCallback,
  Configuration,
  ConfigurationConstant,
  startupManager,
  UIAbility,
  Want
} from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { Colors, CustomColors, display, promptAction, ThemeControl, uiObserver, window } from '@kit.ArkUI';
import Constants from '../common/Constants';
import ConnectionUtils from '../common/network/ConnectionUtils';
import RDBStoreUtil from '../common/database/RDBStoreUtil';
import preferenceUtilsObject from '../common/database/PreferencesUtil';
import { BusinessError } from '@kit.BasicServicesKit';
import Logger from '../common/Logger';
import { relationalStore } from '@kit.ArkData';
import { commonType, distributedDataObject } from '@kit.ArkData';
import { fileIo, fileUri } from '@kit.CoreFileKit';
import { JSON } from '@kit.ArkTS';
import { KeyboardAvoidMode } from '@kit.ArkUI';
import { WindowUtils } from '../utils/WindowUtils';
import { TCConstantsWindowUtility } from '../utils/windowutils/TCConstantsWindowUtility';
import { TCConstantsWindowUtils } from '../utils/windowutils/TCConstantsWindowUtils';
import { GlobalContext } from '../utils/BDSGlobalContext';
import { resourceManager } from '@kit.LocalizationKit';

// 业务数据定义
class Data {
  title: string | undefined;
  text: string | undefined;
  attachment: commonType.Asset; // 可以使用资产类型记录分布式目录下的文件，迁移资产数据时，对应的文件会一起迁移到接收端。（不迁移文件时不需要此字段，下方代码中的createAttachment、createEmptyAttachment方法也都不需要。）
  // attachment2: commonType.Asset; // 暂不支持资产类型数组，如果要迁移多个文件，在业务数据中定义多条资产数据来记录
  context: Context | undefined;
  launchWant: Want | undefined;

  constructor(title: string | undefined, text: string | undefined, attachment: commonType.Asset) {
    this.title = title;
    this.text = text;
    this.attachment = attachment;
  }
}

class AppColors implements CustomColors {
  fontPrimary = 0xFFD53032
  iconOnPrimary = 0xFFD53032
  iconFourth = 0xFFD53032
}

export class AppTheme implements CustomTheme {
  public colors?: Partial<Colors> | undefined = new AppColors()
}

const abilityThemeColors = new AppColors();
export let gAppTheme: CustomTheme = new AppTheme()

let dataObject: distributedDataObject.DataObject;
const TAG: string = '[EntryAbility]';
const DOMAIN_NUMBER: number = 0xFF00;

let systemLanguage: string | undefined; // 系统当前语言
let windowStage_: window.WindowStage | null = null;
let sub_windowClass: window.Window | null = null;

export default class EntryAbility extends UIAbility {
  para: Record<string, number> = { 'PropA': 47 }
  storage: LocalStorage = new LocalStorage(this.para)
  // 定义生命周期ID
  private lifecycleId: number = -1;
  private curBp: string = '';

  eventFunc(argOne: Context, argTwo: Context): void {
    hilog.info(DOMAIN_NUMBER, TAG, '%{public}s', `eventeventevent ${Constants.EVENT_HUB_1} eventFunc argOne=${argOne} ${typeof argOne} argTwo=${argTwo} ${typeof argTwo}`)
    return
  }

  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    if (launchParam.launchReason == AbilityConstant.LaunchReason.CONTINUATION) {
      if (want.parameters && want.parameters.distributedSessionId) {
        this.restoreDistributedDataObject(want);
      }
    }
    AppStorage.SetOrCreate('currentColorMode', this.context.config.colorMode)
    this.context.eventHub.on('getAbilityData', (data: Data): void => {
      hilog.info(0x0000, TAG, `%{public}s`, `getAbilityData`);
      data.context = this.context;
      data.launchWant = want;
    });
    this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
    // this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_DARK);

    // 获取UIAbilityContext
    let context = this.context
    // 获取ApplicationContext（应用级别的Context
    let applicationContext = this.context.getApplicationContext()

    preferenceUtilsObject.getFontPreferences(this.context);
    ConnectionUtils.openRegister();

    this.registerLifecycle()
    this.startupInit()

    let eventhub = this.context.eventHub
    eventhub.on(Constants.EVENT_HUB_1, this.eventFunc)
    eventhub.on(Constants.EVENT_HUB_1, (data: Object, data2: Object) => {
      // 触发事件，完成相应的业务操作
      hilog.info(DOMAIN_NUMBER, TAG, '%{public}s', `eventeventevent ${Constants.EVENT_HUB_1} data=${data} ${typeof data} data2=${data2} ${typeof data2}`)
    })

    uiObserver.on('navDestinationSwitch', this.context, (info: uiObserver.NavDestinationSwitchInfo) => {
      console.log(JSON.stringify(info));
      // promptAction.showToast({message: JSON.stringify(info)})
    })

    systemLanguage = this.context.config.language; // UIAbility实例首次加载时，获取系统当前语言

    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    hilog.info(0x0000, 'testTag', '%{public}s', 'want param:' + JSON.stringify(want) ?? '');
    hilog.info(0x0000, 'testTag', '%{public}s', 'launchParam:' + JSON.stringify(launchParam) ?? '');

    // let windowClass: window.Window | undefined = undefined;
    // window.getLastWindow(this.context, (err: BusinessError, data) => {
    //   if (err.code) {
    //     hilog.error(0x0000, 'testTag', 'Failed to obtain top window. Cause:' + JSON.stringify(err));
    //     return;
    //   }
    //   windowClass = data;
    //   // Top status bar height for window content avoidance.
    //   let statusHeight = 0;
    //   // Height of the bottom security zone that is avoided by the window content.
    //   let bottomHeight = 0;
    //   // Gets the region that the window content avoids.
    //   let type = window.AvoidAreaType.TYPE_SYSTEM;
    //   try {
    //     let avoidArea: window.AvoidArea = windowClass.getWindowAvoidArea(type);
    //     statusHeight = avoidArea.topRect.height;
    //     bottomHeight = avoidArea.bottomRect.height
    //   } catch (exception) {
    //     hilog.error(0x0000, 'testTag', 'Failed to obtain the area. Cause:' + JSON.stringify(exception));
    //   }
    //   AppStorage.setOrCreate('statusHeight', statusHeight);
    //   AppStorage.setOrCreate('bottomHeight', bottomHeight);
    //   let screenHeight: number = 0;
    //   let displayClass: display.Display | null = null;
    //   try {
    //     displayClass = display.getDefaultDisplaySync();
    //     screenHeight = displayClass.height;
    //   } catch (exception) {
    //     hilog.error(0x0000, 'testTag', 'Failed to obtain the default display object. Code: ' + JSON.stringify(exception));
    //   }
    //   hilog.info(0x0000, 'testTag', 'Succeeded to obtain the default display object. Code: ' + JSON.stringify(displayClass));
    //   AppStorage.setOrCreate('screenHeight', screenHeight);
    // });
  }

  registerLifecycle() {
    let TAG = 'registerLifecycle'
    // 定义生命周期回调对象
    let abilityLifecycleCallback: AbilityLifecycleCallback = {
      // 当UIAbility创建时被调用
      onAbilityCreate(uiAbility) {
        hilog.info(DOMAIN_NUMBER, TAG, `onAbilityCreate uiAbility.launchWant: ${JSON.stringify(uiAbility.launchWant)}`);
      },
      // 当窗口创建时被调用
      onWindowStageCreate(uiAbility, windowStage: window.WindowStage) {
        hilog.info(DOMAIN_NUMBER, TAG, `onWindowStageCreate uiAbility.launchWant: ${JSON.stringify(uiAbility.launchWant)}`);
        hilog.info(DOMAIN_NUMBER, TAG, `onWindowStageCreate windowStage: ${JSON.stringify(windowStage)}`);
      },
      // 当窗口处于活动状态时被调用
      onWindowStageActive(uiAbility, windowStage: window.WindowStage) {
        hilog.info(DOMAIN_NUMBER, TAG,
          `onWindowStageActive uiAbility.launchWant: ${JSON.stringify(uiAbility.launchWant)}`);
        hilog.info(DOMAIN_NUMBER, TAG, `onWindowStageActive windowStage: ${JSON.stringify(windowStage)}`);
      },
      // 当窗口处于非活动状态时被调用
      onWindowStageInactive(uiAbility, windowStage: window.WindowStage) {
        hilog.info(DOMAIN_NUMBER, TAG,
          `onWindowStageInactive uiAbility.launchWant: ${JSON.stringify(uiAbility.launchWant)}`);
        hilog.info(DOMAIN_NUMBER, TAG, `onWindowStageInactive windowStage: ${JSON.stringify(windowStage)}`);
      },
      // 当窗口被销毁时被调用
      onWindowStageDestroy(uiAbility, windowStage: window.WindowStage) {
        hilog.info(DOMAIN_NUMBER, TAG, `onWindowStageDestroy uiAbility.launchWant: ${JSON.stringify(uiAbility.launchWant)}`);
        hilog.info(DOMAIN_NUMBER, TAG, `onWindowStageDestroy windowStage: ${JSON.stringify(windowStage)}`);
      },
      // 当UIAbility被销毁时被调用
      onAbilityDestroy(uiAbility) {
        hilog.info(DOMAIN_NUMBER, TAG,
          `onAbilityDestroy uiAbility.launchWant: ${JSON.stringify(uiAbility.launchWant)}`);
      },
      // 当UIAbility从后台转到前台时触发回调
      onAbilityForeground(uiAbility) {
        hilog.info(DOMAIN_NUMBER, TAG,
          `onAbilityForeground uiAbility.launchWant: ${JSON.stringify(uiAbility.launchWant)}`);
      },
      // 当UIAbility从前台转到后台时触发回调
      onAbilityBackground(uiAbility) {
        hilog.info(DOMAIN_NUMBER, TAG,
          `onAbilityBackground uiAbility.launchWant: ${JSON.stringify(uiAbility.launchWant)}`);
      },
      // 当UIAbility迁移时被调用
      onAbilityContinue(uiAbility) {
        hilog.info(DOMAIN_NUMBER, TAG,
          `onAbilityContinue uiAbility.launchWant: ${JSON.stringify(uiAbility.launchWant)}`);
      }
    }
    let applicationContext = this.context.getApplicationContext()
    try {
      // 注册应用内生命周期回调
      this.lifecycleId = applicationContext.on('abilityLifecycle', abilityLifecycleCallback);
    } catch (err) {
      let code = (err as BusinessError).code;
      let message = (err as BusinessError).message;
      hilog.error(DOMAIN_NUMBER, TAG, `Failed to register applicationContext. Code is ${code}, message is ${message}`);
    }

    hilog.info(DOMAIN_NUMBER, TAG, `register callback number: ${this.lifecycleId}`);
  }

  startupInit() {
    let startParams = ["StartupTask_005", "StartupTask_006"];
    try {
      startupManager.run(startParams).then(() => {
        Logger.debug(Constants.TAG_STARTUP_TASK, 'StartupTest startupManager run then, startParams = ');
      }).catch((error: BusinessError) => {
        Logger.debug(Constants.TAG_STARTUP_TASK, 'StartupTest promise catch error, error = ' + JSON.stringify(error));
        Logger.debug(Constants.TAG_STARTUP_TASK, 'StartupTest promise catch error, startParams = ' + JSON.stringify(startParams));
      })
    } catch (error) {
      let errMsg = JSON.stringify(error);
      let errCode: number = error.code;
      Logger.debug(Constants.TAG_STARTUP_TASK, 'Startup catch error , errCode= ' + errCode);
    }
  }

  // 1. 迁移发起端在onContinue接口中创建分布式数据对象并保存数据到接收端
  onContinue(wantParam: Record<string, Object>): AbilityConstant.OnContinueResult | Promise<AbilityConstant.OnContinueResult> {
    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onContinue');

    // 1.1 调用create接口创建并得到一个分布式数据对象实例
    let attachment = this.createAttachment();
    let data = new Data('The title', 'The text', attachment);
    dataObject = distributedDataObject.create(this.context, data);

    // 1.2 调用genSessionId接口创建一个sessionId，调用setSessionId接口设置同步的sessionId，并将这个sessionId放入wantParam
    let sessionId = distributedDataObject.genSessionId();
    console.log(TAG + `gen sessionId: ${sessionId}`);
    dataObject.setSessionId(sessionId);
    wantParam.distributedSessionId = sessionId;

    // 1.3 从wantParam获取接收端设备networkId，使用这个networkId调用save接口保存数据到接收端
    let deviceId = wantParam.targetDevice as string;
    console.log(TAG + `get deviceId: ${deviceId}`);
    dataObject.save(deviceId);
    return AbilityConstant.OnContinueResult.AGREE;
  }

  // switchArea() {
    // // 存储普通信息前，切换到EL1设备级加密
    // this.context.area = contextConstant.AreaMode.EL1; // 切换area
    // // 存储普通信息
    // // 存储敏感信息前，切换到EL2用户级加密
    // this.context.area = contextConstant.AreaMode.EL2; // 切换area
    // // 存储敏感信息
    // // 存储敏感信息前，切换到EL3用户级加密
    // this.context.area = contextConstant.AreaMode.EL3; // 切换area
    // // 存储敏感信息
    // // 存储敏感信息前，切换到EL4用户级加密
    // this.context.area = contextConstant.AreaMode.EL4; // 切换area
    // // 存储敏感信息
    // // 存储敏感信息前，切换到EL5应用级加密
    // this.context.area = contextConstant.AreaMode.EL5; // 切换area
    // // 存储敏感信息
  // }

  onDestroy(): void | Promise<void> {
    this.context.eventHub.off(Constants.EVENT_HUB_1)
    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');
    RDBStoreUtil.createObjectiveRDB(this.context);

    this.initDragInfo(windowStage)
    this.initTCWindowUtil(windowStage)
    this.initRotation(windowStage)
    this.initWindowUtil(windowStage)

    GlobalContext.getContext().setObject('windowStage', windowStage);
    windowStage.loadContent(Constants.LOAD_ENTRY_PAGE, this.storage, (err, data) => {
      // windowStage.getMainWindowSync().getUIContext().getKeyboardAvoidMode();
      // windowStage.getMainWindowSync().getUIContext().setKeyboardAvoidMode(KeyboardAvoidMode.RESIZE);
      windowStage.getMainWindowSync().getUIContext().setKeyboardAvoidMode(KeyboardAvoidMode.RESIZE);
      if (err.code) {
        hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.ERROR);
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      const windowClass = windowStage.getMainWindowSync();
      AppStorage.setOrCreate("context", windowClass.getUIContext());
      AppStorage.setOrCreate('uiContext', windowStage.getMainWindowSync().getUIContext());
      ConnectionUtils.registerNetworkAvailableStatus();
      hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
      PersistentStorage.persistProp('aProp', 47)

      ThemeControl.setDefaultTheme({colors: abilityThemeColors})

      // this.initFullWindow1(windowStage)
      // this.initFullWindow2(windowStage)
      // this.initFullWindow3(windowStage)
      this.initFullWindow4(windowStage)
    });
    // window.createWindow({
    //   name: Constants.LOAD_ENTRY_PAGE,
    //   windowType: window.WindowType.TYPE_FLOAT
    // })
    this.showSubWindow()
  }


  private initDragInfo(windowStage: window.WindowStage) {
    windowStage.getMainWindow().then((windowObj: window.Window) => {
      try {
        let type: window.AvoidAreaType = window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR;
        let avoidArea: window.AvoidArea = windowObj.getWindowAvoidArea(type);
        let bottomRectHeight: number = avoidArea.bottomRect.height;
        AppStorage.setOrCreate('bottomRectHeight', bottomRectHeight);
        type = window.AvoidAreaType.TYPE_SYSTEM;
        avoidArea = windowObj.getWindowAvoidArea(type);
        let topRectHeight: number = avoidArea.topRect.height;
        AppStorage.setOrCreate('topRectHeight', topRectHeight);
        this.updateBreakpoint(windowObj.getWindowProperties().windowRect.width);
        windowObj.on('windowSizeChange', (windowSize) => {
          this.updateBreakpoint(windowSize.width);
        });

        windowObj.setWindowLayoutFullScreen(true).then(() => {
          hilog.info(0x0000, TAG, `%{public}s`, `Succeeded in setting the window layout to full-screen mode`);
        }).catch((err: BusinessError) => {
          hilog.error(0x0000, TAG, `Failed to set the window layout to full-screen mode. Cause:`, err.message);
        });
      } catch (err) {
        hilog.error(0x0000, TAG, `Set window properties err. Cause: ${err.code}`);
      }
    }).catch((err: BusinessError) => {
      hilog.error(0x0000, TAG, `Failed to get main window. Cause:`, err.message);
    });
    // Main window is created, set main page for this ability
    hilog.info(0x0000, TAG, `%{public}s`, `Ability onWindowStageCreate`);
    let resourceManager: resourceManager.ResourceManager = this.context.resourceManager;
    AppStorage.setOrCreate('resourceManager', resourceManager);
  }

  showSubWindow() {
    // 1.创建应用子窗口。
    if (windowStage_ == null) {
      console.error('Failed to create the subwindow. Cause: windowStage_ is null');
    }
    else {
      windowStage_.createSubWindow("mySubWindow", (err: BusinessError, data) => {
        let errCode: number = err.code;
        if (errCode) {
          console.error('Failed to create the subwindow. Cause: ' + JSON.stringify(err));
          return;
        }
        sub_windowClass = data;
        console.info('Succeeded in creating the subwindow. Data: ' + JSON.stringify(data));
        // 2.子窗口创建成功后，设置子窗口的位置、大小及相关属性等。
        sub_windowClass.moveWindowTo(300, 300, (err: BusinessError) => {
          let errCode: number = err.code;
          if (errCode) {
            console.error('Failed to move the window. Cause:' + JSON.stringify(err));
            return;
          }
          console.info('Succeeded in moving the window.');
        });
        sub_windowClass.resize(500, 500, (err: BusinessError) => {
          let errCode: number = err.code;
          if (errCode) {
            console.error('Failed to change the window size. Cause:' + JSON.stringify(err));
            return;
          }
          console.info('Succeeded in changing the window size.');
        });
        // 3.为子窗口加载对应的目标页面。
        sub_windowClass.setUIContent(Constants.LOAD_ENTRY_PAGE, (err: BusinessError) => {
          let errCode: number = err.code;
          if (errCode) {
            console.error('Failed to load the content. Cause:' + JSON.stringify(err));
            return;
          }
          console.info('Succeeded in loading the content.');
          // 3.显示子窗口。
          (sub_windowClass as window.Window).showWindow((err: BusinessError) => {
            let errCode: number = err.code;
            if (errCode) {
              console.error('Failed to show the window. Cause: ' + JSON.stringify(err));
              return;
            }
            console.info('Succeeded in showing the window.');
          });
        });
      })
    }
  }

  test() {
    canIUse('SystemCapability.ArkUI.ArkUI.Full')
  }

  destroySubWindow() {
    // 4.销毁子窗口。当不再需要子窗口时，可根据具体实现逻辑，使用destroy对其进行销毁。
    (sub_windowClass as window.Window).destroyWindow((err: BusinessError) => {
      let errCode: number = err.code;
      if (errCode) {
        console.error('Failed to destroy the window. Cause: ' + JSON.stringify(err));
        return;
      }
      console.info('Succeeded in destroying the window.');
    });
  }

  private initTCWindowUtil(windowStage: window.WindowStage) {
    TCConstantsWindowUtility.setWindow(windowStage)
    // Gets the window width and height.
    TCConstantsWindowUtils.window = windowStage.getMainWindowSync();
    TCConstantsWindowUtils.windowWidth_px = TCConstantsWindowUtils.window.getWindowProperties().windowRect.width;
    TCConstantsWindowUtils.windowHeight_px = TCConstantsWindowUtils.window.getWindowProperties().windowRect.height;

    this.updateBreakpoint(TCConstantsWindowUtils.windowWidth_px);

    // Gets the height of the upper escape zone (status bar, etc.).
    let avoidArea = TCConstantsWindowUtils.window.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
    TCConstantsWindowUtils.topAvoidAreaHeight_px = avoidArea.topRect.height;

    // Obtain the navigation bar height.
    let navigationArea = TCConstantsWindowUtils.window.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR);
    TCConstantsWindowUtils.navigationIndicatorHeight_px = navigationArea.bottomRect.height;

    hilog.info(0x0000, TAG, 'the width is ' + TCConstantsWindowUtils.windowWidth_px + '  ' + TCConstantsWindowUtils.windowHeight_px + '  ' +
    TCConstantsWindowUtils.topAvoidAreaHeight_px + '  ' + TCConstantsWindowUtils.navigationIndicatorHeight_px);
    // Monitor and update changes in window size, status bar height and navigation bar height.
    try {
      TCConstantsWindowUtils.window.on('windowSizeChange', (data) => {
        hilog.info(0x0000, TAG, 'on windowSizeChange, the width is ' + data.width + ', the height is ' + data.height);
        TCConstantsWindowUtils.windowWidth_px = data.width;
        TCConstantsWindowUtils.windowHeight_px = data.height;
        this.updateBreakpoint(data.width);
        AppStorage.setOrCreate('windowSizeChanged', Date.now());
      })

      TCConstantsWindowUtils.window.on('avoidAreaChange', (data) => {
        if (data.type === window.AvoidAreaType.TYPE_SYSTEM) {
          let topRectHeight = data.area.topRect.height;
          hilog.info(0x0000, TAG, 'on avoidAreaChange, the top avoid area height is ' + topRectHeight);
          TCConstantsWindowUtils.topAvoidAreaHeight_px = topRectHeight;
        } else if (data.type === window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR) {
          let bottomRectHeight = data.area.bottomRect.height;
          hilog.info(0x0000, TAG, 'on avoidAreaChange, the navigation indicator height is ' + bottomRectHeight);
          TCConstantsWindowUtils.navigationIndicatorHeight_px = bottomRectHeight;
        }
      })
    } catch (exception) {
      hilog.info(0x0000, TAG, 'register failed ' + JSON.stringify(exception));
    }

  }

  private initRotation(windowStage: window.WindowStage) {
    let mainWindow: window.Window;
    try {
      mainWindow = windowStage.getMainWindowSync();
      let displayClass: display.Display = display.getDefaultDisplaySync();
      AppStorage.setOrCreate('orientation', displayClass.orientation);
      // 监听窗口的windowsSizeChange事件，旋转屏时会触发该事件
      mainWindow.on('windowSizeChange', (data) => {
        console.info('Succeeded in enabling the listener for window size changes. Data: ' + JSON.stringify(data));
        let displayClass: display.Display | null = null;
        try {
          displayClass = display.getDefaultDisplaySync();
          console.info('display orientation is ' + JSON.stringify(displayClass.orientation));
          // 获取屏幕的显示方向
          AppStorage.set('orientation', displayClass.orientation);
        } catch {
          return;
        }
      })
    } catch {
      hilog.info(0x0000, 'testTag', '%{public}s', 'error');
      return;
    }
  }

  private initWindowUtil(windowStage: window.WindowStage) {
    WindowUtils.window = windowStage.getMainWindowSync()
    WindowUtils.windowWidth_px = WindowUtils.window.getWindowProperties().windowRect.width
    WindowUtils.windowHeight_px = WindowUtils.window.getWindowProperties().windowRect.height

    this.updateBreakpoint(WindowUtils.windowWidth_px)

    // 获取上方避让区（状态栏）高度
    let avoidArea = WindowUtils.window.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM)
    WindowUtils.topAvoidAreaHeight_px = avoidArea.topRect.height

    // 获取导航条高度
    let navigationArea = WindowUtils.window.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR)
    WindowUtils.navigationIndicatorHeight_px = navigationArea.bottomRect.height

    console.log(TAG, 'the width is ' + WindowUtils.windowWidth_px + '  ' + WindowUtils.windowHeight_px + '  ' + WindowUtils.topAvoidAreaHeight_px + '  ' + WindowUtils.navigationIndicatorHeight_px);

    // 监听窗口尺寸、状态栏高度以及导航栏高度的变化并更新
    try {
      WindowUtils.window.on('windowSizeChange', (data) => {
        console.log(TAG, 'on windowSizeChange, the width is ' + data.width + ', the height is ' + data.height);
        WindowUtils.windowWidth_px = data.width
        WindowUtils.windowHeight_px = data.height
        this.updateBreakpoint(data.width)
        AppStorage.setOrCreate('windowSizeChanged', Date.now())
      })
      WindowUtils.window.on('avoidAreaChange', (data) => {
        if (data.type == window.AvoidAreaType.TYPE_SYSTEM) {
          let topRectHeight = data.area.topRect.height;
          console.log(TAG, 'on avoidAreaChange, the top avoid area height is ' + topRectHeight);
          WindowUtils.topAvoidAreaHeight_px = topRectHeight;
        } else if (data.type == window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR) {
          let bottomRectHeight = data.area.bottomRect.height;
          console.log(TAG, 'on avoidAreaChange, the navigation indicator height is ' + bottomRectHeight);
          WindowUtils.navigationIndicatorHeight_px = bottomRectHeight;
        }
      })
    } catch (e) {
      console.log('register failed ' + JSON.stringify(e));
    }
  }
  private currentBreakPoint: string = '';
  private updateBreakpoint(windowWidth: number) {
    let windowWidthVp: number = windowWidth / display.getDefaultDisplaySync().densityPixels;
    let newBp: string = '';
    if (windowWidthVp < 600) {
      newBp = Constants.BREAK_POINT_SM;
    } else if (windowWidthVp < 840) {
      newBp = Constants.BREAK_POINT_MD;
    } else {
      newBp = Constants.BREAK_POINT_LG;
    }
    if (this.currentBreakPoint !== newBp) {
      this.currentBreakPoint = newBp
      // 使用状态变量记录当前断电值
      AppStorage.setOrCreate('currentBreakpoint', this.currentBreakPoint)
    }
    if (this.curBp !== newBp) {
      this.curBp = newBp;
      AppStorage.setOrCreate('currentBreakpoint', this.curBp);
    }
  }

  // private updateBreakpoint2(windowWidth: number): void {
  //   try {
  //     let windowWidthVp: number = windowWidth / display.getDefaultDisplaySync().densityPixels;
  //     let newBp: string = '';
  //     if (windowWidthVp < 600) {
  //       newBp = Constants.BREAK_POINT_SM;
  //     } else if (windowWidthVp < 840) {
  //       newBp = Constants.BREAK_POINT_MD;
  //     } else {
  //       newBp = Constants.BREAK_POINT_LG;
  //     }
  //     if (this.curBp !== newBp) {
  //       this.curBp = newBp;
  //       AppStorage.setOrCreate('currentBreakpoint', this.curBp);
  //     }
  //   } catch (error) {
  //     hilog.error(0x0000, TAG, `updateBreakpoint catch err:`, (error as BusinessError).message);
  //   }
  // }

  private initFullWindow4(windowStage: window.WindowStage) {
    // windowStage.getMainWindow().then((data: window.Window) => {
    //   // Window immersive.
    //   data.setWindowLayoutFullScreen(true);
    // })
    windowStage.getMainWindowSync().setWindowBackgroundColor('#DCDCDC');
  }
  private initFullWindow3(windowStage: window.WindowStage) {
    // windowStage.getMainWindow().then((data: window.Window) => {
    //   // Window immersive.
    //   data.setWindowLayoutFullScreen(true);
    // })
    // 设置全窗颜色和应用元素颜色一致
    // windowStage.getMainWindowSync().setWindowBackgroundColor('#008000');
  }

  private initFullWindow2(windowStage: window.WindowStage) {
    // windowStage.getMainWindow().then((data: window.Window) => {
    //   // Window immersive.
    //   data.setWindowLayoutFullScreen(true);
    // })
    let windowClass: window.Window = windowStage.getMainWindowSync(); // 获取应用主窗口
    // 1. 设置窗口全屏
    let isLayoutFullScreen = true
    windowClass.setWindowLayoutFullScreen(isLayoutFullScreen).then(() => {
      console.info('Succeeded in setting the window layout to full-screen mode.');
    }).catch((err: BusinessError) => {
      console.error('Failed to set the window layout to full-screen mode. Cause:' + JSON.stringify(err));
    });
    // 2. 设置状态栏隐藏
    if (canIUse('SystemCapability.WindowManager.WindowManager.Core')) {
      windowClass.setSpecificSystemBarEnabled('status', false).then(() => {
        console.info('Succeeded in setting the status bar to be invisible.');
      }).catch((err: BusinessError) => {
        console.error(`Failed to set the status bar to be invisible. Code is ${err.code}, message is ${err.message}`);
      });
    } else {
      console.warn('当前设备不支持系统栏状态修改');
    }
    // 2. 设置导航条隐藏
    if (canIUse('SystemCapability.WindowManager.WindowManager.Core')) {
      windowClass.setSpecificSystemBarEnabled('navigationIndicator', false).then(() => {
        console.info('Succeeded in setting the navigation indicator to be invisible.');
      }).catch((err: BusinessError) => {
        console.error(`Failed to set the navigation indicator to be invisible. Code is ${err.code}, message is ${err.message}`);
      });
    } else {
      console.warn('当前设备不支持系统栏状态修改');
    }
  }

  private initFullWindow1(windowStage: window.WindowStage) {
    // windowStage.getMainWindow().then((data: window.Window) => {
    //   // Window immersive.
    //   data.setWindowLayoutFullScreen(true);
    // })
    let windowClass: window.Window = windowStage.getMainWindowSync(); // 获取应用主窗口
    // 1. 设置窗口全屏
    let isLayoutFullScreen = true
    windowClass.setWindowLayoutFullScreen(isLayoutFullScreen).then(() => {
      console.info('Succeeded in setting the window layout to full-screen mode.');
    }).catch((err: BusinessError) => {
      console.error('Failed to set the window layout to full-screen mode. Cause:' + JSON.stringify(err));
    });
    // 进行后续步骤2-3中的操作
    // 2. 获取布局避让遮挡的区域
    let type = window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR; // 以导航条避让为例
    let avoidArea = windowClass.getWindowAvoidArea(type);
    let bottomRectHeight = avoidArea.bottomRect.height; // 获取到导航条区域的高度
    AppStorage.setOrCreate('bottomRectHeight', bottomRectHeight);

    type = window.AvoidAreaType.TYPE_SYSTEM; // 以状态栏避让为例
    avoidArea = windowClass.getWindowAvoidArea(type);
    let topRectHeight = avoidArea.topRect.height; // 获取状态栏区域高度
    AppStorage.setOrCreate('topRectHeight', topRectHeight);

    // 3. 注册监听函数，动态获取避让区域数据
    windowClass.on('avoidAreaChange', (data) => {
      if (data.type === window.AvoidAreaType.TYPE_SYSTEM) {
        let topRectHeight = data.area.topRect.height;
        AppStorage.setOrCreate('topRectHeight', topRectHeight);
      } else if (data.type == window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR) {
        let bottomRectHeight = data.area.bottomRect.height;
        AppStorage.setOrCreate('bottomRectHeight', bottomRectHeight);
      }
    });
  }

  initDbOp() {
    const STORE_CONFIG: relationalStore.StoreConfig = {
      name: 'RdbTest.db', // 数据库文件名
      securityLevel: relationalStore.SecurityLevel.S3, // 数据库安全级别
      encrypt: false, // 可选参数，指定数据库是否加密，默认不加密
      customDir: 'customDir/subCustomDir', // 可选参数，数据库自定义路径。数据库将在如下的目录结构中被创建：context.databaseDir + '/rdb/' + customDir，其中context.databaseDir是应用沙箱对应的路径，'/rdb/'表示创建的是关系型数据库，customDir表示自定义的路径。当此参数不填时，默认在本应用沙箱目录下创建RdbStore实例。
      isReadOnly: false // 可选参数，指定数据库是否以只读方式打开。该参数默认为false，表示数据库可读可写。该参数为true时，只允许从数据库读取数据，不允许对数据库进行写操作，否则会返回错误码801。
    };
    // 判断数据库版本，如果不匹配则需进行升降级操作
    // 假设当前数据库版本为3，表结构：EMPLOYEE (NAME, AGE, SALARY, CODES, IDENTITY)
    const SQL_CREATE_TABLE =
      'CREATE TABLE IF NOT EXISTS EMPLOYEE (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT NOT NULL, AGE INTEGER, SALARY REAL, CODES BLOB, IDENTITY UNLIMITED INT)'; // 建表Sql语句, IDENTITY为bigint类型，sql中指定类型为UNLIMITED INT

    relationalStore.getRdbStore(this.context, STORE_CONFIG, (err, store) => {
      if (err) {
        console.error(`Failed to get RdbStore. Code:${err.code}, message:${err.message}`);
        return;
      }
      console.info('Succeeded in getting RdbStore.');

      // 当数据库创建时，数据库默认版本为0
      if (store.version === 0) {
        store.executeSql(SQL_CREATE_TABLE); // 创建数据表
        // 设置数据库的版本，入参为大于0的整数
        store.version = 3;
      }

      // 如果数据库版本不为0且和当前数据库版本不匹配，需要进行升降级操作
      // 当数据库存在并假定版本为1时，例应用从某一版本升级到当前版本，数据库需要从1版本升级到2版本
      if (store.version === 1) {
        // version = 1：表结构：EMPLOYEE (NAME, SALARY, CODES, ADDRESS) => version = 2：表结构：EMPLOYEE (NAME, AGE, SALARY, CODES, ADDRESS)
        (store as relationalStore.RdbStore).executeSql('ALTER TABLE EMPLOYEE ADD COLUMN AGE INTEGER');
        store.version = 2;
      }

      // 当数据库存在并假定版本为2时，例应用从某一版本升级到当前版本，数据库需要从2版本升级到3版本
      if (store.version === 2) {
        // version = 2：表结构：EMPLOYEE (NAME, AGE, SALARY, CODES, ADDRESS) => version = 3：表结构：EMPLOYEE (NAME, AGE, SALARY, CODES)
        (store as relationalStore.RdbStore).executeSql('ALTER TABLE EMPLOYEE DROP COLUMN ADDRESS TEXT');
        store.version = 3;
      }
    });

    // 请确保获取到RdbStore实例后，再进行数据库的增、删、改、查等操作
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
    this.destroySubWindow()
    ConnectionUtils.closeRegister();
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }

  onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    if (launchParam.launchReason == AbilityConstant.LaunchReason.CONTINUATION) {
      if (want.parameters && want.parameters.distributedSessionId) {
        this.restoreDistributedDataObject(want);
      }
    }
    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    hilog.info(0x0000, 'testTag', '%{public}s',
      `Ability onNewWant -> want=${JSON.stringify(want)}, launchParam=${JSON.stringify(launchParam)}`);
  }

  onDump(params: string[]): string[] {
    return params
  }

  onWindowStageWillDestroy(windowStage: window.WindowStage): void {
    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    hilog.info(0x0000, 'testTag', '%{public}s', `Ability onWindowStageWillDestroy windowStage`);
  }

  onWindowStageRestore(windowStage: window.WindowStage): void {
    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    hilog.info(0x0000, 'testTag', '%{public}s', `Ability onWindowStageRestore onWindowStageRestore`);
  }

  onShare(wantParam: Record<string, Object>): void {
    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    hilog.info(0x0000, 'testTag', '%{public}s', `Ability onShare`);
  }

  onPrepareToTerminate(): boolean {
    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    hilog.info(0x0000, 'testTag', '%{public}s', `Ability onPrepareToTerminate`);
    return false
  }

  // onPrepareToTerminateAsync(): Promise<boolean> {
  //   return new Promise<false>();
  // }

  onBackPressed(): boolean {
    hilog.isLoggable(0x0000, 'testTag', hilog.LogLevel.INFO);
    hilog.info(0x0000, 'testTag', '%{public}s', `Ability onPrepareToTerminate`);
    return false
  }

  onConfigurationUpdate(newConfig: Configuration): void {
    if (systemLanguage !== newConfig.language) {
      hilog.info(DOMAIN_NUMBER, TAG, `systemLanguage from ${systemLanguage} changed to ${newConfig.language}`);
      systemLanguage = newConfig.language; // 将变化之后的系统语言保存，作为下一次变化前的系统语言
    }
    AppStorage.setOrCreate('currentColorMode', newConfig.colorMode)
  }




  restoreDistributedDataObject(want: Want) {
    if (!want.parameters || !want.parameters.distributedSessionId) {
      console.error(TAG + 'missing sessionId');
      return;
    }

    // 2.1 调用create接口创建并得到一个分布式数据对象实例
    let attachment = this.createEmptyAttachment(); // 接收端需要将资产数据的各个属性设置为空字符串，才能恢复发起端保存的资产数据
    let data = new Data(undefined, undefined, attachment);
    dataObject = distributedDataObject.create(this.context, data);

    // 2.2 注册恢复状态监听。收到状态为'restored'的回调通知时，表示接收端分布式数据对象已恢复发起端保存过来的数据（有资产数据时，对应的文件也迁移过来了）
    dataObject.on('status', (sessionId: string, networkId: string, status: string) => {
      if (status == 'restored') { // 收到'restored'的状态通知表示已恢复发起端保存的数据
        console.log(TAG + `title: ${dataObject['title']}, text: ${dataObject['text']}`);
      }
    });

    // 2.3 从want.parameters中获取发起端放入的sessionId，调用setSessionId接口设置同步的sessionId
    let sessionId = want.parameters.distributedSessionId as string;
    console.log(TAG + `get sessionId: ${sessionId}`);
    dataObject.setSessionId(sessionId);
  }

  // 在分布式文件目录下创建一个文件并使用资产类型记录（也可以记录分布式文件目录下已有文件，非分布式文件目录下的文件可以复制或移动到分布式文件目录下再进行记录）
  createAttachment() {
    let attachment = this.createEmptyAttachment();
    try {
      let distributedDir: string = this.context.distributedFilesDir; // 分布式文件目录
      let fileName: string = 'text_attachment.txt'; // 文件名
      let filePath: string = distributedDir + '/' + fileName; // 文件路径
      let file = fileIo.openSync(filePath, fileIo.OpenMode.READ_WRITE | fileIo.OpenMode.CREATE);
      fileIo.writeSync(file.fd, 'The text in attachment');
      fileIo.closeSync(file.fd);
      let uri: string = fileUri.getUriFromPath(filePath); // 获取文件URI
      let stat = fileIo.statSync(filePath); // 获取文件详细属性信息

      // 写入资产数据
      attachment = {
        name: fileName,
        uri: uri,
        path: filePath,
        createTime: stat.ctime.toString(),
        modifyTime: stat.mtime.toString(),
        size: stat.size.toString()
      }
    } catch (e) {
      let err = e as BusinessError;
      console.error(TAG + `file error, error code: ${err.code}, error message: ${err.message}`);
    }
    return attachment;
  }

  createEmptyAttachment() {
    let attachment: commonType.Asset = {
      name: '',
      uri: '',
      path: '',
      createTime: '',
      modifyTime: '',
      size: ''
    }
    return attachment;
  }
}