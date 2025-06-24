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

import { Permissions } from '@kit.AbilityKit';
import { ContactGroup, ContactInfo, TitleInfo, TitleInfoList, TopicInfo, TopicInfoList } from '../model/RichEditorContentPublisherCommonModel';

/**
 * Public constants.
 */
export class CommonConstants {
  /**
   * The request permission.
   */
  static readonly REQUEST_PERMISSIONS: Array<Permissions> = [
    'ohos.permission.APPROXIMATELY_LOCATION',
    'ohos.permission.LOCATION'
  ];

  /**
   * Full percent.
   */
  static readonly FULL_PERCENT: string = '100%';

  /**
   * Contact width on LG devices.
   */
  static readonly CONTACTS_PAGE_WIDTH_LG: string = '60%';

  /**
   * Title ID.
   */
  static readonly TITLE_ID: string = 'titleId';

  /**
   * Text ID.
   */
  static readonly TEXT_ID: string = 'textId';

  /**
   * List comm space.
   */
  static readonly LIST_COMM_SPACE: number = 8;

  /**
   * Maximum number of images that can be added.
   */
  static readonly MAX_ADD_PIC: number = 9;

  /**
   * Local info list width.
   */
  static readonly LOCAL_INFO_LIST_WIDTH: string = '95%';

  /**
   * Route back to the home page url.
   */
  static readonly ROUTE_BACK_HOME_URL: string = 'pages/Home';

  /**
   * URL of the contact page.
   */
  static readonly ROUTE_CONTACT_PAGE_URL: string = 'pages/ContactsPage';

  /**
   * Topic symbol #.
   */
  static readonly TOPIC_SYMBOL: string = '#';

  /**
   * Tips contact symbol @.
   */
  static readonly TIPS_CONTACT_SYMBOL: string = '@';

  /**
   * Default layout weight.
   */
  static readonly DEFAULT_LAYOUT_WEIGHT: number = 1;

  /**
   * Start position of the list when it is loaded for the first time.
   */
  static readonly INDEX_START_POSITION: number = 0;

  /**
   * Alphabetical Index Bar Alphabetical Area Size.
   */
  static readonly ALPHABET_INDEXER_ITEM_SIZE: number = 20;

  /**
   * Last location intercepted from the SM location information.
   */
  static readonly END_SM_LOCAL_INFO: number = 20;

  /**
   * Last location intercepted from the MD location information.
   */
  static readonly END_MD_LOCAL_INFO: number = 40;

  /**
   * Subscript of the number of characters to be truncated at the start of the position information.
   */
  static readonly START_MD_LOCAL_INFO: number = 0;

  /**
   * Omitted character.
   */
  static readonly OMITTED_CHARACTER: string = '...';

  /**
   * Topic information list data.
   */
  static readonly TOPIC_INFO_LIST: TopicInfoList[] = [
    new TopicInfoList(
      [
        new TopicInfo('1', $r('app.string.crowd_theme_contest'), '3520.8'),
        new TopicInfo('2', $r('app.string.crowd_theme_contest'), '3190.8'),
        new TopicInfo('3', $r('app.string.crowd_theme_contest'), '3130.8'),
        new TopicInfo('4', $r('app.string.crowd_theme_contest'), '3020.8'),
        new TopicInfo('5', $r('app.string.crowd_theme_contest'), '2820.8'),
        new TopicInfo('6', $r('app.string.crowd_theme_contest'), '1520.8')
      ], $r('app.string.topic1'), '1'),
    new TopicInfoList(
      [
        new TopicInfo('1', $r('app.string.crowd_theme_contest'), '3520.8'),
        new TopicInfo('2', $r('app.string.crowd_theme_contest'), '3190.8'),
        new TopicInfo('3', $r('app.string.crowd_theme_contest'), '3130.8')
      ], $r('app.string.topic2'), '2'),
    new TopicInfoList(
      [
        new TopicInfo('1', $r('app.string.crowd_theme_contest'), '3520.8'),
        new TopicInfo('2', $r('app.string.crowd_theme_contest'), '3190.8'),
        new TopicInfo('3', $r('app.string.crowd_theme_contest'), '3130.8'),
        new TopicInfo('4', $r('app.string.crowd_theme_contest'), '3020.8'),
        new TopicInfo('5', $r('app.string.crowd_theme_contest'), '2820.8'),
        new TopicInfo('6', $r('app.string.crowd_theme_contest'), '2520.8'),
        new TopicInfo('7', $r('app.string.crowd_theme_contest'), '1828.8'),
        new TopicInfo('8', $r('app.string.crowd_theme_contest'), '1620.8')
      ], $r('app.string.topic3'), '3')
  ];

