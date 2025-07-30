import { convertxml, util, xml } from '@kit.ArkTS';

@Entry
@Component
struct XMLPage {
  build() {
    Column({space: 20}) {
      Button('生成XML')
        .onClick(() => {
          this.createXML();
        })

      Button('解析XML标签和标签值')
        .onClick(() => {
          this.parseXML1();
        })

      Button('解析XML属性和属性值')
        .onClick(() => {
          this.parseXML2();
        })

      Button('解析XML事件类型和元素信息')
        .onClick(() => {
          this.parseXML3();
        })

      Button('场景示例')
        .onClick(() => {
          this.parseXML4();
        })

      Button('XML转换')
        .onClick(() => {
          this.convertXML();
        })
    }
    .height('100%')
    .width('100%')
  }

  createXML() {
    let arrayBuffer: ArrayBuffer = new ArrayBuffer(2048); // 创建一个2048字节的缓冲区
    let serializer: xml.XmlSerializer = new xml.XmlSerializer(arrayBuffer); // 基于ArrayBuffer构造XmlSerializer对象
    // let dataView: DataView = new DataView(arrayBuffer); // 创建一个DataView
    // let serializer: xml.XmlSerializer = new xml.XmlSerializer(dataView); // 基于DataView构造XmlSerializer对象

    serializer.setDeclaration(); // 写入xml的声明
    serializer.startElement('bookstore'); // 写入元素开始标记
    serializer.startElement('book'); // 嵌套元素开始标记
    serializer.setAttributes('category', 'COOKING'); // 写入属性及其属性值
    serializer.startElement('title');
    serializer.setAttributes('lang', 'en');
    serializer.setText('Everyday'); // 写入标签值
    serializer.endElement(); // 写入结束标记
    serializer.startElement('author');
    serializer.setText('Giana');
    serializer.endElement();
    serializer.startElement('year');
    serializer.setText('2005');
    serializer.endElement();
    serializer.endElement();
    serializer.endElement();

    let unit8Array: Uint8Array = new Uint8Array(arrayBuffer);
    let textDecoder: util.TextDecoder = util.TextDecoder.create();
    let result: string = textDecoder.decodeToString(unit8Array);
    console.info(result)
  }

  parseXML1() {
    let strXml: string =
      '<?xml version="1.0" encoding="utf-8"?>' +
      '<note importance="high" logged="true">' +
      '<title>Play</title>' +
      '<lens>Work</lens>' +
      '</note>';
    let textEncoder: util.TextEncoder = new util.TextEncoder();
    let arrBuffer: Uint8Array = textEncoder.encodeInto(strXml); // 对数据进行编码，防止中文字符乱码
    // 方式1：基于ArrayBuffer构造XmlPullParser对象
    let that: xml.XmlPullParser = new xml.XmlPullParser(arrBuffer.buffer as object as ArrayBuffer, 'UTF-8');
    // 方式2：基于DataView构造XmlPullParser对象
    // let dataView: DataView = new DataView(arrBuffer.buffer as object as ArrayBuffer);
    // let that: xml.XmlPullParser = new xml.XmlPullParser(dataView, 'UTF-8');
    let options: xml.ParseOptions = {supportDoctype:true, ignoreNameSpace:true, tagValueCallbackFunction:funcXML};
    that.parseXml(options);
  }

  parseXML2() {
    let strXml: string =
      '<?xml version="1.0" encoding="utf-8"?>' +
        '<note importance="high" logged="true">' +
        '    <title>Play</title>' +
        '    <title>Happy</title>' +
        '    <lens>Work</lens>' +
        '</note>';
    let textEncoder: util.TextEncoder = new util.TextEncoder();
    let arrBuffer: Uint8Array = textEncoder.encodeInto(strXml); // 对数据进行编码，防止中文字符乱码
    let that: xml.XmlPullParser = new xml.XmlPullParser(arrBuffer.buffer as object as ArrayBuffer, 'UTF-8');

    let options: xml.ParseOptions = {supportDoctype:true, ignoreNameSpace:true, attributeValueCallbackFunction:funcXML2};
    that.parseXml(options);
    console.info('Hello World!!! ---> ')
    console.info(str2); // 打印所有属性及其值
  }

