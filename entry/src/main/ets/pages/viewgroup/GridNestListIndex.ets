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

import { router } from '@kit.ArkUI';
import { CommonConstants, ScrollPosition } from '../../common/CommonConstants';
import { ListDataConstants } from '../../common/ListDataConstants';
import GridComponent from './GridComponent';
import { featureGridData, GridData, otherGridDataList } from '../../model/GridListDataSources';
import Logger from '../../common/Logger';
import Constants from '../../common/Constants';

@Entry
@Component
struct GridNestListIndex {
  //0 for scrolling to the top of the list, 1 for the middle value, and 2 for scrolling to the bottom of the list.
  @State listPosition: number = ScrollPosition.start;
  //0 for scrolling to the top of the page, 1 for the middle value, and 2 for scrolling to the bottom of the page.
  @State scrollPosition: number = ScrollPosition.start;
  @State currentIndex: number = 0;
  private scrollerForScroll: Scroller = new Scroller();
  private scrollerForList: Scroller = new Scroller();
  private scrollerForTitle: Scroller = new Scroller();

  build() {
    Column() {
      Row() {
        Image($r('app.media.icon_back'))
          .height($r('app.float.image_height'))
          .onClick(() => {
            this.getUIContext().getRouter().back();
          })

        Text($r('app.string.page_title'))
          .fontSize($r('app.float.page_title_font_size'))
          .fontWeight(FontWeight.Bold)
          .margin({ left: $r('app.float.page_title_left_margin') })
      }
      .padding({ left: $r('app.float.title_padding') })
      .width(CommonConstants.FULL_PERCENT)
      .height($r('app.float.page_title_height'))

      Stack({ alignContent: Alignment.Top }) {
        Scroll(this.scrollerForScroll) {
          Column() {
            GridComponent({ gridData: featureGridData })
            this.tabHeaderBuilder();
            List({ scroller: this.scrollerForList }) {
              ForEach(otherGridDataList, (item: GridData, index: number) => {
                GridComponent({ gridData: item, isLastItem: index === otherGridDataList.length - 1 })
              }, (item: GridData,index:number) =>index+JSON.stringify(item))
            }
            .padding({ bottom: $r('app.float.list_bottom_padding') })
            .width(CommonConstants.FULL_PERCENT)
            .edgeEffect(EdgeEffect.None)
            .scrollBar(BarState.Off)
            // Triggers when the start position is reached.
            .onReachStart(() => { // 到顶
              Logger.debug('GridNestListIndex', `onReachStart`)
              this.listPosition = ScrollPosition.start;
            })
            // Triggers when the end position is reached.
            .onReachEnd(() => { // 到底
              Logger.debug('GridNestListIndex', `onReachEnd`)
              this.listPosition = ScrollPosition.end;
            })
            // Obtains the index value of the first subcomponent in the display area of the List component.
            .onScrollIndex((start: number) => { // 滑动到当前index
              Logger.debug('GridNestListIndex', `onScrollIndex start=>${start}`)
              this.currentIndex = start
              this.scrollerForTitle.scrollToIndex(this.currentIndex);
            })
            .onScrollFrameBegin((offset: number) => { // 从点击开始滑动的距离offset
              Logger.debug('GridNestListIndex', `onScrollFrameBegin offset=>${offset}`)
              if (this.currentIndex === ListDataConstants.TITLE_LIST.length - 1 && offset > 0) {
                return { offsetRemain: 0 }
              }
              // When sliding to the middle of the list. offset>0上滑, offset<0下滑.
              // 在中间部分滑动
              if (!((this.listPosition === ScrollPosition.start && offset < 0) || (this.listPosition === ScrollPosition.end && offset > 0))) {
                this.listPosition = ScrollPosition.center;
              }
              // If the page has scrolled to the bottom, the list is not at the top or the list has a positive offset
              //
              if (this.scrollPosition === ScrollPosition.end && (this.listPosition != ScrollPosition.start || offset > 0)) {
                return { offsetRemain: offset };
              } else {
                this.scrollerForScroll.scrollBy(0, offset) // Scroll也跟着滑动
                return { offsetRemain: offset };
              }
            })
            .width(CommonConstants.FULL_PERCENT)
            .height("calc(100% - 56vp)") // 56vp是ListTitle的高度
          }
        }
        .scrollBar(BarState.Off)
        .width(CommonConstants.FULL_PERCENT)
        .height(CommonConstants.FULL_PERCENT)
        .onWillScroll((yOffset: number) => {
          // Logger.debug('GridNestListIndex', `onWillScroll=>${yOffset}`)
          // If the page is not at the top or bottom, it is in the middle.
          if (!((this.scrollPosition === ScrollPosition.start && yOffset < 0)
            || (this.scrollPosition === ScrollPosition.end && yOffset > 0))) {
            this.scrollPosition = ScrollPosition.center;
            // Logger.debug('GridNestListIndex', `onWillScroll(this.scrollPosition = ScrollPosition.center;)=>${yOffset}`)
          }
        })
        .onScrollEdge((side: Edge) => {
          // Logger.debug('GridNestListIndex', `onScrollEdge=>${JSON.stringify(side)}`)
          if (side === Edge.Top) {
            // Page is at the top
            Logger.debug('GridNestListIndex', `onScrollEdge(side === Edge.Top)=>${JSON.stringify(side)}`)
            this.scrollPosition = ScrollPosition.start;
          } else if (side === Edge.Bottom) {
            Logger.debug('GridNestListIndex', `onScrollEdge(side === Edge.Bottom)=>${JSON.stringify(side)}`)
            // Page is at the bottom
            this.scrollPosition = ScrollPosition.end;
          }
        })
        .onScrollFrameBegin(offset => {
          Logger.debug('GridNestListIndex', `onScrollFrameBegin=>${JSON.stringify(offset)}`)
          if (this.scrollPosition === ScrollPosition.end) {
            Logger.debug('GridNestListIndex', `onScrollFrameBegin(this.scrollPosition === ScrollPosition.end)=>${JSON.stringify(offset)}`)
            return { offsetRemain: 0 };
          } else {
            Logger.debug('GridNestListIndex', `onScrollFrameBegin!!!!!!(this.scrollPosition === ScrollPosition.end)=>${JSON.stringify(offset)}`)
            return { offsetRemain: offset };
          }
        })
      }
      .width(CommonConstants.FULL_PERCENT)
      .height(CommonConstants.FULL_PERCENT)
    }
    .backgroundColor($r('app.color.main_page_color'))
  }