  /**
   * Teletext list data.
   */
  static readonly TITLE_INFO_DATA: TitleInfoList[] = [
    new TitleInfoList($r('app.string.single_heading'),
      [
        new TitleInfo('📒', $r('app.string.waiting_diary')),
        new TitleInfo('📉', $r('app.string.energy_sharing')),
        new TitleInfo('💔', $r('app.string.fond_teasing')),
        new TitleInfo('💰', $r('app.string.sunning_price')),
        new TitleInfo('💘', $r('app.string.utility_goods')),
        new TitleInfo('📷', $r('app.string.beautiful_life')),
        new TitleInfo('🌹', $r('app.string.love_share'))
      ]),
    new TitleInfoList($r('app.string.combined_head'),
      [
        new TitleInfo('🚗', $r('app.string.retrofit_operation')),
        new TitleInfo('📓', $r('app.string.everyone_reviews'))
      ]),
    new TitleInfoList($r('app.string.composite_head'),
      [
        new TitleInfo('📒', $r('app.string.waiting_diary')),
        new TitleInfo('📉', $r('app.string.energy_sharing')),
        new TitleInfo('💔', $r('app.string.fond_teasing')),
        new TitleInfo('💰', $r('app.string.sunning_price')),
        new TitleInfo('💘', $r('app.string.utility_goods')),
        new TitleInfo('📷', $r('app.string.beautiful_life')),
        new TitleInfo('🚗', $r('app.string.retrofit_operation')),
        new TitleInfo('📓', $r('app.string.everyone_reviews'))
      ])
  ];

