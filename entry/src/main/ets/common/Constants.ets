export default class Constants {
  static readonly EVENT_HUB_1 = 'event1'
  static readonly EVENT_HUB_2 = 'event2'
  static readonly DOMAIN_NUMBER: number = 0xFF00;
  static readonly TAG: string = '[EntryAbility]';

  static readonly PAGES_INDEX = "pages/Index"
  static readonly PAGES_SECOND = "pages/Second"
  static readonly PAGES_PAGE_EVENTHUB = "pages/Page_EventHub"
  static readonly PAGES_Page_UIAbilityComponentsBasicUsage = "pages/Page_UIAbilityComponentsBasicUsage"
  static readonly PAGES_Page_UIAbilityComponentsInteractive = "pages/Page_UIAbilityComponentsInteractive"
  static readonly PAGES_Page_FromStageModel = "pages/Page_FromStageModel"
  static readonly PAGES_LifeCyclePage = 'pages/LifeCyclePage'
  static readonly PAGES_CounterView = 'pages/CounterView'
  static readonly PAGES_Parent = 'pages/Parent'
  static readonly PAGES_ArticleList = 'pages/ArticleList'
  static readonly PAGES_ForEachSort = 'pages/ForEachSort'
  static readonly PAGES_MyComponent = 'pages/MyComponent'
  static readonly PAGES_TextExample = 'pages/TextExample'
  static readonly PAGES_TextInputAreaExample = 'pages/TextInputAreaExample'
  static readonly PAGES_ButtonExample = 'pages/ButtonExample'
  static readonly PAGES_ButtonCase1 = 'pages/ButtonCase1'
  static readonly PAGES_ButtonCase2 = 'pages/ButtonCase2'
  static readonly PAGES_HoverButtonExample = 'pages/HoverButtonExample'
  static readonly PAGES_ToDoListPage = 'pages/ToDoListPage'
  static readonly PAGES_LoginPage = 'pages/LoginPage'
  static readonly PAGES_CityList = 'pages/CityList'
  static readonly PAGES_SimpleContacts = 'pages/SimpleContacts'
  static readonly PAGES_ContactsList = 'pages/ContactsList'
  static readonly PAGES_ToDoList = 'pages/ToDoList'
  static readonly PAGES_TwoDimensionList = 'pages/TwoDimensionList'
  static readonly PAGES_NestedListPage = 'pages/NestedListPage'
  static readonly PAGES_SwiperCustomAnimationExample = 'pages/SwiperCustomAnimationExample'
  static readonly PAGES_GrideNestDemos = 'pages/GrideNestDemos'
  static readonly PAGES_GridNestListIndex = 'pages/GridNestListIndex'
  static readonly PAGES_GridNestSwiperIndex = 'pages/GridNestSwiperIndex'
  static readonly PAGES_GridCalculator = 'pages/GridCalculator'
  static readonly PAGES_GridCalc2 = 'pages/GridCalc2'
  static readonly PAGES_HandleTabsPage = 'pages/HandleTabsPage'
  static readonly PAGES_MultiTabNavigationPage = 'pages/MultiTabNavigationPage'
  static readonly PAGES_NavigationExample = 'pages/NavigationExample'
  static readonly PAGES_NavigationDialogExample = 'pages/NavigationDialogExample'
  static readonly PAGES_SystemRouterMapPage = 'pages/SystemRouterMapPage'
  static readonly PAGES_MVVMPage = 'pages/MVVMPage'
  static readonly PAGES_PreferencesPage = 'pages/PreferencesPage'
  static readonly PAGES_AnimationPage = 'pages/AnimationPage'
  static readonly PAGES_TransitionAnimationPage = 'pages/TransitionAnimationPage'
  static readonly PAGES_MultipleDialogPage = 'pages/MultipleDialogPage'
  static readonly PAGES_ElectronicAlbumPage = 'pages/ElectronicAlbumPage'

  static TEXT_HEIGHT: number = 50;
  static DEFAULT_MARGIN: number = 30;
  static DEFAULT_FONT_SIZE: number = 30;
  static DOMAIN: number = 0x0000;

  static readonly FULL_PERCENT: string = '100%';
  static readonly TEXT_SCROLL_DURATION: number = 5000;
  static readonly ANGLE_DEGREE: number = 180;
  static readonly FIFTY_PERCENT: string = '50%';
  static readonly ANGLE_DEGREE_HORIZONTAL: number = 90;
  static readonly FONT_WEIGHT_500: number = 500;

  public static readonly FULL_LENGTH: string = '100%';
  public static readonly TITLE_WIDTH: string = '80%';
  public static readonly LIST_DEFAULT_WIDTH: string = '93.3%';
  public static readonly OPACITY_DEFAULT: number = 1;
  public static readonly OPACITY_COMPLETED: number = 0.4;
  public static readonly BORDER_RADIUS: number = 24;
  public static readonly FONT_WEIGHT: number = 500;
  public static readonly COLUMN_SPACE: number = 16;
  public static readonly TODO_DATA: Array<Resource> = [
    $r('app.string.todo_list_one'),
    $r('app.string.todo_list_two'),
    $r('app.string.todo_list_three'),
    $r('app.string.todo_list_four'),
    $r('app.string.todo_list_five')
  ];

  static readonly PERCENT_12: string = '12%';
  static readonly PERCENT_FULL: string = '100%';
  /**
   * MultiTabNavigationPage content width.
   */
  static readonly INDEX_CONTENT_WIDTH: string = '91.1%';
  /**
   * MultiTabNavigationPage divider height.
   */
  static readonly DIVIDER_HEIGHT: number = 0.5;
  /**
   * MultiTabNavigationPage divider width.
   */
  static readonly DIVIDER_WIDTH: string = '93%';
  /**
   * Drawer divider width.
   */
  static readonly DIVIDER_DRAWER_WIDTH: string = '90%';
  /**
   * Card title height.
   */
  static readonly CARD_TITLE_HEIGHT: number = 20;
  /**
   * Card text height.
   */
  static readonly CARD_TEXT_HEIGHT: number = 48;
  /**
   * MultiTabNavigationPage title height.
   */
  static readonly INDEX_TITLE_HEIGHT: number = 112;
  /**
   * Full screen width.
   */
  static readonly FULL_WIDTH: string = '100%';
  /**
   * Full screen height.
   */
  static readonly FULL_HEIGHT: string = '100%';
  /**
   * Font size of unchecked title.
   */
  static readonly FONT_SIZE_UNCHECKED = 18;
  /**
   * Font size of checked title.
   */
  static readonly FONT_SIZE_CHECKED: number = 24;
  /**
   * Content height.
   */
  static readonly CONTENT_HEIGHT: number = 300;
  /**
   * List height.
   */
  static readonly LIST_HEIGHT: number = 48;
  /**
   * List card width.
   */
  static readonly LIST_CARD_WIDTH: number = 272;
  /**
   * List card height.
   */
  static readonly LIST_CARD_HEIGHT: number = 344;
  /**
   * List content height.
   */
  static readonly LIST_CONTENT_HEIGHT: string = '110%';
  /**
   * Background tab height.
   */
  static readonly BACKGROUND_TAB_HEIGHT: number = 40;
  /**
   * MultiTabNavigationPage button height.
   */
  static readonly INDEX_BUTTON_HEIGHT: number = 60;
  /**
   * Background tab width.
   */
  static readonly BACKGROUND_TAB_WIDTH: number = 96;
  /**
   * Drawer width.
   */
  static readonly DRAWER_WIDTH: number = 264;
  /**
   * Sub tab width.
   */
  static readonly SUB_TAB_WIDTH: number = 56;
  /**
   * Sub slide width.
   */
  static readonly SUB_SLIDE_TAB_WIDTH: number = 56;
  /**
   * Sub tab bottom height.
   */
  static readonly SUB_TAB_BOT_HEIGHT: number = 25;
  /**
   * Sub tab width.
   */
  static readonly SUB_TAB_HEIGHT: number = 30;
  /**
   * Sub list width.
   */
  static readonly SUB_LIST_WIDTH: string = '85%';
  /**
   * Side tab width.
   */
  static readonly SIDE_TAB_WIDTH: string = '27.8%';
  /**
   * Side contend width.
   */
  static readonly SIDE_CONTEND_WIDTH: string = '72.2%';
  /**
   * Tab index0.
   */
  static readonly TAB_INDEX_ZERO: number = 0;
  /**
   * Tab index1.
   */
  static readonly TAB_INDEX_ONE: number = 1;
  /**
   * Tab index2.
   */
  static readonly TAB_INDEX_TWO: number = 2;
  /**
   * Tab index3.
   */
  static readonly TAB_INDEX_THREE: number = 3;
  /**
   * Tab index4.
   */
  static readonly TAB_INDEX_FOUR: number = 4;
  /**
   * Tab index5.
   */
  static readonly TAB_INDEX_FIVE: number = 5;
  /**
   * Image tab size.
   */
  static readonly IMAGE_SIZE_TAB: number = 22;
  /**
   * Image middle size.
   */
  static readonly IMAGE_SIZE_MIDDLE: number = 56;
  /**
   * Tab padding.
   */
  static readonly TAB_PADDING: number = 12;
  /**
   * More image width.
   */
  static readonly MORE_IMAGE_WIDTH: number = 20;
  /**
   * More image height.
   */
  static readonly MORE_IMAGE_HEIGHT: number = 15;
  /**
   * More image row width.
   */
  static readonly MORE_IMAGE_ROW_WIDTH: number = 60;
  /**
   * Drawer image height or width.
   */
  static readonly DRAWER_IMAGE_HEIGHT_WIDTH: number = 24;
  /**
   * List image height or width.
   */
  static readonly LIST_IMAGE_HEIGHT_WIDTH: number = 40;
  /**
   * Image offset.
   */
  static readonly IMAGE_OFFSET: number = -15;
  /**
   * Icon offset.
   */
  static readonly ICON_Offset: number = -3;
  /**
   * Animation duration.
   */
  static readonly ANIMATION_DURATION: number = 3000;
  /**
   * Margin sixteen.
   */
  static readonly MARGIN_SIXTEEN: number = 16;
  /**
   * Margin button top.
   */
  static readonly MARGIN_BUTTON_TOP: number = 48;
  /**
   * Translate top.
   */
  static readonly TRANSLATE_TOP: number = -40;
  /**
   * Translate bottom.
   */
  static readonly TRANSLATE_BOTTOM: number = 40;
  /**
   * Border radius drawer.
   */
  static readonly BORDER_RADIUS_DRAWER: number = 16;
  /**
   * Border radius index list.
   */
  static readonly BORDER_RADIUS_INDEX_LIST: number = 18;
  /**
   * Border radius drawer content.
   */
  static readonly BORDER_RADIUS_DRAWER_CONTENT: number = 20;
  /**
   * Border radius back tab.
   */
  static readonly BORDER_RADIUS_BACK_TAB: number = 21;
  /**
   * Divider strokeWidth.
   */
  static readonly STROKE_WIDTH: number = 2;
  /**
   * Slice index index0.
   */
  static readonly SLICE_INDEX_ZERO: number = 0;
  /**
   * Slice index index6.
   */
  static readonly SLICE_INDEX_SIX: number = 6;
  /**
   * fontWeight.
   */
  static readonly FONT_WEIGHT_TAB: number = 600;
  /**
   * TopTabData.
   */
  static readonly TOP_TAB_DATA: Array<Resource | string> =
    [$r('app.string.literature'), $r('app.string.making_friends'), $r('app.string.live_broadcast'),
      $r('app.string.video'), $r('app.string.ceremony'), $r('app.string.play')];

  /**
   * Routes.
   */
  static readonly ROUTES: Route[] = [
    {
      title: $r('app.string.bottom_nav'),
      child: [
        {
          text: $r('app.string.common_bottom_nav'),
          to: 'BottomTab'
        },
        {
          text: $r('app.string.rudder_bottom_nav'),
          to: 'RudderStyleTab'
        },
        {
          text: $r('app.string.video_slide'),
          to: 'TabContentOverflow'
        }
      ]
    },
    {
      title: $r('app.string.top_nav'),
      child: [
        {
          text: $r('app.string.left_tab'),
          to: 'LeftTab'
        },
        {
          text: $r('app.string.underline_tab'),
          to: 'UnderlineTab'
        },
        {
          text: $r('app.string.background_light_tab'),
          to: 'BackgroundLightTab'
        },
        {
          text: $r('app.string.word_tab'),
          to: 'WordTab'
        },
        {
          text: $r('app.string.double_nesting_tab_one'),
          to: 'DoubleNestingTabOne'
        },
        {
          text: $r('app.string.double_nesting_tab_two'),
          to: 'DoubleNestingTabTwo'
        },
        {
          text: $r('app.string.slide_and_mor_tab'),
          to: 'SlideAndMoreTab'
        }
      ]
    },
    {
      title: $r('app.string.side_tab'),
      child: [
        {
          text: $r('app.string.common_side_tab'),
          to: 'SideTab'
        },
        {
          text: $r('app.string.drawer_tab'),
          to: 'DrawerTab'
        }
      ]
    }
  ];
}

