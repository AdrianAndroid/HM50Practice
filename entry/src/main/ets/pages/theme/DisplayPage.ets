import { CustomColors, CustomTheme, Theme } from '@kit.ArkUI'


class AppColors implements CustomColors {
  fontPrimary: ResourceColor = $r('sys.color.ohos_id_navigation_group_color')//$r('app.color.brand_purple')
  backgroundEmphasize: ResourceColor = $r('sys.color.ohos_id_navigation_group_color')
}

class AppColorsSec implements CustomColors {
  fontPrimary: ResourceColor = $r('sys.color.ohos_id_navigation_group_color')
  backgroundEmphasize: ResourceColor = $r('sys.color.ohos_id_navigation_group_color')
}

class AppTheme implements CustomTheme {
  public colors: AppColors = new AppColors()
}

class AppThemeSec implements CustomTheme {
  public colors: AppColors = new AppColorsSec()
}

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

let colors = [
  $r('sys.color.brand'),
  $r('sys.color.warning'),
  $r('sys.color.alert'),
  $r('sys.color.brand'),
  $r('sys.color.brand'),
  $r('sys.color.brand'),
  $r('sys.color.brand'),
  $r('sys.color.brand'),
  $r('sys.color.brand'),
  $r('sys.color.brand'),
  $r('sys.color.brand'),
  $r('sys.color.brand'),
  $r('sys.color.brand'),
  $r('sys.color.brand'),
  $r('sys.color.brand'),
  $r('sys.color.brand'),
  $r('sys.color.brand'),
  $r('sys.color.brand'),
  $r('sys.color.brand'),
  $r('sys.color.brand'),
  $r('sys.color.brand'),
  $r('sys.color.brand'),
  $r('sys.color.brand'),
  $r('sys.color.brand'),
  $r('sys.color.brand'),
  $r('sys.color.brand'),
  $r('sys.color.brand'),
  $r('sys.color.brand'),
  $r('sys.color.brand'),
  $r('sys.color.brand'),
  $r('sys.color.brand'),
  $r('sys.color.brand'),
]
@Entry
@Component
struct DisplayPage {
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