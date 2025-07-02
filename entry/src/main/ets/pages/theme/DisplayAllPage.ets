import { CustomColors, CustomTheme, Theme } from '@kit.ArkUI'


class AppColors implements CustomColors {
  brand : Resource = $r('sys.color.white')
  warning : Resource = $r('sys.color.white')
  alert : Resource = $r('sys.color.white')
  confirm : Resource = $r('sys.color.white')
  fontPrimary : Resource = $r('sys.color.white')
  fontSecondary : Resource = $r('sys.color.white')
  fontTertiary : Resource = $r('sys.color.white')
  fontFourth : Resource = $r('sys.color.white')
  fontEmphasize : Resource = $r('sys.color.white')
  fontOnPrimary : Resource = $r('sys.color.white')
  fontOnSecondary : Resource = $r('sys.color.white')
  fontOnTertiary : Resource = $r('sys.color.white')
  fontOnFourth : Resource = $r('sys.color.white')
  iconPrimary : Resource = $r('sys.color.white')
  iconSecondary : Resource = $r('sys.color.white')
  iconTertiary : Resource = $r('sys.color.white')
  iconFourth : Resource = $r('sys.color.white')
  iconEmphasize : Resource = $r('sys.color.white')
  iconSubEmphasize : Resource = $r('sys.color.white')
  iconOnPrimary : Resource = $r('sys.color.white')
  iconOnSecondary : Resource = $r('sys.color.white')
  iconOnTertiary : Resource = $r('sys.color.white')
  iconOnFourth : Resource = $r('sys.color.white')
  backgroundPrimary : Resource = $r('sys.color.white')
  backgroundSecondary : Resource = $r('sys.color.white')
  backgroundTertiary : Resource = $r('sys.color.white')
  backgroundFourth : Resource = $r('sys.color.white')
  backgroundEmphasize : Resource = $r('sys.color.white')
  compForegroundPrimary : Resource = $r('sys.color.white')
  compBackgroundPrimary : Resource = $r('sys.color.white')
  compBackgroundPrimaryTran : Resource = $r('sys.color.white')
  compBackgroundPrimaryContrary : Resource = $r('sys.color.white')
  compBackgroundGray : Resource = $r('sys.color.white')
  compBackgroundSecondary : Resource = $r('sys.color.white')
  compBackgroundTertiary : Resource = $r('sys.color.white')
  compBackgroundEmphasize : Resource = $r('sys.color.white')
  compBackgroundNeutral : Resource = $r('sys.color.white')
  compEmphasizeSecondary : Resource = $r('sys.color.white')
  compEmphasizeTertiary : Resource = $r('sys.color.white')
  compDivider : Resource = $r('sys.color.white')
  compCommonContrary : Resource = $r('sys.color.white')
  compBackgroundFocus : Resource = $r('sys.color.white')
  compFocusedPrimary : Resource = $r('sys.color.white')
  compFocusedSecondary : Resource = $r('sys.color.white')
  compFocusedTertiary : Resource = $r('sys.color.white')
  interactiveHover : Resource = $r('sys.color.white')
  interactivePressed : Resource = $r('sys.color.white')
  interactiveFocus : Resource = $r('sys.color.white')
  interactiveActive : Resource = $r('sys.color.white')
  interactiveSelect : Resource = $r('sys.color.white')
  interactiveClick : Resource = $r('sys.color.white')
}

