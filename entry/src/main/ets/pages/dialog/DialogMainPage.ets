import { FULL_PERCENT } from '../../model/ConstantsData'
import { router } from '@kit.ArkUI'

@Builder
function PageBuilder() {
  DialogMainPage()
}

@ComponentV2
struct DialogMainPage {
  build() {
    NavDestination() {
      Scroll() {
        Column({space: 10}) {
          Blank().height(100)
          Button('PopupExample').onClick(() => {router.pushUrl({ url: 'pages/dialog/PopupExample' });})
          Button('CustomDialogExample2Page').onClick(() => {router.pushUrl({ url: 'pages/dialog/CustomDialogExample2Page' });})
          Button('CustomDialogExamplePage').onClick(() => {router.pushUrl({ url: 'pages/dialog/CustomDialogExamplePage' });})
          Button('DialogExamplePage').onClick(() => {router.pushUrl({ url: 'pages/dialog/DialogExamplePage' });})
          Button('DialogPromptActionClass').onClick(() => {router.pushUrl({ url: 'pages/dialog/DialogPromptActionClass' });})
          Button('FixedStyleDialogPage').onClick(() => {router.pushUrl({ url: 'pages/dialog/FixedStyleDialogPage' });})
          Button('MenuExamplePage').onClick(() => {router.pushUrl({ url: 'pages/dialog/MenuExamplePage' });})
          Button('ModalFullExamplePage').onClick(() => {router.pushUrl({ url: 'pages/dialog/ModalFullExamplePage' });})
          Button('ModalHalfExamplePage').onClick(() => {router.pushUrl({ url: 'pages/dialog/ModalHalfExamplePage' });})
          Button('OverlayManagerExamplePage').onClick(() => {router.pushUrl({ url: 'pages/dialog/OverlayManagerExamplePage' });})
          Button('PersonalInformation').onClick(() => {router.pushUrl({ url: 'pages/dialog/PersonalInformation' });})
          Button('PopupExamplePage').onClick(() => {router.pushUrl({ url: 'pages/dialog/PopupExamplePage' });})
          Button('ToastExamplePage').onClick(() => {router.pushUrl({ url: 'pages/dialog/ToastExamplePages' });})
        }
      }
      .width(FULL_PERCENT)
      .height(FULL_PERCENT)
    }
  }
}