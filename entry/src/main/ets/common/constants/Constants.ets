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

  static TEXT_HEIGHT: number = 50;
  static DEFAULT_MARGIN: number = 30;
  static FULL_WIDTH: string = '100%';
  static FULL_HEIGHT: string = '100%';
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
}