class Person {
  nick: string | null = null;
  spouse?: Person;
  constructor(nick: string) {
    this.nick = nick;
    this.spouse = undefined;
  }


}
let p: Person = new Person('Alice');
p.spouse?.nick; // undefined
