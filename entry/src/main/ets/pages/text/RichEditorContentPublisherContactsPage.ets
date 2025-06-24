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

import { ComposeTitleBar, router } from '@kit.ArkUI';
import { CommonConstants } from '../../constants/CommonConstants';
import { BreakpointConstants } from '../../constants/BreakpointConstants';
import { ContactGroup, ContactInfo } from '../../model/RichEditorContentPublisherCommonModel';
import Logger from '../../common/Logger';

@Entry
@Component
struct RichEditorContentPublisherContactsPage {
  @State stabIndex: number = 0;
  @State changeValue: string = '';
  @State currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  private scroller: Scroller = new Scroller();

  getResourceString(resource: Resource | string): string {
    let resourceString: string = '';
    if (typeof resource === 'string') {
      resourceString = resource;
    } else {
      try {
        resourceString = this.getUIContext().getHostContext()!.resourceManager.getStringSync(resource.id);
      } catch (error) {
        Logger.error('getResourceString err:' + JSON.stringify(error));
      }
    }
    return resourceString;
  }

  build() {
    GridRow({
      columns: {
        sm: BreakpointConstants.GRID_ROW_COLUMNS[0],
        md: BreakpointConstants.GRID_ROW_COLUMNS[1],
        lg: BreakpointConstants.GRID_ROW_COLUMNS[2]
      }
    }) {
      GridCol({
        span: {
          sm: BreakpointConstants.GRID_COLUMN_SPANS[0],
          md: BreakpointConstants.GRID_COLUMN_SPANS[1],
          lg: BreakpointConstants.GRID_COLUMN_SPANS[2]
        }
      }) {
        Column() {
          ComposeTitleBar({ title: $r('app.string.contact') })
          Stack({ alignContent: Alignment.End }) {
            Flex({ direction: FlexDirection.Column }) {
              List({ initialIndex: CommonConstants.INDEX_START_POSITION, scroller: this.scroller }) {
                ForEach(CommonConstants.CONTACT_DATA, (index: ContactGroup) => {
                  ListItem() {
                    Flex({ direction: FlexDirection.Column }) {
                      Text(`${this.getResourceString(index.title)}`)
                        .height($r('app.integer.contact_list_size'))
                        .fontSize($r('app.integer.text_size_body1'))
                        .fontColor($r('app.color.font_color6'))
                        .width(CommonConstants.FULL_PERCENT)
                        .backgroundColor($r('app.color.background_color1'))
                        .padding({ left: $r('app.integer.comm_padding_margin') })
                      Column() {
                        ForEach(index.contact, (item: ContactInfo) => {
                          Flex({ alignItems: ItemAlign.Center }) {
                            Image($r(item.imgName))
                              .width($r('app.integer.contact_list_size'))
                              .height($r('app.integer.contact_list_size'))
                              .borderRadius($r('app.integer.border_radius8'))
                              .margin({
                                right: $r('app.integer.comm_padding_margin'),
                                left: $r('app.integer.comm_padding_margin')
                              })
                            Text(item.name)
                              .fontSize($r('app.integer.text_size_body1'))
                          }
                          .onClick(() => {
                            AppStorage.setOrCreate('contactName', this.getResourceString(item.name));
                            this.getUIContext().getRouter().back({ url: CommonConstants.ROUTE_BACK_HOME_URL });
                          })
                          .width(CommonConstants.FULL_PERCENT)
                          .margin({
                            top: $r('app.integer.comm_padding_margin1'),
                            bottom: $r('app.integer.comm_padding_margin1')
                          })
                        }, (item: string, index: number) => JSON.stringify(item + index))
                      }
                      .borderRadius((this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
                        $r('app.integer.border_radius8') : $r('app.integer.not_border_radius')))
                      .backgroundColor($r('app.color.default_white_background'))
                    }
                  }
                  .width(this.currentBreakpoint !== BreakpointConstants.BREAKPOINT_LG ?
                    CommonConstants.FULL_PERCENT : CommonConstants.CONTACTS_PAGE_WIDTH_LG)
                }, (item: string, index: number) => JSON.stringify(item + index))
              }
              .width(CommonConstants.FULL_PERCENT)
              .alignListItem(ListItemAlign.Center)
              .padding({ bottom: $r('app.integer.contact_list_padding') })
              .edgeEffect(EdgeEffect.None)
              .listDirection(Axis.Vertical)
              .scrollBar(BarState.Off)
              .onScrollIndex((firstIndex: number) => {
                this.stabIndex = firstIndex;
              })
            }

            AlphabetIndexer({ arrayValue: CommonConstants.TAB_VALUE, selected: this.stabIndex })
              .height(CommonConstants.FULL_PERCENT)
              .selectedColor($r('app.color.background_color3'))
              .popupColor($r('app.color.popup_color'))
              .popupBackground($r('app.color.background_color1'))
              .usingPopup(true)
              .alignStyle(IndexerAlign.Right)
              .itemSize(CommonConstants.ALPHABET_INDEXER_ITEM_SIZE)
              .popupPosition({
                x: $r('app.integer.popup_position_x'),
                y: $r('app.integer.popup_position_y')
              })
              .selectedFont({
                size: $r('app.integer.selected_font_size'),
                weight: FontWeight.Bolder
              })
              .popupFont({
                size: $r('app.integer.popup_font_size'),
                weight: FontWeight.Bolder
              })
              .onSelect((tabIndex: number) => {
                this.scroller.scrollToIndex(tabIndex);
              })
          }
          .backgroundColor($r('app.color.background_color1'))
        }
        .width(CommonConstants.FULL_PERCENT)
        .height(CommonConstants.FULL_PERCENT)
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
      }
    }
    .onBreakpointChange((breakPoints) => {
      this.currentBreakpoint = breakPoints;
    })
  }
}