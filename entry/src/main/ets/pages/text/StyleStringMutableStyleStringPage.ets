import { LengthMetrics, LengthUnit } from '@kit.ArkUI';
import { image } from '@kit.ImageKit';
import { drawing } from '@kit.ArkGraphics2D';

@Entry
@Component
struct StyleStringMutableStyleStringPage {
  @State message: string = 'Hello World';
  styledString1: StyledString = new StyledString("运动45分钟");
  mutableStyledString2: MutableStyledString = new MutableStyledString("运动35分钟");
  controller1: TextController = new TextController();
  controller2: TextController = new TextController();
  textStyleAttrs: TextStyle =
    new TextStyle({ fontWeight: FontWeight.Bolder, fontSize: LengthMetrics.vp(24), fontStyle: FontStyle.Italic });
  mutableStyledString3: MutableStyledString = new MutableStyledString("运动35分钟 目标达成", [
    {
      start: 2,
      length: 2,
      styledKey: StyledStringKey.FONT,
      styledValue: this.textStyleAttrs
    },
    {
      start: 7,
      length: 4,
      styledKey: StyledStringKey.FONT,
      styledValue: new TextStyle({ fontColor: Color.Orange, fontSize: LengthMetrics.vp(12) })
    }
  ]);
  controller3: TextController = new TextController();
  mutableStyledString4: MutableStyledString = new MutableStyledString("运动35分钟", [
    {
      start: 0,
      length: 3,
      styledKey: StyledStringKey.TEXT_SHADOW,
      styledValue: new TextShadowStyle({
        radius: 5,
        type: ShadowType.COLOR,
        color: Color.Red,
        offsetX: 10,
        offsetY: 10
      })
    }
  ]);
  controller4: TextController = new TextController();
  mutableStyledString5: MutableStyledString = new MutableStyledString("运动35分钟", [
    {
      start: 0,
      length: 3,
      styledKey: StyledStringKey.DECORATION,
      styledValue: new DecorationStyle({ type: TextDecorationType.LineThrough, color: Color.Red })
    }
  ]);
  controller5: TextController = new TextController();
  mutableStyledString6: MutableStyledString = new MutableStyledString("运动35分钟", [
    {
      start: 0,
      length: 3,
      styledKey: StyledStringKey.BASELINE_OFFSET,
      styledValue: new BaselineOffsetStyle(LengthMetrics.px(20))
    }
  ]);
  controller6: TextController = new TextController();
  mutableStyledString7: MutableStyledString = new MutableStyledString("运动35分钟\n顶顶顶\n得到", [
    {
      start: 8,
      length: 3,
      styledKey: StyledStringKey.LINE_HEIGHT,
      styledValue: new LineHeightStyle(LengthMetrics.vp(100))
    }
  ]);
  controller7: TextController = new TextController();
  mutableStyledString8: MutableStyledString = new MutableStyledString("运动35分钟", [
    {
      start: 0,
      length: 2,
      styledKey: StyledStringKey.LETTER_SPACING,
      styledValue: new LetterSpacingStyle(new LengthMetrics(20, LengthUnit.VP))
    }
  ]);
  controller8: TextController = new TextController();
  titleParagraphStyleAttr9: ParagraphStyle = new ParagraphStyle({ textAlign: TextAlign.Center });
  //段落首行缩进15vp
  paragraphStyleAttr9: ParagraphStyle = new ParagraphStyle({ textIndent: LengthMetrics.vp(15) });
  //行高样式对象
  lineHeightStyle9: LineHeightStyle = new LineHeightStyle(new LengthMetrics(24));
  //创建含段落样式的对象paragraphStyledString1
  paragraphStyledString9: MutableStyledString =
    new MutableStyledString("段落标题\n正文第一段落开始0123456789正文第一段落结束。", [
      {
        start: 0,
        length: 4,
        styledKey: StyledStringKey.PARAGRAPH_STYLE,
        styledValue: this.titleParagraphStyleAttr9
      },
      {
        start: 0,
        length: 4,
        styledKey: StyledStringKey.LINE_HEIGHT,
        styledValue: new LineHeightStyle(new LengthMetrics(50))
      },
      {
        start: 0,
        length: 4,
        styledKey: StyledStringKey.FONT,
        styledValue: new TextStyle({ fontSize: LengthMetrics.vp(24), fontWeight: FontWeight.Bolder })
      },
      {
        start: 5,
        length: 3,
        styledKey: StyledStringKey.PARAGRAPH_STYLE,
        styledValue: this.paragraphStyleAttr9
      },
      {
        start: 5,
        length: 20,
        styledKey: StyledStringKey.LINE_HEIGHT,
        styledValue: this.lineHeightStyle9
      }
    ]);
  //段落不设置缩进配置最大行数及超长显示方式
  paragraphStyleAttr9Replace: ParagraphStyle = new ParagraphStyle({
    textAlign: TextAlign.End,
    maxLines: 1,
    wordBreak: WordBreak.BREAK_ALL,
    overflow: TextOverflow.Ellipsis
  });
  // 后续某个节点触发更新段落样式
  controller9: TextController = new TextController();
  imagePixelMap10: image.PixelMap | undefined = undefined;
  @State imagePixelMap10_3: image.PixelMap | undefined = undefined;
  mutableStr10: MutableStyledString = new MutableStyledString('123');
  controller10: TextController = new TextController();
  // mutableStr10_2: MutableStyledString =
  //   new MutableStyledString('This is set decoration line style to the mutableStr2', [{
  //     start: 0,
  //     length: 15,
  //     styledKey: StyledStringKey.DECORATION,
  //     styledValue: new DecorationStyle({
  //       type: TextDecorationType.Overline,
  //       color: Color.Orange,
  //       style: TextDecorationStyle.DOUBLE
  //     })
  //   }]);
  leadingMarginValue10: ParagraphStyle = new ParagraphStyle({ leadingMargin: LengthMetrics.vp(5) });
  //行高样式对象
  lineHeightStyle10: LineHeightStyle = new LineHeightStyle(new LengthMetrics(24));
  //Bold样式
  boldTextStyle10: TextStyle = new TextStyle({ fontWeight: FontWeight.Bold });
  //创建含段落样式的对象paragraphStyledString1
  paragraphStyledString10_1: MutableStyledString =
    new MutableStyledString("\n品牌相纸 高清冲印30张\n限时直降5.15元 限量增送", [
      {
        start: 0,
        length: 28,
        styledKey: StyledStringKey.PARAGRAPH_STYLE,
        styledValue: this.leadingMarginValue10
      },
      {
        start: 14,
        length: 9,
        styledKey: StyledStringKey.FONT,
        styledValue: new TextStyle({ fontSize: LengthMetrics.vp(14), fontColor: '#B22222' })
      },
      {
        start: 24,
        length: 4,
        styledKey: StyledStringKey.FONT,
        styledValue: new TextStyle({ fontSize: LengthMetrics.vp(14), fontWeight: FontWeight.Lighter })
      },
      {
        start: 11,
        length: 4,
        styledKey: StyledStringKey.LINE_HEIGHT,
        styledValue: new LineHeightStyle(new LengthMetrics(24))
      }
    ]);
  paragraphStyledString10_2: MutableStyledString = new MutableStyledString("\n￥16.21 3000+人好评", [
    {
      start: 0,
      length: 5,
      styledKey: StyledStringKey.PARAGRAPH_STYLE,
      styledValue: this.leadingMarginValue10
    },
    {
      start: 0,
      length: 4,
      styledKey: StyledStringKey.LINE_HEIGHT,
      styledValue: new LineHeightStyle(new LengthMetrics(60))
    },
    {
      start: 0,
      length: 7,
      styledKey: StyledStringKey.FONT,
      styledValue: new TextStyle({ fontWeight: FontWeight.Bold })
    },
    {
      start: 1,
      length: 1,
      styledKey: StyledStringKey.FONT,
      styledValue: new TextStyle({ fontSize: LengthMetrics.vp(18) })
    },
    {
      start: 2,
      length: 2,
      styledKey: StyledStringKey.FONT,
      styledValue: new TextStyle({ fontSize: LengthMetrics.vp(36) })
    },
    {
      start: 4,
      length: 3,
      styledKey: StyledStringKey.FONT,
      styledValue: new TextStyle({ fontSize: LengthMetrics.vp(20) })
    },
    {
      start: 7,
      length: 9,
      styledKey: StyledStringKey.FONT,
      styledValue: new TextStyle({ fontColor: Color.Grey, fontSize: LengthMetrics.vp(14) })
    }
  ]);
  customSpan11: MyCustomSpan11 = new MyCustomSpan11("99VIP88%off", 200, 40, 30);
  // textStyle11: MutableStyledString = new MutableStyledString("123");
  textController11: TextController = new TextController();
  isPageShow11: boolean = true;
  alignCenterParagraphStyleAttr12: ParagraphStyle = new ParagraphStyle({ textAlign: TextAlign.Center });
  //行高样式对象
  lineHeightStyle12_1: LineHeightStyle = new LineHeightStyle(LengthMetrics.vp(24));
  //Bold样式
  boldTextStyle12: TextStyle = new TextStyle({ fontWeight: FontWeight.Bold });
  //创建含段落样式的对象paragraphStyledString1
  paragraphStyledString12_1: MutableStyledString =
    new MutableStyledString("您的豪华钻石已过期1天\n续费可继续享受会员专属权益", [
      {
        start: 0,
        length: 4,
        styledKey: StyledStringKey.PARAGRAPH_STYLE,
        styledValue: this.alignCenterParagraphStyleAttr12
      },
      {
        start: 0,
        length: 4,
        styledKey: StyledStringKey.LINE_HEIGHT,
        styledValue: new LineHeightStyle(LengthMetrics.vp(40))
      },
      {
        start: 11,
        length: 14,
        styledKey: StyledStringKey.FONT,
        styledValue: new TextStyle({ fontSize: LengthMetrics.vp(14), fontColor: Color.Grey })
      },
      {
        start: 11,
        length: 4,
        styledKey: StyledStringKey.PARAGRAPH_STYLE,
        styledValue: this.alignCenterParagraphStyleAttr12
      },
      {
        start: 11,
        length: 4,
        styledKey: StyledStringKey.LINE_HEIGHT,
        styledValue: this.lineHeightStyle12_1
      }
    ]);
  paragraphStyledString12_2: MutableStyledString = new MutableStyledString("\n￥4.88￥15", [
    {
      start: 0,
      length: 4,
      styledKey: StyledStringKey.PARAGRAPH_STYLE,
      styledValue: this.alignCenterParagraphStyleAttr12
    },
    {
      start: 0,
      length: 4,
      styledKey: StyledStringKey.LINE_HEIGHT,
      styledValue: new LineHeightStyle(LengthMetrics.vp(60))
    },
    {
      start: 0,
      length: 6,
      styledKey: StyledStringKey.FONT,
      styledValue: this.boldTextStyle12
    },
    {
      start: 1,
      length: 1,
      styledKey: StyledStringKey.FONT,
      styledValue: new TextStyle({ fontSize: LengthMetrics.vp(18) })
    },
    {
      start: 2,
      length: 4,
      styledKey: StyledStringKey.FONT,
      styledValue: new TextStyle({ fontSize: LengthMetrics.vp(40) })
    },
    {
      start: 6,
      length: 3,
      styledKey: StyledStringKey.FONT,
      styledValue: new TextStyle({ fontColor: Color.Grey, fontSize: LengthMetrics.vp(14) })
    },
    {
      start: 6,
      length: 3,
      styledKey: StyledStringKey.DECORATION,
      styledValue: new DecorationStyle({ type: TextDecorationType.LineThrough, color: Color.Grey })
    }
  ]);
  paragraphStyledString12_3: MutableStyledString = new MutableStyledString("\n02时06分后将失去该优惠", [
    {
      start: 0,
      length: 4,
      styledKey: StyledStringKey.PARAGRAPH_STYLE,
      styledValue: this.alignCenterParagraphStyleAttr12
    },
    {
      start: 0,
      length: 4,
      styledKey: StyledStringKey.LINE_HEIGHT,
      styledValue: new LineHeightStyle(LengthMetrics.vp(30))
    },
    {
      start: 1,
      length: 2,
      styledKey: StyledStringKey.FONT,
      styledValue: new TextStyle({ fontColor: '#FFD700', fontWeight: FontWeight.Bold })
    },
    {
      start: 4,
      length: 2,
      styledKey: StyledStringKey.FONT,
      styledValue: new TextStyle({ fontColor: '#FFD700', fontWeight: FontWeight.Bold })
    }
  ]);
  controller12: TextController = new TextController();

