import Logger from '../common/util/Logger';

@Entry
@Component
struct CounterView {
  @State toggle: boolean = true;

  build() {
    Column() {
      if (this.toggle) {
        MainView({ label: 'CounterView #positive' })
      } else {
        MainView({ label: 'CounterView #negative' })
      }
      Button(`toggle ${this.toggle}`)
        .onClick(() => {
          this.toggle = !this.toggle;
        })
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
  }
}


@Component
struct MainView {
  @State counter: number = 0;
  label: string = 'unknown';

  aboutToAppear(): void {
    Logger.info('MainView', `${this.label} ${this.label} aboutToAppear`)
  }

  aboutToDisappear(): void {
    Logger.info('MainView', `${this.label} ${this.label} aboutToDisappear`)
  }

  onPageShow(): void {
    Logger.info('MainView', `${this.label} ${this.label} onPageShow`)
  }

  onPageHide(): void {
    Logger.info('MainView', `${this.label} ${this.label} onPageShow`)
  }

  build() {
    Column({ space: 20 }) {
      Text(`${this.label}`)
      Button(`counter ${this.counter} +1`)
        .onClick(() => {
          this.counter += 1;
        })
    }
    .margin(10)
    .padding(10)
    .border({ width: 1 })
  }
}
