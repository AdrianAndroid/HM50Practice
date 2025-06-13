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

import preferenceUtilsObject from "../common/database/PreferencesUtil";

@CustomDialog
export struct SliderCustomDialog {
  @StorageLink('fontSizeOffset') fontSizeOffset: number = 4;
  @State currentValue: number = 0;
  SliderCustomDialogController?: CustomDialogController;

  build() {
    Column() {
      Text($r('app.string.fontsize_change'))
        .font({
          size: '20fp',
          weight: 700
        })
        .textAlign(TextAlign.Center)
        .opacity(0.9)
        .width('312vp')
        .height('27vp')
        .margin({
          top: '15vp',
          bottom: '15vp',
          left: '24vp',
          right: '24vp'
        })
      Row() {
        Text('A')
          .font({
            size: '12fp',
            weight: 700
          })
          .margin({ right: '4vp' })
        Slider({
          value: this.fontSizeOffset,
          min: -4,
          max: 4,
        })
          .margin({ right: '4vp' })
          .width('304vp')
          .onChange((data: number) => {
            this.currentValue = data;
          })
        Text('A')
          .font({
            size: '20fp',
            weight: 700
          })
      }

      Row() {
        Button($r('app.string.Cancel'))
          .width('156vp')
          .height('41vp')
          .margin({
            left: '16vp',
            right: '16vp'
          })
          .backgroundColor('#0d000000')
          .fontColor('#0A59F7')
          .onClick(() => {
            this.SliderCustomDialogController?.close();
          })
        Button($r('app.string.Confirmed'))
          .width('156vp')
          .height('41vp')
          .margin({ right: '16vp' })
          .onClick(() => {
            preferenceUtilsObject.saveChangeFontSize(this.currentValue);
            this.fontSizeOffset = this.currentValue;
            this.SliderCustomDialogController?.close();
          })
      }
      .width('100%')
      .margin({
        top: '15vp',
        bottom: '15vp'
      })
    }
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .width('360vp')
    .backgroundColor('#ffffff')
    .borderRadius('16vp')
  }
}