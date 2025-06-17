@Entry
@Component
struct StateV1Page {
  @State @Watch('onChange01') info: Info = new Info(new Person('Bob', 10));

  onChange01() {
    console.log(':::onChange01:' + this.info.person.name); // 2
  }

  build() {
    Column() {
      Text(this.info.person.name).height(40)
      Child({
        per: this.info.person, clickEvent: () => {
          console.log(':::clickEvent before', this.info.person.name); // 1
          this.info.person = new Person('Jack', 12);
          console.log(':::clickEvent after', this.info.person.name); // 3
        }
      })
    }
  }
}

@Component
struct Child {
  @ObjectLink @Watch('onChange02') per: Person;
  clickEvent?: () => void;

  onChange02() {
    console.log(':::onChange02:' + this.per.name); // 5
  }

  build() {
    Column() {
      Button(this.per.name)
        .height(40)
        .onClick(() => {
          this.onClickType();
        })
    }
  }

  private onClickType() {
    if (this.clickEvent) {
      this.clickEvent();
    }
    console.log(':::--------此时Child中的this.per.name值仍然是：' + this.per.name); // 4
  }
}

@Observed
class Person {
  name: string = '';
  age: number = 0;

  constructor(name: string, age: number) {
    this.name = name;
    this.age = age;
  }
}

@Observed
class Info {
  person: Person;

  constructor(person: Person) {
    this.person = person;
  }
}
