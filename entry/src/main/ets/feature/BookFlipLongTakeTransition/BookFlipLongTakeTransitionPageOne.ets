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

import { ComponentAttrUtils, RectInfoInPx } from '../../utils/commonutils/TCComponentAttrUtils';
import TCConstants from '../../common/TCConstants';
import { CustomTransition } from '../../utils/customtransition/TCCustomNavigationUtils';
import {
  PrePageInteractiveTransitionProperties
} from '../../utils/customtransition/TCPrePageInteractiveTransitionProperties';
import { TCConstantsWindowUtils } from '../../utils/windowutils/TCConstantsWindowUtils';
import { getResourceString } from '../../utils/commonutils/TCResourceString';

@Builder
export function BookFlipLongTakeTransitionPageOneBuilder() {
  BookFlipLongTakeTransitionPageOne()
}

interface BookItem {
  id: string;
  timestamp: number;
  coverImageUrl: string;
}

@Component
export struct BookFlipLongTakeTransitionPageOne {
  @State dataSource: BookItem[] = new Array(3);
  @State columnWidth: Length = 0;
  @State columnType: string = '';
  @State interactiveTransitionProperties: PrePageInteractiveTransitionProperties =
    new PrePageInteractiveTransitionProperties();
  private pageInfos: NavPathStack = new NavPathStack();
  private pageId: string = '';
  private recentData: BookItem[] = new Array(3);
  private swiperController: SwiperController = new SwiperController();

  aboutToAppear(): void {
    this.updateColumnData();
    for (let i = 2; i >= 0; i--) {
      this.dataSource[i] = {
        id: `book_${i}`,
        timestamp: Number(new Date()),
        coverImageUrl: `app.media.book_cover_${i}`
      }
    }

    for (let i = 0; i < 4; i++) {
      this.recentData[i] = {
        id: `recent_book_${i}`,
        coverImageUrl: `app.media.book_cover_${i}`,
        timestamp: Number(new Date())
      }
    }
  }

  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 12 }) {
          // A mirror returns to the first position.
          Grid() {
            ForEach(this.dataSource, (item: BookItem, index: number) => {
              GridItem() {
                Image($r(item.coverImageUrl))
                  .id(item.id)
                  .width('100%')
                  .onClick(() => {
                    this.onColumnClicked(item.id, item.coverImageUrl, this.dataSource[0].id, () => {
                      this.dataSource.sort((a, b) => b.timestamp - a.timestamp);
                    })
                    this.dataSource[index].timestamp = Number(new Date());
                  })
              }
              .width(this.columnWidth)
            }, (item: BookItem) => JSON.stringify(item))
          }
          .padding({
            left: 12,
            right: 12,
            top: 12
          })
          .columnsTemplate(this.columnType)
          .columnsGap(10)
          .rowsGap(10)

          // A mirror is returned to its original position.
          Column({ space: 12 }) {
            Text('Recently read')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(Color.Gray)
            Swiper(this.swiperController) {
              ForEach(this.recentData, (item: BookItem) => {
                GridItem() {
                  Image($r(item.coverImageUrl))
                    .id(item.id)
                    .onClick(() => {
                      this.onColumnClicked(item.id, item.coverImageUrl);
                    })
                }
              }, (item: BookItem) => JSON.stringify(item))
            }
            .indicator(false)
            .displayCount(3)
            .loop(false)
            .itemSpace(10)
          }
          .padding({
            left: 12,
            right: 12
          })
          .alignItems(HorizontalAlign.Start)
        }
      }
    }
    // [StartExclude onColumnClicked_start]
    .padding({ top: this.getUIContext().px2vp(TCConstantsWindowUtils.topAvoidAreaHeight_px) })
    .backgroundColor(TCConstants.DEFAULT_BG_COLOR)
    .title(getResourceString(this.getUIContext(), $r('app.string.bookshelf'), this))
    .onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack;
      if (context.navDestinationId) {
        this.pageId = context.navDestinationId;
      }
      TCConstantsWindowUtils.window.setWindowLayoutFullScreen(true);
    })
    .onBackPressed(() => {
      TCConstantsWindowUtils.window.setWindowLayoutFullScreen(false);
      this.pageInfos.pop();
      return true;
    })

    // [EndExclude onColumnClicked_start]
  }

  private updateColumnData(): void {
    let currentBreakpoint: string | undefined = AppStorage.get('currentBreakpoint');
    if (currentBreakpoint === 'xs' || currentBreakpoint === 'sm') {
      this.columnType = '1fr 1fr 1fr';
      this.columnWidth = '33.3%';
    } else if (currentBreakpoint === 'md') {
      this.columnType = '1fr 1fr 1fr 1fr';
      this.columnWidth = '25%';
    } else {
      this.columnType = '1fr 1fr 1fr 1fr 1fr';
      this.columnWidth = '20%';
    }
  }

  // [Start onColumnClicked_start]
  private onColumnClicked(bookId: string, bookCoverUrl: string, toBookId?: string, prePageCallback?: () => void): void {
    CustomTransition.getInstance().unRegisterNavParam(this.pageId);
    const fromCardItemInfo: RectInfoInPx =
      ComponentAttrUtils.getRectInfoById(TCConstantsWindowUtils.window.getUIContext(), bookId);
    let param: Record<string, Object> = {};
    param['fromCardItemInfo'] = fromCardItemInfo;
    param['bookCoverUrl'] = bookCoverUrl;
    if (toBookId) {
      const toCardItemInfo: RectInfoInPx =
        ComponentAttrUtils.getRectInfoById(TCConstantsWindowUtils.window.getUIContext(), toBookId);
      param['toCardItemInfo'] = toCardItemInfo;
    }
    if (prePageCallback) {
      param['prePageCallback'] = prePageCallback;
    }
    this.pageInfos.pushPath({ name: 'BookFlipLongTakeTransitionPageTwo', param: param });
  }

  // [End onColumnClicked_start]
}