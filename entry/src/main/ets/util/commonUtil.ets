/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License,Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import { hilog } from '@kit.PerformanceAnalysisKit';

const TAG = 'commonUtils';

export function getResourceString(resource: Resource, context: Context): string {
  let result: string = '';
  try {
    result = context.resourceManager.getStringSync(resource.id);
  } catch (e) {
    hilog.error(0x0000, TAG, `[getResourceString]getStringSync failed, error:${JSON.stringify(e)}.`);
  }
  return result;
}
// const isHarmonyOS = () => /OpenHarmony/i.test(navigator.userAgent);
// const matches = navigator.userAgent.match(/OpenHarmony (\d+\.?\d*)/);
// matches?.length && Number(matches[1]) >= 5;
// 检测是否为手机设备
// const isPhone = () => /Phone/i.test(navigator.userAgent);
// // 检测是否为平板设备
// const isTablet = () => /Tablet/i.test(navigator.userAgent);
// // 检测是否为2in1设备
// const is2in1 = () => /PC/i.test(navigator.userAgent);