  async aboutToAppear() {
    console.info("aboutToAppear initial imagePixelMap");
    this.imagePixelMap10 = await this.getPixmapFromMedia10($r('app.media.img_4'));
  }

  async onPageShow() {
    this.controller1.setStyledString(this.styledString1);
    this.controller2.setStyledString(this.mutableStyledString2);
    this.controller3.setStyledString(this.mutableStyledString3);
    this.controller4.setStyledString(this.mutableStyledString4)
    this.controller5.setStyledString(this.mutableStyledString5)
    this.controller6.setStyledString(this.mutableStyledString6);
    this.controller7.setStyledString(this.mutableStyledString7);
    this.controller8.setStyledString(this.mutableStyledString8);
    this.paragraphStyledString9.replaceStyle({
      start: 5,
      length: 3,
      styledKey: StyledStringKey.PARAGRAPH_STYLE,
      styledValue: this.paragraphStyleAttr9Replace
    });
    this.controller9.setStyledString(this.paragraphStyledString9);
    if (!this.isPageShow11) {
      return;
    }
    this.isPageShow11 = false;
    this.textController11.setStyledString(new StyledString(this.customSpan11));

  }

  build() {
    Scroll() {
      Column() {
        // 显示属性字符串
        Text(undefined, { controller: this.controller1 }).border({ width: 1 })
        Text(undefined, { controller: this.controller2 }).border({ width: 1 })

        // 设置文本样式
        // 显示属性字符串
        Text(undefined, { controller: this.controller3 }).border({ width: 1 })
          .margin({ top: 10 })

        // 创建及应用文本阴影对象（TextShadowStyle）
        Text(undefined, { controller: this.controller4 }).border({ width: 1 })
        Text(undefined, { controller: this.controller5 }).border({ width: 1 })
        // 创建及应用文本基线偏移量对象（BaselineOffsetStyle）
        Text(undefined, { controller: this.controller6 }).border({ width: 1 })
        // 创建及应用文本行高对象（LineHeightStyle）
        Text(undefined, { controller: this.controller7 }).border({ width: 1 })
        //  创建及应用文本字符间距对象（LetterSpacingStyle）
        Text(undefined, { controller: this.controller8 }).border({ width: 1 })
        // 设置段落样式
        Text(undefined, { controller: this.controller9 }).border({ width: 1 })
        // 使用图片
        Column({ space: 10 }) {
          Text(undefined, { controller: this.controller10 })
            .copyOption(CopyOptions.InApp)
            .draggable(true)
            .backgroundColor('#FFFFFF')
            .borderRadius(5)

          Button('点击查看商品卡片')
            .onClick(() => {
              if (this.imagePixelMap10 !== undefined) {
                this.mutableStr10 = new MutableStyledString(new ImageAttachment({
                  value: this.imagePixelMap10,
                  size: { width: 180, height: 160 },
                  verticalAlign: ImageSpanAlignment.BASELINE,
                  objectFit: ImageFit.Fill
                }));
                this.paragraphStyledString10_1.appendStyledString(this.paragraphStyledString10_2);
                this.mutableStr10.appendStyledString(this.paragraphStyledString10_1);
                this.controller10.setStyledString(this.mutableStr10);
              }
            })
        }
        .width('100%')

        // 设置事件
        Column() {
          Text(undefined, { controller: this.textController11 })
            .copyOption(CopyOptions.InApp)
            .fontSize(30)
        }
        .width('100%')

        Column({ space: 5 }) {
          Text(undefined, { controller: this.controller12 })
            .width(240)
            .copyOption(CopyOptions.InApp)
            .draggable(true)
            .onAppear(() => {
              this.paragraphStyledString12_2.appendStyledString(this.paragraphStyledString12_3);
              this.paragraphStyledString12_1.appendStyledString(this.paragraphStyledString12_2);
              this.controller12.setStyledString(this.paragraphStyledString12_1);
            })

          Button("限时4.88元 立即续费")
            .width(200)
            .fontColor(Color.White)
            .fontSize(18)
            .backgroundColor('#3CB371')
            .margin({ bottom: 10 })
        }
        .borderWidth(1).borderColor('#FFDEAD')
        .margin({ left: 10 })
      }
    }
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
    .width('100%')
    .width('100%')
  }

