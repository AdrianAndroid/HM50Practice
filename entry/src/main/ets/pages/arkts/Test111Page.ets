import { healthService, healthStore } from '@kit.HealthServiceKit'
import { speechRecognizer } from '@kit.CoreSpeechKit'
import { BusinessError } from '@kit.BasicServicesKit'
import { hiAppEvent } from '@kit.PerformanceAnalysisKit'
import { connection } from '@kit.NetworkKit'
import { interactiveLiveness } from '@kit.VisionKit'
import { LengthMetrics } from '@kit.ArkUI'
import { photoAccessHelper } from '@kit.MediaLibraryKit'

@Preview
@Entry
@Component
struct Index {

  build() {
    Stack() {
      Parent()
    }
  }

}

@Component
struct Parent {
  label: string = 'Parent';

  @Builder componentBuilder() {
    Text(`${this.label}`)
  }

  build() {
    Row() {
      this.componentBuilder()
      Child({
        customBuilderParam: this.componentBuilder,
        customChangeThisBuilderParam: (): void => { this.componentBuilder() }
      })
    }
  }
}

@Component
struct Child {
  label: string = 'Child';
  @Builder customBuilder() {};
  @Builder customChangeThisBuilder() {};
  @BuilderParam customBuilderParam: () => void = this.customBuilder;
  @BuilderParam customChangeThisBuilderParam: () => void = this.customChangeThisBuilder;

  build() {
    Row() {
      this.customBuilderParam()
      this.customChangeThisBuilderParam()
    }
  }
}
