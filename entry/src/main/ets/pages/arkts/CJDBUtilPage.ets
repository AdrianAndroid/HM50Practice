// import { Table, Id, ColumnType, CJBaseModel, Columns, ObjToText, Ignore, CJDBUtil } from 'cjdb';
// import { BusinessError } from '@kit.BasicServicesKit';
// import { CJLogUtil } from 'cjdb/src/main/ets/db/CJLogUtil';
//
// ////////////////////////////////////////////////////////////////
// // https://atomgit.com/cj-open/CJOpenNext/tree/master/cjdb
// ///////////////////////////////////////////////////////////////
//
// // @Table("Person") // @Table("表名")
// @Observed // 如果同时使用多注解，请将@Table() 放在最后，紧跟class
// @Table() // 不传参数时，表名默认为类名，
// class Person extends CJBaseModel {
//   // ==>> id属性都必填 <<==
//   //@Id = {
//   //columnName?: string,列名
//   //types: ColumnType,类型
//   //autoincrement?: boolean，是否自增，如果检测到为INTEGER会默认自增长，如果不想自增长加上false
//   //}
//   @Id({types: ColumnType.INTEGER})
//   id: number = -1
//
//   //Columns 参数:
//   //columnName?: string, 对应列名,非必填，默认属性名
//   //types: ColumnType 对应列类型，必填，
//   @Columns({columnName: "name",types: ColumnType.TEXT})
//   name: string = ''
//
//   @Columns({types: ColumnType.INTEGER})
//   old: number = -1
//
//   @Columns({types: ColumnType.INTEGER})
//   sex: number = -1
//
//   @Columns({types: ColumnType.TEXT})
//   img: string = ''
//
//   /**
//    * 注意：当在对像类型上使用@ObjToText()时，
//    * 会自动将对象JSON序列化成字符串存储，
//    * 查询时同样会自动将字符串JSON解析成对象
//    * 例如以下两个，存储时会使用：JSON.stringfy()
//    * 查询时会自动采用：JSON.parse()
//    * 如果有特殊需求请在存储/查询时使用remap重映射
//    */
//   @ObjToText()
//   point:[number, number] = [-1, -1]
//   @ObjToText()
//   house: House = new House()
//
//   /**
//    * @Ignore() 修饰时，test不会作为数据库存储字段处理
//    * 添加上该后续存储无需手动重构数据结构
//    */
//   @Ignore()
//   test: string = ''
// }
//
// class House {
//
// }
//
// @Entry
// @Component
// struct CJDBUtilPage {
//   @State message: string = 'Hello World';
//
//   build() {
//     RelativeContainer() {
//       Text(this.message)
//         .id('CJDBUtilPageHelloWorld')
//         .fontSize($r('app.float.page_text_font_size'))
//         .fontWeight(FontWeight.Bold)
//         .alignRules({
//           center: { anchor: '__container__', align: VerticalAlign.Center },
//           middle: { anchor: '__container__', align: HorizontalAlign.Center }
//         })
//         .onClick(() => {
//           this.message = 'Welcome';
//         })
//     }
//     .height('100%')
//     .width('100%')
//   }
//
//   save() {
//     let person: Person = new Person()
//     CJDBUtil.getInstance('').save(person).then((id) => {
//       CJLogUtil.info('TAG', "保存成功", id)
//     }).catch((err: BusinessError) => {
//       CJLogUtil.error('TAG', "保存异常", JSON.stringify(err))
//     })
//     person.point = [99, 66]
//     CJDBUtil.getInstance('').save(person, (instance: object) => {
//       return instance
//     })
//     CJDBUtil.getInstance('').all<Person>(typeof Person, (key, value: object) => {
//       // if (key == "point") {
//       //   return []
//       // } else {
//       //   return JSON.parse(value)
//       // }
//     })
//   }
// }