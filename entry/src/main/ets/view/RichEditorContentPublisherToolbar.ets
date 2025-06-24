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

import { abilityAccessCtrl, common } from '@kit.AbilityKit';
import { geoLocationManager } from '@kit.LocationKit';
import { i18n } from '@kit.LocalizationKit';
import { CommonConstants } from '../constants/CommonConstants';
import { BreakpointConstants } from '../constants/BreakpointConstants';
import { TopicContentComponent } from './RichEditorContentPublisherTopicContentComponent';
import { GraphicTitleComponent } from './RichEditorContentPublisherGraphicTitleComponent';
import { TopicInfoList } from '../model/RichEditorContentPublisherCommonModel';
import LocationUtil from '../utils/LocationUtil';
import Logger from '../common/Logger';

@Component
export struct BottomToolbar {
  @State currentLocalInfo: ResourceStr[] | geoLocationManager.GeoAddress[] = CommonConstants.CURRENT_LOCAL_INFO;
  @State isShowSheet: boolean = false;
  @State currentLocation: string = '';
  @State isDefaultLocation: boolean = true;
  @Link currentBreakpoint: string;
  @Link isAddLocalInfo: boolean;
  @Link selectLocalInfo: string | Resource;
  @Link isShowLocalInfo: boolean;
  @Link isShowGraphicTitle: boolean;
  @Link isKeyboard: boolean;
  @Link isShowToolbar: boolean;
  private topicInfoList: TopicInfoList[] = CommonConstants.TOPIC_INFO_LIST;
  private context: common.UIAbilityContext = this.getUIContext().getHostContext() as common.UIAbilityContext;
  private latitude: number = 0;
  private longitude: number = 0;
  private locale: string = i18n.System.getAppPreferredLanguage();
  public changeFocus: (isAllClose: boolean) => void = () => {
  };
  private getGeolocation: (location: geoLocationManager.Location) => void = (location: geoLocationManager.Location) => {
    if (this.latitude === location.latitude && this.longitude === location.longitude) {
      return;
    }
    this.latitude = location.latitude;
    this.longitude = location.longitude;
    let reverseGeocodeRequest: geoLocationManager.ReverseGeoCodeRequest = {
      'locale': this.locale.toString().includes('zh') ? 'zh' : 'en',
      'latitude': this.latitude,
      'longitude': this.longitude
    };
    geoLocationManager.getAddressesFromLocation(reverseGeocodeRequest).then(data => {
      Logger.info('GetAddressesFromLocation data :', JSON.stringify(data));
      if (data.length !== 0) {
        this.currentLocalInfo = [];
        data.forEach((item) => {
          this.currentLocalInfo.push(item.placeName!);
          this.currentLocalInfo.push(item.administrativeArea!);
          this.currentLocalInfo.push(item.subAdministrativeArea!);
          this.currentLocalInfo.push(item.subLocality!);
        })
      }
      if (data[0].placeName) {
        this.currentLocation = data[0].placeName;
      }
      this.isDefaultLocation = false;
    }).catch((err: Error) => {
      Logger.error('GetAddressesFromLocation err:' + JSON.stringify(err));
    });
  };

  aboutToAppear(): void {
    this.requestPermissions();
  }

  aboutToDisappear(): void {
    LocationUtil.geolocationOff();
  }

  requestPermissions(): void {
    let atManager = abilityAccessCtrl.createAtManager();
    try {
      atManager.requestPermissionsFromUser(this.context, CommonConstants.REQUEST_PERMISSIONS).then(() => {
        LocationUtil.geolocationOn(this.getGeolocation);
      });
    } catch (err) {
      Logger.error('requestPermissionsFromUser err' + JSON.stringify(err));
    }
  }

  closeSheet(): void {
    this.isShowSheet = false;
  }

