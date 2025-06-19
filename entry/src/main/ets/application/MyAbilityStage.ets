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

import { AbilityConstant, AbilityStage, Configuration, Want } from '@kit.AbilityKit';
import Logger from '../common/Logger';
import { hilog } from '@kit.PerformanceAnalysisKit';

const TAG: string = '[MyAbilityStage]';
const DOMAIN_NUMBER: number = 0xFF00;

export default class MyAbilityStage extends AbilityStage {
  onCreate() {
    Logger.info('[AbilityStage]', 'MyAbilityStage onCreate');
    systemLanguage = this.context.config.language; // Module首次加载时，获取系统当前语言
  }

  // onAcceptWant(want: Want): string;
  onAcceptWant(want: Want): string {
    Logger.info('[AbilityStage]', 'MyAbilityStage onAcceptWant');
    // 在被调用方的AbilityStage中，针对启动模式为specified的UIAbility返回一个UIAbility实例对应的一个Key值
    // 当前示例指的是module1 Module的SpecifiedAbility
    if (want.abilityName === 'SpecifiedFirstAbility' || want.abilityName === 'SpecifiedSecondAbility') {
      // 返回的字符串KEY标识为自定义拼接的字符串内容
      if (want.parameters) {
        return `SpecifiedAbilityInstance_${want.parameters.instanceKey}`;
      }
    }
    // 仅specified模式下触发
    return "onAcceptWant"
  }
  // onNewProcessRequest(want: Want): string;
  onNewProcessRequest(want: Want): string {
    Logger.info('[AbilityStage]', 'MyAbilityStage onNewProcessRequest');
    return "onNewProcessRequest"
  }
  // onConfigurationUpdate(newConfig: Configuration): void;
  onConfigurationUpdate(newConfig: Configuration): void {
    hilog.info(DOMAIN_NUMBER, TAG, `onConfigurationUpdate, language: ${newConfig.language}`);
    hilog.info(DOMAIN_NUMBER, TAG, `onConfigurationUpdated systemLanguage is ${systemLanguage}, newConfig: ${JSON.stringify(newConfig)}`);

    if (systemLanguage !== newConfig.language) {
      hilog.info(DOMAIN_NUMBER, TAG, `systemLanguage from ${systemLanguage} changed to ${newConfig.language}`);
      systemLanguage = newConfig.language; // 将变化之后的系统语言保存，作为下一次变化前的系统语言
    }
    Logger.info('[AbilityStage]', 'MyAbilityStage onConfigurationUpdate');
  }
  // onMemoryLevel(level: AbilityConstant.MemoryLevel): void;
  onMemoryLevel(level: AbilityConstant.MemoryLevel): void {
    // 根据系统可用内存的变化情况，释放不必要的内存
    Logger.info('[AbilityStage]', 'MyAbilityStage onMemoryLevel');
  }
  // onDestroy(): void;
  onDestroy(): void {
    Logger.info('[AbilityStage]', 'MyAbilityStage onDestroy');
  }
  // onPrepareTermination(): AbilityConstant.PrepareTermination;
  // onPrepareTerminationAsync(): Promise<AbilityConstant.PrepareTermination>;
}

let systemLanguage: string | undefined; // 系统当前语言