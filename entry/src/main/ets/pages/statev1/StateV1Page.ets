import { UIUtils } from "@kit.ArkUI";

@Entry
@Component
struct StateV1Page {
  @State book: Book = new Book('100 secrets of C++', 765);

  build() {
    Column() {
      Blank()
        .height(300)
      ReaderComp({ book: this.book })
      ReaderComp({ book: this.book })
    }
  }
}

@Component
struct ReaderComp {
  @Prop book: Book = new Book("", 0);

  build() {
    Row() {
      Text(this.book.title)
      Text(`...has${this.book.pages} pages!`)
      Text(`...${this.book.readIt ? "I have read" : 'I have not read it'}`)
        .onClick(() => this.book.readIt = true)
    }
  }
}

class Book {
  public title: string;
  public pages: number;
  public readIt: boolean = false;

  constructor(title: string, pages: number) {
    this.title = title;
    this.pages = pages;
  }
}