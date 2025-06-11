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

export default class MyAbilityStage extends AbilityStage {
  onCreate() {
    Logger.info('[AbilityStage]', 'MyAbilityStage onCreate');
  }


  // onAcceptWant(want: Want): string;
  onAcceptWant(want: Want): string {
    Logger.info('[AbilityStage]', 'MyAbilityStage onAcceptWant');
    return "onAcceptWant"
  }
  // onNewProcessRequest(want: Want): string;
  onNewProcessRequest(want: Want): string {
    Logger.info('[AbilityStage]', 'MyAbilityStage onNewProcessRequest');
    return "onNewProcessRequest"
  }
  // onConfigurationUpdate(newConfig: Configuration): void;
  onConfigurationUpdate(newConfig: Configuration): void {
    Logger.info('[AbilityStage]', 'MyAbilityStage onConfigurationUpdate');
  }
  // onMemoryLevel(level: AbilityConstant.MemoryLevel): void;
  onMemoryLevel(level: AbilityConstant.MemoryLevel): void {
    Logger.info('[AbilityStage]', 'MyAbilityStage onMemoryLevel');
  }
  // onDestroy(): void;
  onDestroy(): void {
    Logger.info('[AbilityStage]', 'MyAbilityStage onDestroy');
  }
  // onPrepareTermination(): AbilityConstant.PrepareTermination;
  // onPrepareTerminationAsync(): Promise<AbilityConstant.PrepareTermination>;
}