  characterElision(): string {
    let str = this.selectLocalInfo as string;
    let length = str.length;
    if (length > CommonConstants.END_SM_LOCAL_INFO && this.currentBreakpoint === BreakpointConstants.BREAKPOINT_SM) {
      return str.substring(CommonConstants.START_MD_LOCAL_INFO, CommonConstants.END_SM_LOCAL_INFO) + CommonConstants.OMITTED_CHARACTER;
    } else if (length > CommonConstants.END_MD_LOCAL_INFO &&
      this.currentBreakpoint === BreakpointConstants.BREAKPOINT_MD) {
      return str.substring(CommonConstants.START_MD_LOCAL_INFO, CommonConstants.END_MD_LOCAL_INFO) + CommonConstants.OMITTED_CHARACTER;
    } else {
      return str;
    }
  }

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
    this.BottomToolbar()
  }

  /**
   * Bottom Toolbar
   */
  @Builder
  BottomToolbar() {
    Column() {
      // Bottom toolbar addition position.
      Column() {
        Row() {
          Image(this.isAddLocalInfo ? $r('app.media.ic_location_blue') : $r('app.media.ic_location'))
            .height($r('app.integer.location_icon_size'))
            .margin({
              left: $r('app.integer.location_icon_left'),
              right: $r('app.integer.location_icon_right')
            })
          Text() {
            Span(this.isAddLocalInfo ? (this.isDefaultLocation ? this.selectLocalInfo : this.characterElision()) : $r('app.string.add_local'))
              .fontSize($r('app.integer.text_size_body3'))
              .fontColor($r('app.color.font_color1'))
              .onClick(() => {
                this.changeFocus(true);
                this.isShowLocalInfo = !this.isShowLocalInfo;
              })
            ImageSpan($r('app.media.ic_public_cancel'))
              .width($r('app.integer.cancel_icon_size_mini'))
              .height($r('app.integer.cancel_icon_size_mini'))
              .margin({
                bottom: $r('app.integer.cancel_icon_bottom'),
                left: $r('app.integer.cancel_icon_left')
              })
              .visibility(this.isAddLocalInfo ? Visibility.Visible : Visibility.None)
              .onClick(() => {
                this.isAddLocalInfo = false;
              })
          }
          .align(Alignment.Top)
          .margin({ right: $r('app.integer.location_row_right') })
        }
        .backgroundColor($r('app.color.background_color4'))
        .height($r('app.integer.location_info_row_height'))
        .borderRadius($r('app.integer.border_radius5'))
      }
      .padding({
        left: $r('app.integer.comm_padding_margin')
      })
      .backgroundColor(Color.White)
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)
      .height($r('app.integer.location_row_height'))
      .width(CommonConstants.FULL_PERCENT)

      // The location information list is added to the toolbar at the bottom.
      Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceBetween }) {
        List({ space: CommonConstants.LIST_COMM_SPACE }) {
          ForEach(this.currentLocalInfo, (item: Resource, index: number) => {
            ListItem() {
              Text(item)
                .backgroundColor($r('app.color.default_white_background'))
                .fontColor($r('app.color.font_color2'))
                .fontSize($r('app.integer.text_size_body3'))
                .borderRadius($r('app.integer.border_radius28'))
                .height($r('app.integer.text_publish_height'))
                .padding({
                  right: $r('app.integer.comm_padding_margin_mini'),
                  left: $r('app.integer.comm_padding_margin_mini')
                })
            }
            .onClick(() => {
              this.isAddLocalInfo = true;
              this.selectLocalInfo = item;
            })
          }, (item: string, index: number) => JSON.stringify(item + index))
        }
        .alignListItem(ListItemAlign.Center)
        .width(CommonConstants.LOCAL_INFO_LIST_WIDTH)
        .listDirection(Axis.Horizontal)
        .scrollBar(BarState.Off)

        Image($r('app.media.ic_public_cancel'))
          .width($r('app.integer.cancel_icon_size_mini1'))
          .height($r('app.integer.cancel_icon_size_mini1'))
          .onClick(() => {
            this.isShowLocalInfo = !this.isShowLocalInfo;
          })
      }
      .visibility(this.isShowLocalInfo ? Visibility.Visible : Visibility.None)
      .borderWidth({
        top: $r('app.integer.default_border_width'),
        bottom: $r('app.integer.default_border_width')
      })
      .borderColor($r('app.color.bottom_border_color'))
      .padding({
        right: $r('app.integer.comm_padding_margin'),
        left: $r('app.integer.comm_padding_margin')
      })
      .height($r('app.integer.location_info_height'))
      .width(CommonConstants.FULL_PERCENT)
      .backgroundColor($r('app.color.background_color1'))

      // Bottom toolbar picture.
      Flex({ justifyContent: FlexAlign.Start, alignItems: ItemAlign.Center }) {
        Image($r('app.media.ic_symbol1'))
          .width($r('app.integer.bottom_icon_size'))
          .height($r('app.integer.bottom_icon_size'))
          .margin({ right: $r('app.integer.comm_padding_margin') })
          .objectFit(ImageFit.Cover)
          .onClick(() => {
            this.getUIContext().getPromptAction().showToast({ message: $r('app.string.trigger_emoji_event') });
          })
        Image(this.isKeyboard ? $r('app.media.ic_symbol2') : $r('app.media.ic_public_keyboard'))
          .focusable(true)
          .width($r('app.integer.bottom_icon_size'))
          .height($r('app.integer.bottom_icon_size'))
          .margin({ right: $r('app.integer.comm_padding_margin') })
          .objectFit(ImageFit.Cover)
          .onClick(() => {
            this.isShowLocalInfo = false;
            this.isKeyboard = !this.isKeyboard;
            this.changeFocus(false);
          })
        Image($r('app.media.ic_symbol3'))
          .width($r('app.integer.bottom_icon_size'))
          .height($r('app.integer.bottom_icon_size'))
          .margin({ right: $r('app.integer.comm_padding_margin') })
          .objectFit(ImageFit.Cover)
          .onClick(() => {
            this.getUIContext().getRouter().pushUrl({ url: CommonConstants.ROUTE_CONTACT_PAGE_URL });
          })
        Image($r('app.media.ic_symbol4'))
          .width($r('app.integer.bottom_icon_size'))
          .height($r('app.integer.bottom_icon_size'))
          .margin({ right: $r('app.integer.comm_padding_margin') })
          .objectFit(ImageFit.Cover)
          .onClick(() => {
            this.isShowSheet = true;
          })
          .bindSheet($$this.isShowSheet, this.SheetTopicComponent(), {
            detents: [SheetSize.LARGE],
            backgroundColor: Color.White,
            blurStyle: BlurStyle.Thick,
            showClose: true,
            title: { title: $r('app.string.topic') },
            preferType: SheetType.CENTER
          })
      }
      .width(CommonConstants.FULL_PERCENT)
      .padding({ left: $r('app.integer.bottom_icon_region_padding') })
      .height($r('app.integer.bottom_icon_region_height'))
      .visibility(this.isShowToolbar ? Visibility.Visible : Visibility.None)

      // Graphic title.
      Row() {
        GraphicTitleComponent()
      }
      .visibility(this.isShowGraphicTitle ? Visibility.Visible : Visibility.None)
    }
    .backgroundColor($r('app.color.background_color1'))
    .justifyContent(FlexAlign.Center)
  }

  // Topic content.
  @Builder
  SheetTopicComponent() {
    Scroll() {
      List() {
        ForEach(this.topicInfoList, (item: TopicInfoList) => {
          ListItem() {
            TopicContentComponent({
              topicInfoList: item,
              closeSheet: () => {
                this.closeSheet();
              }
            })
          }
        }, (item: string, index: number) => JSON.stringify(item + index))
      }
    }
    .width(CommonConstants.FULL_PERCENT)
    .height(CommonConstants.FULL_PERCENT)
    .scrollBar(BarState.Off)
    .padding({
      right: $r('app.integer.comm_padding_margin'),
      left: $r('app.integer.comm_padding_margin')
    })
  }
}