  parseXML3() {
    let strXml: string =
      '<?xml version="1.0" encoding="utf-8"?>' +
        '<note importance="high" logged="true">' +
        '<title>Play</title>' +
        '</note>';
    let textEncoder: util.TextEncoder = new util.TextEncoder();
    let arrBuffer: Uint8Array = textEncoder.encodeInto(strXml); // 对数据进行编码，防止中文字符乱码
    let that: xml.XmlPullParser = new xml.XmlPullParser(arrBuffer.buffer as object as ArrayBuffer, 'UTF-8');
    let options: xml.ParseOptions = { supportDoctype: true, ignoreNameSpace: true, tokenValueCallbackFunction: funcXML3 };
    that.parseXml(options);
  }

  parseXML4() {
    let strXml: string =
      '<?xml version="1.0" encoding="UTF-8"?>' +
        '<book category="COOKING">' +
        '<title lang="en">Everyday</title>' +
        '<author>Giana</author>' +
        '</book>';
    let textEncoder: util.TextEncoder = new util.TextEncoder();
    let arrBuffer: Uint8Array = textEncoder.encodeInto(strXml);
    let that: xml.XmlPullParser = new xml.XmlPullParser(arrBuffer.buffer as object as ArrayBuffer, 'UTF-8');
    let options: xml.ParseOptions = {
      supportDoctype: true,
      ignoreNameSpace: true,
      tagValueCallbackFunction: tagFunc,
      attributeValueCallbackFunction: attFunc,
      tokenValueCallbackFunction: tokenFunc
    };
    that.parseXml(options);
  }

  convertXML() {
    let xml: string =
      '<?xml version="1.0" encoding="utf-8"?>' +
        '<note importance="high" logged="true">' +
        '    <title>Happy</title>' +
        '    <todo>Work</todo>' +
        '    <todo>Play</todo>' +
        '</note>';
    let options: convertxml.ConvertOptions = {
      // trim: false 转换后是否删除文本前后的空格，否
      // declarationKey: "_declaration" 转换后文件声明使用_declaration来标识
      // instructionKey: "_instruction" 转换后指令使用_instruction标识
      // attributesKey: "_attributes" 转换后属性使用_attributes标识
      // textKey: "_text" 转换后标签值使用_text标识
      // cdataKey: "_cdata" 转换后未解析数据使用_cdata标识
      // docTypeKey: "_doctype" 转换后文档类型使用_doctype标识
      // commentKey: "_comment" 转换后注释使用_comment标识
      // parentKey: "_parent" 转换后父类使用_parent标识
      // typeKey: "_type" 转换后元素类型使用_type标识
      // nameKey: "_name" 转换后标签名称使用_name标识
      // elementsKey: "_elements" 转换后元素使用_elements标识
      trim: false,
      declarationKey: "_declaration",
      instructionKey: "_instruction",
      attributesKey: "_attributes",
      textKey: "_text",
      cdataKey: "_cdata",
      doctypeKey: "_doctype",
      commentKey: "_comment",
      parentKey: "_parent",
      typeKey: "_type",
      nameKey: "_name",
      elementsKey: "_elements"
    }

    let conv: convertxml.ConvertXML = new convertxml.ConvertXML();
    let result: object = conv.fastConvertToJSObject(xml, options);
    let strRes: string = JSON.stringify(result); // 将js对象转换为json字符串，用于显式输出
    console.info(strRes);
  }
}



let str4: string = '';

function tagFunc(name: string, value: string): boolean {
  str4 = name + value;
  console.info('tag-' + str4);
  return true;
}

function attFunc(name: string, value: string): boolean {
  str4 = name + ' ' + value;
  console.info('attri-' + str4);
  return true;
}

function tokenFunc(name: xml.EventType, value: xml.ParseInfo): boolean {
  str4 = name + ' ' + value.getDepth();
  console.info('token-' + str4);
  return true;
}


let str3: string = '';
function funcXML3(name: xml.EventType, value: xml.ParseInfo): boolean {
  str3 = ' --->'+name + ' ' + value.getDepth(); // getDepth 获取元素在XML文档中的当前深度
  console.info(str3);
  return true; // true:继续解析 false:停止解析
}

let str2: string = '';

function funcXML2(name: string, value: string) : boolean {
  str2 += '-> ' + name + ' ' + value + ' ';
  return true; // true:继续解析 false:停止解析
}

function funcXML(name: string, value: string) : boolean {
  if (name == 'note') {
    console.info(name)
  }
  if (value == 'Play' || value == 'Work') {
    console.info('     ' + value)
  }
  if (name == 'title' || name == 'lens') {
    console.info('    ' + name);
  }
  return true
}