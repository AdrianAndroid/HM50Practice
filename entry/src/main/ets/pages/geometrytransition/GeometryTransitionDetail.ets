/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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

// import { GEOMETRY_TRANSITION_ID } from '../../common/constants/CommonConstants';
import { GEOMETRY_TRANSITION_ID } from '../../common/constants/CommonConstants';
import { getResourceString } from '../../util/commonUtil';

@Component
export struct GeometryTransitionDetail {
  @Consume navPageInfos: NavPathStack;

  build() {
    NavDestination() {
      Image($r('app.media.bg_transition'))
        .width('100%')
        .height('60%')
        .margin({ top: 12 })
        .geometryTransition(GEOMETRY_TRANSITION_ID)
    }
    .transition(TransitionEffect.OPACITY)
    .backgroundColor('#F1F3F5')
    .title(getResourceString($r('app.string.title_share_item'), getContext(this)))
    .onBackPressed(() => {
      animateTo({ duration: 600 }, () => {
        this.navPageInfos.pop(false);
      });
      return true;
    })
  }
}