@Entry
@ComponentV2
struct StateV2Page {
  @Local shoppingBasket: Article[] = [new Article(1, 20), new Article(5, 2)];

  @Computed
  get total(): number {
    return this.shoppingBasket.reduce((acc: number, item: Article) => acc + (item.quantity * item.unitPrice), 0);
  }

  @Computed
  get qualifiesForDiscount(): boolean {
    return this.total >= 100;
  }

  build() {
    Column() {
      Blank()
        .height(100)
      Text(`Shopping List: `).fontSize(30)
      ForEach(this.shoppingBasket, (item: Article) => {
        Row() {
          Text(`unitPrice: ${item.unitPrice}`)
          Button('-').onClick(() => {
            if (item.quantity > 0) {
              item.quantity--;
            }
          })
          Text(`quantity: ${item.quantity}`)
          Button('+').onClick(() => {
            item.quantity++;
          })
        }

        Divider()
      })
      Child({ total: this.total, qualifiesForDiscount: this.qualifiesForDiscount })
    }.alignItems(HorizontalAlign.Start)
  }
}

@ComponentV2
struct Child {
  @Param total: number = 0;
  @Param qualifiesForDiscount: boolean = false;

  build() {
    Row() {
      Text(`Total: ${this.total} `).fontSize(30)
      Text(`Discount: ${this.qualifiesForDiscount} `).fontSize(30)
    }
  }
}

@ObservedV2
class Article {
  @Trace quantity: number = 0;
  unitPrice: number = 0;

  constructor(quantity: number, unitPrice: number) {
    this.quantity = quantity;
    this.unitPrice = unitPrice;
  }
}