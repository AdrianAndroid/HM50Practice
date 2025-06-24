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

import { BreakpointConstants } from '../../constants/BreakpointConstants';
import { EditorComponent } from '../../view/RichEditorContentPublisherEditorComponent';
import { CommonConstants } from '../../constants/CommonConstants';
import { BottomToolbar } from '../../view/RichEditorContentPublisherToolbar';
import { TopArea } from '../../view/RichEditorContentPublisherTopArea';
import { TitleInfo } from '../../model/RichEditorContentPublisherCommonModel';
import { AddPic } from '../../view/RichEditorContentPublisherAddPic';
import Constants from '../../common/Constants';

@Entry
@Component
struct RichEditorContentPublisherHome {
  @Provide currentBreakpoint: string = BreakpointConstants.BREAKPOINT_LG;
  // Title information of the selected image-text combination.
  @Provide titleInfo: TitleInfo = new TitleInfo('', '');
  // Selected topic information.
  @Provide topicInfo: string = '';
  // Whether to display the current information list.
  @State isShowLocalInfo: boolean = false;
  // Whether to display the information about adding a local device.
  @State isAddLocalInfo: boolean = false;
  // Display the current location information after selecting.
  @State selectLocalInfo: string = '';
  // Whether to display the graphic icon. Otherwise, the keyboard icon is displayed.
  @State isShowGraphicTitle: boolean = false;
  // Whether to display the soft keyboard.
  @State isKeyboard: boolean = false;
  // Whether to display the bottom toolbar.
  @State isShowToolbar: boolean = true;

  changeFocus(isAllClose: boolean): void {
    if (isAllClose) {
      // Soft keyboard loses focus.
      focusControl.requestFocus(CommonConstants.TEXT_ID);
      // Hide graphic content.
      this.isShowGraphicTitle = false;
    } else {
      if (this.isKeyboard) {
        // Obtaining the Focus of the Soft Keyboard.
        focusControl.requestFocus(CommonConstants.TITLE_ID);
        // Hide graphic content.
        this.isShowGraphicTitle = false;
      } else {
        // Soft keyboard loses focus.
        focusControl.requestFocus(CommonConstants.TEXT_ID);
        // Display graphic content.
        this.isShowGraphicTitle = true;
      }
    }
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
        Stack({ alignContent: Alignment.Bottom }) {
          Flex({ direction: FlexDirection.Column }) {
            // Top area.
            TopArea()
            // Focus-obtaining area.
            Text('')
              .focusOnTouch(true)
              .focusable(true)
              .id(CommonConstants.TEXT_ID)
            // Image area.
            AddPic()
            // Text editing area.
            EditorComponent({
              isShowToolbar: this.isShowToolbar,
              isShowGraphicTitle: this.isShowGraphicTitle,
              isKeyboard: this.isKeyboard,
              isShowLocalInfo: this.isShowLocalInfo
            })
            // Bottom zone.
            Row() {

            }
            .backgroundColor(Color.Green)
            .width(Constants.FULL_PERCENT)
            .height(100)
            // BottomToolbar({
            //   isAddLocalInfo: this.isAddLocalInfo,
            //   selectLocalInfo: this.selectLocalInfo,
            //   isShowLocalInfo: this.isShowLocalInfo,
            //   isShowGraphicTitle: this.isShowGraphicTitle,
            //   isKeyboard: this.isKeyboard,
            //   isShowToolbar: this.isShowToolbar,
            //   currentBreakpoint: this.currentBreakpoint,
            //   changeFocus: (isAllClose: boolean) => {
            //     this.changeFocus(isAllClose);
            //   }
            // })
          }
        }
        .height(CommonConstants.FULL_PERCENT)
        .width(CommonConstants.FULL_PERCENT)
      }
    }
    .height(CommonConstants.FULL_PERCENT)
    .width(CommonConstants.FULL_PERCENT)
    .onBreakpointChange((breakPoints) => {
      this.currentBreakpoint = breakPoints;
    })
  }
}