/**
 * Route type define.
 */
export interface Route {
  title: string | Resource;
  child: Array<ChildRoute>;
}

/**
 * ChildRoute type define.
 */
export interface ChildRoute {
  text: string | Resource;
  to: string;
}

export const STYLE_CONFIG: Record<string, number> = {
  'IMAGE_SIZE': 32,
  'IMAGE_MARGIN': 4,
  'ICON_GUTTER': 4,
  'OPERATION_BUTTON_PADDING': 4,
  'MENU_IMAGE_SIZE': 24,
  'MENU_HEIGHT': 56,
  'TEXT_MARGIN_LEFT': 40,
  'IMAGE_MARGIN_RIGHT': 30,
  'LIST_ITEM_GUTTER': 12,
  'BORDER_WIDTH': 3,
  'TODO_ITEM_HEIGHT': 80,
  'TODO_ITEM_PADDING_VERTICAL': 4,
  'IMAGE_ICON_OK_SIZE': 15,
  'ANIMATION_DURATION': 600,
  'CUSTOM_CHECKBOX_SIZE': 20
}

export class Constant {
  /**
   * Percent 12.
   */
  static readonly PERCENT_12: string = '12%';

  /**
   * Percent 100
   */
  static readonly PERCENT_FULL: string = '100%';
}