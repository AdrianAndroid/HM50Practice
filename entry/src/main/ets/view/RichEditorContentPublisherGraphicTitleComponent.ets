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

import { BreakpointConstants } from '../constants/BreakpointConstants';
import { CommonConstants } from '../constants/CommonConstants';
import { TitleInfo, TitleInfoList } from '../model/RichEditorContentPublisherCommonModel';

@Component
export struct GraphicTitleComponent {
  @Consume('currentBreakpoint') currentBreakpoint: string;
  @Consume('titleInfo') titleInfo: TitleInfo;
  @State isSelect: boolean = false;
  @State currentIndex: number = -1;
  @State currentSubIndex: number = -1;
  private titleInfoList: TitleInfoList[] = CommonConstants.TITLE_INFO_DATA;

  build() {
    Scroll() {
      Flex({ direction: FlexDirection.Column }) {
        ForEach(this.titleInfoList, (item: TitleInfoList, index: number) => {
          Column() {
            Text(item.title)
              .fontSize($r('app.integer.text_size_body2'))
              .fontColor($r('app.color.font_color6'))
              .fontWeight(FontWeight.Medium)
              .width(CommonConstants.FULL_PERCENT)
              .padding({ left: $r('app.integer.comm_padding_margin') })
              .margin({
                top: $r('app.integer.graphic_title_margin_top'),
                bottom: $r('app.integer.comm_padding_margin_mini')
              })
            Flex({ direction: FlexDirection.Row, justifyContent: FlexAlign.Start, wrap: FlexWrap.Wrap }) {
              ForEach(item.titleInfo, (items: TitleInfo, subIndex: number) => {
                Text() {
                  Span(items.titlePicUrl)
                  Span(items.title)
                }
                .onClick(() => {
                  this.isSelect = !this.isSelect;
                  this.titleInfo = items;
                  this.currentIndex = index;
                  this.currentSubIndex = subIndex;
                })
                .borderWidth($r('app.integer.default_border_width'))
                .borderRadius($r('app.integer.border_radius1'))
                .borderColor(this.currentIndex === index && this.currentSubIndex === subIndex ?
                  $r('app.color.select_border_color') : $r('app.color.default_white_background'))
                .backgroundColor(this.currentIndex === index && this.currentSubIndex === subIndex ?
                  $r('app.color.select_background_color') : $r('app.color.default_white_background'))
                .padding({
                  top: $r('app.integer.comm_padding_margin1'),
                  right: $r('app.integer.comm_padding_margin_mini1'),
                  bottom: $r('app.integer.comm_padding_margin1'),
                  left: $r('app.integer.comm_padding_margin_mini1')
                })
                .margin({
                  top: $r('app.integer.comm_padding_margin_mini'),
                  bottom: $r('app.integer.comm_padding_margin_mini'),
                  left: $r('app.integer.comm_padding_margin')
                })
              }, (item: string, index: number) => JSON.stringify(item + index))
            }
          }
          .width(CommonConstants.FULL_PERCENT)
          .alignItems(HorizontalAlign.Center)
        }, (item: string, index: number) => JSON.stringify(item + index))
      }
    }
    .width(CommonConstants.FULL_PERCENT)
    .borderWidth({ top: $r('app.integer.default_border_width') })
    .borderColor($r('app.color.bottom_border_color'))
    .backgroundColor($r('app.color.background_color1'))
    .scrollBar(BarState.Off)
    .height(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
      $r('app.integer.graphic_title_height_lg') : $r('app.integer.graphic_title_height_other'))
  }
}