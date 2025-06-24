/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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

import { common } from '@kit.AbilityKit';
import { CommonConstants } from '../constants/CommonConstants';

/**
 *  Top area.
 */
@Component
export struct TopArea {
  @State isEdit: boolean = false;

  build() {
    Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
      Row() {
        Row() {
          Image($r('app.media.ic_public_cancel'))
            .width($r('app.integer.cancel_icon_size'))
            .height($r('app.integer.cancel_icon_size'))
            .onClick(() => {
              let context = this.getUIContext().getHostContext() as common.UIAbilityContext;
              context.terminateSelf();
            })
        }
        .justifyContent(FlexAlign.Center)
        .margin({ right: $r('app.integer.cancel_icon_right') })
        .width($r('app.integer.top_area_size'))
        .height($r('app.integer.top_area_size'))
        .backgroundColor($r('app.color.background_color4'))
        .borderRadius($r('app.integer.top_area_radius'))

        Text($r('app.string.text_posts'))
          .fontSize($r('app.integer.text_size_headline8'))
          .fontWeight(FontWeight.Bold)
      }

      Row() {
        Text($r('app.string.text_publish'))
          .fontSize($r('app.integer.text_size_body3'))
          .textAlign(TextAlign.Center)
          .fontColor($r('app.color.default_white_background'))
      }
      .justifyContent(FlexAlign.Center)
      .borderRadius($r('app.integer.border_radius5'))
      .width($r('app.integer.text_publish_width'))
      .height($r('app.integer.text_publish_height'))
      .backgroundColor(this.isEdit ? $r('app.color.background_color2') : $r('app.color.background_color3'))
      .onClick(() => {
        this.isEdit = !this.isEdit;
      })
    }
    .width(CommonConstants.FULL_PERCENT)
    .height($r('app.integer.top_area_height'))
    .padding({
      right: $r('app.integer.comm_padding_margin'),
      left: $r('app.integer.comm_padding_margin')
    })
    .margin({
      top: $r('app.integer.comm_padding_margin'),
      bottom: $r('app.integer.comm_padding_margin')
    })
  }
}