  @Builder
  tabHeaderBuilder() {
    Row() {
      List({ space: CommonConstants.LIST_SPACE_SIZE, scroller: this.scrollerForTitle }) {
        ForEach(ListDataConstants.TITLE_LIST, (item: string, index) => {
          ListItem() {
            Column() {
              Text(item)
                .fontColor(this.currentIndex === index ? $r('app.color.isChick_title_color') :
                $r('app.color.noChick_title_color'))
                .fontSize($r('app.float.title_list_item_font_size'))
                .fontWeight(this.currentIndex === index ? FontWeight.Bold : FontWeight.Normal)
                .margin({ top: $r('app.float.title_list_top_margin') })

              if (this.currentIndex === index) {
                Divider()
                  .color($r('app.color.isChick_title_color'))
                  .strokeWidth(CommonConstants.DIVIDER_STROKE_WIDTH)
                  .width($r('app.float.divider_width'))
                  .margin({ top: $r('app.float.divider_top_margin') })
              }
            }
            .justifyContent(FlexAlign.Center)
            .onClick(() => {
              this.scrollerForList.scrollToIndex(index);
              // 以下似乎可以不用设置，因为Scroll有关联
              // this.scrollerForScroll.scrollEdge(Edge.Bottom);
              // this.scrollerForTitle.scrollToIndex(index);
              // this.currentIndex = index;
            })
          }
        }, (item: string, index: number) => index + JSON.stringify(item))
      }
      .width(CommonConstants.FULL_PERCENT)
      .height($r('app.float.title_list_height'))
      .listDirection(Axis.Horizontal)
      .scrollBar(BarState.Off)
    }
    .margin({ top: $r('app.float.title_list_top_margin') })
    .padding({ left: $r('app.float.title_list_padding'), right: $r('app.float.title_list_padding') })
  }
}
