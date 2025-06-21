/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { TabContentConstants } from './TabContentConstants';
import { BusinessError } from '@kit.BasicServicesKit';
import { common, Want } from '@kit.AbilityKit';
import Constants from './Constants';
import { util } from '@kit.ArkTS';

const uiContext: UIContext | undefined = AppStorage.get('uiContext');

export class Utils {
  static showPromptAction() {
    uiContext?.getPromptAction().showToast({
      message: $r('app.string.tab_toast_message'),
      duration: TabContentConstants.TAB_DURATION
    });
  }

  static finishSelf(context?: common.UIAbilityContext) {
    try {
      context?.terminateSelf((err: BusinessError) => {
        if (err.code) {
          // 处理业务逻辑错误
          console.error(`terminateSelf failed, code is ${err.code}, message is ${err.message}`);
          return;
        }
        // 执行正常业务
        console.info('terminateSelf succeed');
      })
    } catch (err) {
      // 捕获同步的参数错误
      let code = (err as BusinessError).code;
      let message = (err as BusinessError).message;
      console.error(`terminateSelf failed, code is ${code}, message is ${message}`);
    }
  }

  static startAbility(
    context: common.UIAbilityContext,
    abilityName: string,
    parameter?: Record<string, Object>
  ): Promise<void> {
    let want: Want = {
      deviceId: '', // deviceId为空表示本设备
      bundleName: Constants.bundleName,
      moduleName: 'entry', // moduleName非必选
      abilityName: abilityName,
      parameters: parameter
    };
    return context.startAbility(want)
  }

  static startAbilityForResult(
    context: common.UIAbilityContext,
    abilityName: string,
    parameter?: Record<string, Object>
  ): Promise<Object> {
    let want: Want = {
      deviceId: '', // deviceId为空表示本设备
      bundleName: Constants.bundleName,
      moduleName: 'entry', // moduleName非必选
      abilityName: abilityName,
      parameters: parameter
    };
    return context.startAbilityForResult(want)
  }

  static getObjAddress(my_object: Object): number {
    return util.getHash(my_object)
  }
}