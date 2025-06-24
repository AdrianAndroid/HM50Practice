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

import Logger from '../common/Logger';
import { CommonConstants } from '../constants/CommonConstants';
import { TopicInfo, TopicInfoList } from '../model/RichEditorContentPublisherCommonModel';

/**
 * Topic content subcomponent.
 */
@Component
export struct TopicContentComponent {
  @Consume topicInfo: ResourceStr;
  @Prop topicInfoList: TopicInfoList;
  public closeSheet: () => void = () => {
  };

  getResourceString(resource: Resource): string {
    let resourceString: string = '';
    try {
      resourceString = this.getUIContext().getHostContext()!.resourceManager.getStringSync(resource.id);
    } catch (error) {
      Logger.error('getResourceString err:' + JSON.stringify(error));
    }
    return resourceString;
  }

  build() {
    Column() {
      Text(this.topicInfoList.title)
        .fontColor($r('app.color.font_color4'))
        .fontSize($r('app.integer.text_size_body2'))
        .width(CommonConstants.FULL_PERCENT)
        .height($r('app.integer.topic_info_height'))
      ForEach(this.topicInfoList.topicInfo, (item: TopicInfo) => {
        Row() {
          Row() {
            Image($r('app.media.ic_topic_pop'))
              .width($r('app.integer.topic_pop_icon_size'))
              .height($r('app.integer.topic_pop_icon_size'))
              .margin({ right: $r('app.integer.comm_padding_margin_mini') })
            Text(this.getResourceString(item.title) + item.topicId)
              .fontSize($r('app.integer.text_size_body1'))
              .fontWeight(FontWeight.Bold)
          }

          Text(item.viewCount + this.getResourceString($r('app.string.reading')))
            .fontSize($r('app.integer.text_size_body2'))
            .fontColor($r('app.color.font_color5'))
            .fontWeight(FontWeight.Medium)
        }
        .width(CommonConstants.FULL_PERCENT)
        .height($r('app.integer.topic_info_height'))
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)
        .onClick(() => {
          this.topicInfo = this.getResourceString(item.title) + item.topicId;
          this.closeSheet();
        })
      }, (item: string, index: number) => JSON.stringify(item + index))
    }
    .width(CommonConstants.FULL_PERCENT)
  }
}