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

import { promptAction } from '@kit.ArkUI';
import { fileSelect } from '../utils/FileUtil';
import { CommonConstants } from '../constants/CommonConstants';

/**
 * Image area.
 */
@Component
export struct AddPic {
  @State imageUriArray: Array<ResourceStr> = [];

  /**
   * Select picture method.
   */
  selectImage(): void {
    fileSelect().then((uri: Array<ResourceStr>) => {
      uri.forEach((item: ResourceStr) => {
        this.imageUriArray.push(item);
      });
    });
  }

  build() {
    this.AddPic()
  }

  /**
   *  Adding an image.
   */
  @Builder
  AddPic() {
    Row() {
      List({ space: CommonConstants.LIST_COMM_SPACE }) {
        ForEach(this.imageUriArray, (item: ResourceStr) => {
          ListItem() {
            Image(item)
              .width($r('app.integer.add_image_area_size'))
              .height($r('app.integer.add_image_area_size'))
              .borderRadius($r('app.integer.border_radius3'))
              .visibility(item ? Visibility.Visible : Visibility.None)
          }
        }, (item: ResourceStr, index: number) => JSON.stringify(item) + index)
        this.AddDefaultPic()
      }
      .listDirection(Axis.Horizontal)
      .scrollBar(BarState.Off)
    }
    .height($r('app.integer.add_image_area_size'))
    .width(CommonConstants.FULL_PERCENT)
    .alignItems(VerticalAlign.Center)
    .padding({
      right: $r('app.integer.comm_padding_margin'),
      left: $r('app.integer.comm_padding_margin')
    })
  }

  /**
   * Add default image.
   */
  @Builder
  AddDefaultPic() {
    Row() {
      Column() {
        Image($r('app.media.ic_public_list_add_transparent'))
          .objectFit(ImageFit.Cover)
          .width($r('app.integer.add_icon_size'))
          .height($r('app.integer.add_icon_size'))
        Text(this.imageUriArray.length === 0 ? $r('app.string.add_high_img') : $r('app.string.continue_add'))
          .fontSize($r('app.integer.text_size_body3'))
          .fontColor($r('app.color.add_image_background'))
      }
      .justifyContent(FlexAlign.Center)
      .width(CommonConstants.FULL_PERCENT)
    }
    .borderStyle(BorderStyle.Dashed)
    .borderWidth($r('app.integer.default_border_width'))
    .borderColor($r('app.color.add_image_border_color'))
    .borderRadius($r('app.integer.border_radius3'))
    .width($r('app.integer.add_image_area_size'))
    .height($r('app.integer.add_image_area_size'))
    .margin({
      right: $r('app.integer.add_default_pic_right'),
      bottom: $r('app.integer.add_default_pic_bottom')
    })
    .onClick(() => {
      if (this.imageUriArray.length < CommonConstants.MAX_ADD_PIC) {
        this.selectImage();
      } else {
        this.getUIContext().getPromptAction().showToast({ message: $r('app.string.add_picture_prompt') });
      }
    })
  }
}