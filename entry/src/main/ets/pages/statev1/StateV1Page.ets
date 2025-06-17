class Data {
  code: number;

  constructor(code: number) {
    this.code = code;
  }
}

AppStorage.setOrCreate('PropA', 47);
AppStorage.setOrCreate('PropB', new Data(50));
let storage = new LocalStorage();
storage.setOrCreate('LinkA', 48);
storage.setOrCreate('LinkB', new Data(100));

@Entry(storage)
@Component
struct StateV1Page {
  @StorageLink('PropA') storageLink: number = 1;
  @LocalStorageLink('LinkA') localStorageLink: number = 1;
  @StorageLink('PropB') storageLinkObject: Data = new Data(1);
  @LocalStorageLink('LinkB') localStorageLinkObject: Data = new Data(1);

  build() {
    Column({ space: 20 }) {
      Text(`From AppStorage ${this.storageLink}`)
        .onClick(() => {
          this.storageLink += 1;
        })

      Text(`From LocalStorage ${this.localStorageLink}`)
        .onClick(() => {
          this.localStorageLink += 1;
        })

      Text(`From AppStorage ${this.storageLinkObject.code}`)
        .onClick(() => {
          this.storageLinkObject.code += 1;
        })

      Text(`From LocalStorage ${this.localStorageLinkObject.code}`)
        .onClick(() => {
          this.localStorageLinkObject.code += 1;
        })
    }
  }
}