  /**
   * Contact list data.
   */
  static readonly CONTACT_DATA: ContactGroup[] = [
    new ContactGroup($r('app.string.recent_contact'), [
      new ContactInfo('app.media.ic_comm_pic1', $r('app.string.name1')),
      new ContactInfo('app.media.ic_comm_pic3', $r('app.string.name3')),
      new ContactInfo('app.media.ic_comm_pic8', $r('app.string.name30')),
      new ContactInfo('app.media.ic_comm_pic6', $r('app.string.name26'))
    ]),
    new ContactGroup('A', [
      new ContactInfo('app.media.ic_comm_pic1', $r('app.string.name1')),
      new ContactInfo('app.media.ic_comm_pic2', $r('app.string.name2')),
      new ContactInfo('app.media.ic_comm_pic3', $r('app.string.name3'))
    ]),
    new ContactGroup('B', [
      new ContactInfo('app.media.ic_comm_pic4', $r('app.string.name4')),
      new ContactInfo('app.media.ic_comm_pic5', $r('app.string.name5')),
      new ContactInfo('app.media.ic_comm_pic6', $r('app.string.name6'))
    ]),
    new ContactGroup('C', [
      new ContactInfo('app.media.ic_comm_pic7', $r('app.string.name7')),
      new ContactInfo('app.media.ic_comm_pic8', $r('app.string.name8')),
      new ContactInfo('app.media.ic_comm_pic9', $r('app.string.name9'))
    ]),
    new ContactGroup('D', [
      new ContactInfo('app.media.ic_comm_pic10', $r('app.string.name10')),
      new ContactInfo('app.media.ic_comm_pic1', $r('app.string.name11')),
      new ContactInfo('app.media.ic_comm_pic2', $r('app.string.name12'))
    ]),
    new ContactGroup('E', []),
    new ContactGroup('F', [
      new ContactInfo('app.media.ic_comm_pic3', $r('app.string.name13')),
      new ContactInfo('app.media.ic_comm_pic4', $r('app.string.name14')),
      new ContactInfo('app.media.ic_comm_pic5', $r('app.string.name15'))
    ]),
    new ContactGroup('G', [
      new ContactInfo('app.media.ic_comm_pic6', $r('app.string.name16')),
      new ContactInfo('app.media.ic_comm_pic7', $r('app.string.name17')),
      new ContactInfo('app.media.ic_comm_pic8', $r('app.string.name18')),
      new ContactInfo('app.media.ic_comm_pic9', $r('app.string.name19'))
    ]),
    new ContactGroup('H', [
      new ContactInfo('app.media.ic_comm_pic10', $r('app.string.name20')),
      new ContactInfo('app.media.ic_comm_pic1', $r('app.string.name21')),
      new ContactInfo('app.media.ic_comm_pic2', $r('app.string.name22')),
      new ContactInfo('app.media.ic_comm_pic3', $r('app.string.name23')),
      new ContactInfo('app.media.ic_comm_pic4', $r('app.string.name24'))
    ]),
    new ContactGroup('I', []),
    new ContactGroup('J', [
      new ContactInfo('app.media.ic_comm_pic5', $r('app.string.name25')),
      new ContactInfo('app.media.ic_comm_pic6', $r('app.string.name26')),
      new ContactInfo('app.media.ic_comm_pic7', $r('app.string.name27'))
    ]),
    new ContactGroup('K', [
      new ContactInfo('app.media.ic_comm_pic8', $r('app.string.name28')),
      new ContactInfo('app.media.ic_comm_pic9', $r('app.string.name29')),
      new ContactInfo('app.media.ic_comm_pic10', $r('app.string.name30'))
    ]),
    new ContactGroup('L', [
      new ContactInfo('app.media.ic_comm_pic1', $r('app.string.name31')),
      new ContactInfo('app.media.ic_comm_pic2', $r('app.string.name32')),
      new ContactInfo('app.media.ic_comm_pic3', $r('app.string.name33'))
    ]),
    new ContactGroup('M', [
      new ContactInfo('app.media.ic_comm_pic4', $r('app.string.name34')),
      new ContactInfo('app.media.ic_comm_pic5', $r('app.string.name35'))
    ]),
    new ContactGroup('N', [
      new ContactInfo('app.media.ic_comm_pic6', $r('app.string.name36')),
      new ContactInfo('app.media.ic_comm_pic7', $r('app.string.name37')),
      new ContactInfo('app.media.ic_comm_pic8', $r('app.string.name38')),
    ]),
    new ContactGroup('O', []),
    new ContactGroup('P', [
      new ContactInfo('app.media.ic_comm_pic9', $r('app.string.name39')),
    ]),
    new ContactGroup('Q', [
      new ContactInfo('app.media.ic_comm_pic10', $r('app.string.name40')),
      new ContactInfo('app.media.ic_comm_pic1', $r('app.string.name41')),
      new ContactInfo('app.media.ic_comm_pic2', $r('app.string.name42')),
    ]),
    new ContactGroup('R', [
      new ContactInfo('app.media.ic_comm_pic3', $r('app.string.name43')),
      new ContactInfo('app.media.ic_comm_pic4', $r('app.string.name44')),
    ]),
    new ContactGroup('S', [
      new ContactInfo('app.media.ic_comm_pic5', $r('app.string.name45')),
      new ContactInfo('app.media.ic_comm_pic6', $r('app.string.name46')),
      new ContactInfo('app.media.ic_comm_pic7', $r('app.string.name47')),
      new ContactInfo('app.media.ic_comm_pic8', $r('app.string.name48')),
    ]),
    new ContactGroup('T', [
      new ContactInfo('app.media.ic_comm_pic9', $r('app.string.name49')),
      new ContactInfo('app.media.ic_comm_pic10', $r('app.string.name50')),
      new ContactInfo('app.media.ic_comm_pic1', $r('app.string.name51')),
    ]),
    new ContactGroup('U', [
      new ContactInfo('app.media.ic_comm_pic2', $r('app.string.name52'))]),
    new ContactGroup('V', [
      new ContactInfo('app.media.ic_comm_pic3', $r('app.string.name53'))]),
    new ContactGroup('W', [
      new ContactInfo('app.media.ic_comm_pic4', $r('app.string.name54')),
      new ContactInfo('app.media.ic_comm_pic5', $r('app.string.name55')),
      new ContactInfo('app.media.ic_comm_pic6', $r('app.string.name56')),
      new ContactInfo('app.media.ic_comm_pic7', $r('app.string.name57'))
    ]),
    new ContactGroup('X', [
      new ContactInfo('app.media.ic_comm_pic8', $r('app.string.name58')),
      new ContactInfo('app.media.ic_comm_pic9', $r('app.string.name59')),
      new ContactInfo('app.media.ic_comm_pic10', $r('app.string.name60')),
      new ContactInfo('app.media.ic_comm_pic1', $r('app.string.name61'))
    ]),
    new ContactGroup('Y', [
      new ContactInfo('app.media.ic_comm_pic2', $r('app.string.name62')),
      new ContactInfo('app.media.ic_comm_pic3', $r('app.string.name63')),
      new ContactInfo('app.media.ic_comm_pic4', $r('app.string.name64')),
      new ContactInfo('app.media.ic_comm_pic5', $r('app.string.name65'))
    ]),
    new ContactGroup('Z', [
      new ContactInfo('app.media.ic_comm_pic6', $r('app.string.name66')),
      new ContactInfo('app.media.ic_comm_pic7', $r('app.string.name67')),
      new ContactInfo('app.media.ic_comm_pic8', $r('app.string.name68')),
      new ContactInfo('app.media.ic_comm_pic9', $r('app.string.name69')),
      new ContactInfo('app.media.ic_comm_pic10', $r('app.string.name70')),
      new ContactInfo('app.media.ic_comm_pic1', $r('app.string.name71')),
      new ContactInfo('app.media.ic_comm_pic2', $r('app.string.name72')),
      new ContactInfo('app.media.ic_comm_pic3', $r('app.string.name73'))
    ])
  ];

  /**
   * AlphabetIndexer alphabetical index bar data.
   */
  static readonly TAB_VALUE: string[] = [
    '#', 'A', 'B', 'C', 'D', 'E', 'F',
    'G', 'H', 'I', 'J', 'K', 'L', 'M',
    'N', 'O', 'P', 'Q', 'R', 'S', 'T',
    'U', 'V', 'W', 'X', 'Y', 'Z'
  ];

  /**
   * Current location information list.
   */
  static readonly CURRENT_LOCAL_INFO: ResourceStr[] = [
    $r('app.string.default_location', 1),
    $r('app.string.default_location', 2),
    $r('app.string.default_location', 3),
    $r('app.string.default_location', 4),
    $r('app.string.default_location', 5),
    $r('app.string.default_location', 6),
    $r('app.string.default_location', 7),
    $r('app.string.default_location', 8),
    $r('app.string.default_location', 9),
    $r('app.string.default_location', 10)
  ];
}