import { UIExtensionContentSession } from '@kit.AbilityKit';
import Constants from '../../common/Constants';

let storage = LocalStorage.getShared()

@Entry(storage)
@Component
struct EmbeddedUIExtAbilityPage {
  @State message: string = 'EmbeddedUIExtensionAbility Index';
  private session: UIExtensionContentSession | undefined = storage.get<UIExtensionContentSession>('session');

  build() {
    Column() {
      Text(this.message)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
      Button("terminateSelfWithResult").fontSize(20).onClick(() => {
        this.session?.terminateSelfWithResult({
          resultCode: 1,
          want: {
            bundleName: Constants.bundleName,
            abilityName: "EmbeddedUIExtAbility",
          }
        });
      })
    }.width('100%').height('100%')
  }
}