  private async getPixmapFromMedia10(resource: Resource) {
    let unit8Array = await this.getUIContext().getHostContext()?.resourceManager?.getMediaContent({
      bundleName: resource.bundleName,
      moduleName: resource.moduleName,
      id: resource.id
    });
    let imageSource = image.createImageSource(unit8Array?.buffer?.slice(0, unit8Array?.buffer?.byteLength));
    let createPixelMap: image.PixelMap = await imageSource.createPixelMap({
      desiredPixelFormat: image.PixelMapFormat.RGBA_8888
    });
    await imageSource.release();
    return createPixelMap;
  }
}

class MyCustomSpan11 extends CustomSpan {
  width: number = 160;
  word: string = "drawing";
  height: number = 10;
  fontSize: number = 16;

  constructor(word: string, width: number, height: number, fontSize: number) {
    super();
    this.word = word;
    this.width = width;
    this.height = height;
    this.fontSize = fontSize;
  }

  onMeasure(measureInfo: CustomSpanMeasureInfo): CustomSpanMetrics {
    return { width: this.width, height: this.height };
  }

  onDraw(context: DrawContext, options: CustomSpanDrawInfo) {
    let canvas = context.canvas;

    // 背景
    this.onDrawRectByRadius(context, options.x, options.x + vp2px(this.width), options.lineTop, options.lineBottom, 20);

    const brush = new drawing.Brush();
    // brush.setColor({ alpha: 255, red: 0, green: 0, blue: 0 });
    // canvas.attachBrush(brush);

    // 99VIP
    brush.setColor({
      alpha: 255,
      red: 255,
      green: 255,
      blue: 255
    }); // 白色的刷子
    canvas.attachBrush(brush);
    const font = new drawing.Font();
    font.setSize(vp2px(this.fontSize)); // 字体大小
    const textBlob =
      drawing.TextBlob.makeFromString(this.word.substring(0, 5), font, drawing.TextEncoding.TEXT_ENCODING_UTF8);
    canvas.drawTextBlob(textBlob, options.x, options.lineBottom - 30);

    // 88%off
    brush.setColor({
      alpha: 255,
      red: 255,
      green: 228,
      blue: 196
    });
    canvas.attachBrush(brush);
    const textBlob1 =
      drawing.TextBlob.makeFromString(this.word.substring(5), font, drawing.TextEncoding.TEXT_ENCODING_UTF8);
    canvas.drawTextBlob(textBlob1, options.x + vp2px(120), options.lineBottom - 60);

    canvas.detachBrush();
  }

  onDrawRectByRadius(context: DrawContext, left: number, right: number, top: number, bottom: number, radius: number) {
    let canvas = context.canvas;
    let path = new drawing.Path();

    // 画带radius的rect
    path.moveTo(left + radius, top);
    path.lineTo(right - radius, top);
    path.arcTo(right - 2 * radius, top, right, top + 2 * radius, 270, 90);
    path.lineTo(right, bottom - radius);
    path.arcTo(right - 2 * radius, bottom - 2 * radius, right, bottom, 0, 90);

    path.lineTo(left + 2 * radius, bottom);
    path.arcTo(left, bottom - 2 * radius, left + 2 * radius, bottom, 90, 90);
    path.lineTo(left, top + 2 * radius);
    path.arcTo(left, top, left + 2 * radius, top + 2 * radius, 180, 90);

    canvas.drawPath(path);
  }

  setWord(word: string) {
    this.word = word;
  }
}