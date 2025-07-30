import JSONbig from '@ohmos/json-bigint'

@Entry
@Component
struct JSONPage {
  build() {
    Column() {
      Text('Example1')
        .onClick(() => {
          this.example1()
        })
    }
    .height('100%')
    .width('100%')
  }

  example1() {
    let json = '{ "value" : 9223372036854775807, "v2": 123 }';
    console.log('Input:', json);
    console.log('');

    console.log('node.js built-in JSON:');
    let r: TestBean = JSONbig.parse(json);
    console.log('JSON.parse(input).value : ', r.value.toString());
    console.log('JSON.stringify(JSON.parse(input)):', JSONbig.stringify(r, undefined, undefined));

    console.log('\n\nbig number JSON:');
    let r1: TestBean = JSONbig.parse(json);
    console.log('JSONbig.parse(input).value : ', r1.value.toString());
    console.log('JSONbig.stringify(JSONbig.parse(input)):', JSONbig.stringify(r1, undefined, undefined));
  }
}

export class TestBean {
  value: number = 0
  v2: number = 0
}