class AppColorsSec implements CustomColors {
  brand : Resource = $r('sys.color.black')
  warning : Resource = $r('sys.color.black')
  alert : Resource = $r('sys.color.black')
  confirm : Resource = $r('sys.color.black')
  fontPrimary : Resource = $r('sys.color.black')
  fontSecondary : Resource = $r('sys.color.black')
  fontTertiary : Resource = $r('sys.color.black')
  fontFourth : Resource = $r('sys.color.black')
  fontEmphasize : Resource = $r('sys.color.black')
  fontOnPrimary : Resource = $r('sys.color.black')
  fontOnSecondary : Resource = $r('sys.color.black')
  fontOnTertiary : Resource = $r('sys.color.black')
  fontOnFourth : Resource = $r('sys.color.black')
  iconPrimary : Resource = $r('sys.color.black')
  iconSecondary : Resource = $r('sys.color.black')
  iconTertiary : Resource = $r('sys.color.black')
  iconFourth : Resource = $r('sys.color.black')
  iconEmphasize : Resource = $r('sys.color.black')
  iconSubEmphasize : Resource = $r('sys.color.black')
  iconOnPrimary : Resource = $r('sys.color.black')
  iconOnSecondary : Resource = $r('sys.color.black')
  iconOnTertiary : Resource = $r('sys.color.black')
  iconOnFourth : Resource = $r('sys.color.black')
  backgroundPrimary : Resource = $r('sys.color.black')
  backgroundSecondary : Resource = $r('sys.color.black')
  backgroundTertiary : Resource = $r('sys.color.black')
  backgroundFourth : Resource = $r('sys.color.black')
  backgroundEmphasize : Resource = $r('sys.color.black')
  compForegroundPrimary : Resource = $r('sys.color.black')
  compBackgroundPrimary : Resource = $r('sys.color.black')
  compBackgroundPrimaryTran : Resource = $r('sys.color.black')
  compBackgroundPrimaryContrary : Resource = $r('sys.color.black')
  compBackgroundGray : Resource = $r('sys.color.black')
  compBackgroundSecondary : Resource = $r('sys.color.black')
  compBackgroundTertiary : Resource = $r('sys.color.black')
  compBackgroundEmphasize : Resource = $r('sys.color.black')
  compBackgroundNeutral : Resource = $r('sys.color.black')
  compEmphasizeSecondary : Resource = $r('sys.color.black')
  compEmphasizeTertiary : Resource = $r('sys.color.black')
  compDivider : Resource = $r('sys.color.black')
  compCommonContrary : Resource = $r('sys.color.black')
  compBackgroundFocus : Resource = $r('sys.color.black')
  compFocusedPrimary : Resource = $r('sys.color.black')
  compFocusedSecondary : Resource = $r('sys.color.black')
  compFocusedTertiary : Resource = $r('sys.color.black')
  interactiveHover : Resource = $r('sys.color.black')
  interactivePressed : Resource = $r('sys.color.black')
  interactiveFocus : Resource = $r('sys.color.black')
  interactiveActive : Resource = $r('sys.color.black')
  interactiveSelect : Resource = $r('sys.color.black')
  interactiveClick : Resource = $r('sys.color.black')
}

class AppTheme implements CustomTheme {
  public colors: AppColors = new AppColors()
}

class AppThemeSec implements CustomTheme {
  public colors: AppColors = new AppColorsSec()
}

let colors = [
// brand
// warning
// alert
// confirm
// fontPrimary
// fontSecondary
// fontTertiary
// fontFourth
// fontEmphasize
// fontOnPrimary
// fontOnSecondary
// fontOnTertiary
// fontOnFourth
// iconPrimary
// iconSecondary
// iconTertiary
// iconFourth
// iconEmphasize
// iconSubEmphasize
// iconOnPrimary
// iconOnSecondary
// iconOnTertiary
// iconOnFourth
// backgroundPrimary
// backgroundSecondary
// backgroundTertiary
// backgroundFourth
// backgroundEmphasize
// compForegroundPrimary
// compBackgroundPrimary
// compBackgroundPrimaryTran
// compBackgroundPrimaryContrary
// compBackgroundGray
// compBackgroundSecondary
// compBackgroundTertiary
// compBackgroundEmphasize
// compBackgroundNeutral
// compEmphasizeSecondary
// compEmphasizeTertiary
// compDivider
// compCommonContrary
// compBackgroundFocus
// compFocusedPrimary
// compFocusedSecondary
// compFocusedTertiary
// interactiveHover
// interactivePressed
// interactiveFocus
// interactiveActive
// interactiveSelect
// interactiveClick
]

@Entry
@Component
struct DisplayAllPage {
  @State customTheme: CustomTheme = new AppTheme()
  @State message: string = '设置应用局部页面自定义主题风格'
  count = 0;

  build() {
    WithTheme({ theme: this.customTheme }) {
      Row(){
        Column() {
          Text('WithTheme')
            .fontSize(30)
            .margin({bottom: 10})
          Text(this.message)
            .margin({bottom: 10})
          Button('change theme').onClick(() => {
            this.count++;
            if (this.count > 1) {
              this.count = 0;
            }
            switch (this.count) {
              case 0:
                this.customTheme = new AppTheme();
                break;
              case 1:
                this.customTheme = new AppThemeSec();
                break;
            }
          })
        }
        .width('100%')
      }
      .height('100%')
      .width('100%')
    }
  }
}