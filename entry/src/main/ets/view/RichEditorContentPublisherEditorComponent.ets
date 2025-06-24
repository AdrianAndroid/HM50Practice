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

import { CommonConstants } from '../constants/CommonConstants';
import { TitleInfo } from '../model/RichEditorContentPublisherCommonModel';

@Component
export struct EditorComponent {
  // Information about the selected contact.
  @StorageProp('contactName') @Watch('contactNameChange') contactName: string = '';
  // Title information of the selected image-text combination
  @Consume @Watch('titleInfoChange') titleInfo: TitleInfo;
  // Selected topic information
  @Consume @Watch('topicInfoChange') topicInfo: string;
  @State currentCursorPosition: number = 0;
  // Whether to display the bottom toolbar.
  @Link isShowToolbar: boolean;
  // Whether to display the teletext title
  @Link isShowGraphicTitle: boolean;
  // Whether to display the teletext title
  @Link isKeyboard: boolean;
  @Link isShowLocalInfo: boolean;
  private richEditorController: RichEditorController = new RichEditorController();
  private richEditorOptions: RichEditorOptions = { controller: this.richEditorController };
  private builderTitle: CustomBuilder = undefined;
  private defaultOffset: number | undefined = undefined;
  private builderTipsContact: CustomBuilder = undefined;
  private builderTopic: CustomBuilder = undefined;

  aboutToAppear(): void {
    this.initBuilderData();
  }

  initBuilderData(): void {
    this.richEditorController.addBuilderSpan(this.builderTitle, { offset: this.defaultOffset });
    this.richEditorController.addBuilderSpan(this.builderTopic, { offset: this.defaultOffset });
    this.richEditorController.addBuilderSpan(this.builderTipsContact, { offset: this.defaultOffset });
    this.builderTitle = (): void => {
      this.titleBuilder(this.titleInfo);
    };
    this.builderTopic = (): void => {
      this.topicBuilder(this.topicInfo);
    };
    this.builderTipsContact = (): void => {
      this.tipsContactBuilder(this.contactName);
    };
  }

  contactNameChange(): void {
    this.richEditorController.addBuilderSpan(this.builderTipsContact, { offset: this.currentCursorPosition });
    this.builderTipsContact = (): void => {
      if (this.contactName.length !== 0) {
        this.tipsContactBuilder(this.contactName);
      }
    };
    this.currentCursorPosition++;
  }

  titleInfoChange(): void {
    this.richEditorController.setCaretOffset(this.currentCursorPosition);
    this.addGraphicTitle();
  }

  topicInfoChange(): void {
    this.richEditorController.setCaretOffset(this.currentCursorPosition);
    this.closeSheet();
  }

  addGraphicTitle(): void {
    this.richEditorController.addBuilderSpan(this.builderTitle, { offset: this.currentCursorPosition });
    this.builderTitle = (): void => {
      this.titleBuilder(this.titleInfo);
    };
    this.currentCursorPosition++;
  }

  closeSheet(): void {
    this.richEditorController.addBuilderSpan(this.builderTopic, { offset: this.currentCursorPosition });
    this.builderTopic = (): void => {
      this.topicBuilder(this.topicInfo);
    };
    this.currentCursorPosition++;
  }

  build() {
    Flex({ direction: FlexDirection.Column }) {
      TextInput({ placeholder: $r('app.string.text_input_placeholder') })
        .onFocus(() => {
          this.isShowToolbar = false;
          this.isShowGraphicTitle = false;
        })
        .width(CommonConstants.FULL_PERCENT)
        .height($r('app.integer.text_input_height'))
        .fontSize($r('app.integer.text_size_body1'))
        .backgroundColor(Color.White)
        .constraintSize({ minHeight: $r('app.integer.text_input_height') })
        .margin({
          top: $r('app.integer.text_input_margin')
        })

      RichEditor(this.richEditorOptions)
        .width(CommonConstants.FULL_PERCENT)
        .height(CommonConstants.FULL_PERCENT)
        .id(CommonConstants.TITLE_ID)
        .placeholder(
          $r('app.string.richEditor_placeholder'),
          { fontColor: $r('app.color.rich_editor_placeholder_color') }
        )
        .onFocus(() => {
          this.isShowToolbar = true;
          this.isKeyboard = true;
          this.isShowGraphicTitle = false;
          this.isShowLocalInfo = false;
        })
        .onSelectionChange((value: RichEditorRange) => {
          this.currentCursorPosition = value.start!;
        })
    }
    .width(CommonConstants.FULL_PERCENT)
    .height($r('app.integer.flex_input_height'))
    .margin({ bottom: $r('app.integer.flex_input_margin') })
    .layoutWeight(CommonConstants.DEFAULT_LAYOUT_WEIGHT)
    .expandSafeArea([SafeAreaType.KEYBOARD])
  }

  /**
   * Build #Topics.
   */
  @Builder
  topicBuilder(topicInfo: string) {
    if (topicInfo.length !== 0) {
      Text(CommonConstants.TOPIC_SYMBOL + topicInfo)
        .fontColor($r('app.color.font_color3'))
    }
  }

  /**
   * Build @ contact.
   */
  @Builder
  tipsContactBuilder(contactName: string) {
    if (contactName.length !== 0) {
      Text(CommonConstants.TIPS_CONTACT_SYMBOL + contactName)
        .fontColor($r('app.color.font_color3'))
        .padding({
          right: $r('app.integer.builder_tips_contact'),
          left: $r('app.integer.builder_tips_contact')
        })
    }
  }

  /**
   * Building a caption.
   */
  @Builder
  titleBuilder(titleInfo: TitleInfo) {
    if (titleInfo.titlePicUrl.length !== 0) {
      Text() {
        Span(titleInfo.titlePicUrl)
        Span(titleInfo.title)
      }
      .fontWeight(FontWeight.Bolder)
    }
  }
}