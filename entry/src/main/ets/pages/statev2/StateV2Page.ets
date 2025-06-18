@Entry
@ComponentV2
struct StateV2Page {
  @Local celsius: number = 20;

  @Computed
  get fahrenheit(): number {
    return this.celsius * 9 / 5 + 32; // C -> F
  }

  @Computed
  get kelvin(): number {
    return (this.fahrenheit - 32) * 5 / 9 + 273.15; // F -> K
  }

  @Monitor("kelvin")
  onKelvinMonitor(mon: IMonitor) {
    console.log("kelvin changed from " + mon.value()?.before + " to " + mon.value()?.now);
  }

  build() {
    Column({ space: 20 }) {
      Blank()
        .height(100)
      Row({ space: 20 }) {
        Button('-')
          .onClick(() => {
            this.celsius--;
          })

        Text(`Celsius ${this.celsius.toFixed(1)}`).fontSize(50)

        Button('+')
          .onClick(() => {
            this.celsius++;
          })
      }

      Text(`Fahrenheit ${this.fahrenheit.toFixed(2)}`).fontSize(50)
      Text(`Kelvin ${this.kelvin.toFixed(2)}`).fontSize(50)
    }
    .width('100%')
  }
}