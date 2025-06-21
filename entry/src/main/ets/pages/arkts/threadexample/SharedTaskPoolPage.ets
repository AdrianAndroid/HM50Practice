import { relationalStore, ValuesBucket } from '@kit.ArkData';
import { collections, taskpool } from '@kit.ArkTS';
import { IValueBucket, SharedValuesBucket } from './SharedValuesBucket';

@Concurrent
async function create(context: Context) {
  const CONFIG: relationalStore.StoreConfig = {
    name: "Store.db",
    securityLevel: relationalStore.SecurityLevel.S1,
  };

  // 默认数据库文件路径为 context.databaseDir + rdb + StoreConfig.name
  let store: relationalStore.RdbStore = await relationalStore.getRdbStore(context, CONFIG);
  console.info(`Create Store.db successfully!`);

  // 创建表
  const CREATE_TABLE_SQL = "CREATE TABLE IF NOT EXISTS test (" +
    "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
    "name TEXT NOT NULL, " +
    "age INTEGER, " +
    "salary REAL, " +
    "blobType BLOB)";
  await store.executeSql(CREATE_TABLE_SQL);
  console.info(`Create table test successfully!`);
}

@Concurrent
async function insert(context: Context, valueBucketArray: collections.Array<SharedValuesBucket | undefined>) {
  const CONFIG: relationalStore.StoreConfig = {
    name: "Store.db",
    securityLevel: relationalStore.SecurityLevel.S1,
  };

  // 默认数据库文件路径为 context.databaseDir + rdb + StoreConfig.name
  let store: relationalStore.RdbStore = await relationalStore.getRdbStore(context, CONFIG);
  console.info(`Create Store.db successfully!`);

  // 数据插入
  await store.batchInsert("test", valueBucketArray as Object as Array<ValuesBucket>);
}

@Concurrent
async function query(context: Context): Promise<collections.Array<SharedValuesBucket | undefined>> {
  const CONFIG: relationalStore.StoreConfig = {
    name: "Store.db",
    securityLevel: relationalStore.SecurityLevel.S1,
  };

  // 默认数据库文件路径为 context.databaseDir + rdb + StoreConfig.name
  let store: relationalStore.RdbStore = await relationalStore.getRdbStore(context, CONFIG);
  console.info(`Create Store.db successfully!`);

  // 获取结果集
  let predicates: relationalStore.RdbPredicates = new relationalStore.RdbPredicates("test");
  let resultSet = await store.query(predicates); // 查询所有数据
  console.info(`Query data successfully! row count:${resultSet.rowCount}`);
  let index = 0;
  let result = collections.Array.create<SharedValuesBucket | undefined>(resultSet.rowCount, undefined)
  resultSet.goToFirstRow()
  do {
    let v: IValueBucket = {
      id: resultSet.getLong(resultSet.getColumnIndex("id")),
      name: resultSet.getString(resultSet.getColumnIndex("name")),
      age: resultSet.getLong(resultSet.getColumnIndex("age")),
      salary: resultSet.getLong(resultSet.getColumnIndex("salary"))
    };
    result[index++] = new SharedValuesBucket(v)
  } while (resultSet.goToNextRow());
  resultSet.close();
  return result
}

@Concurrent
async function clear(context: Context) {
  const CONFIG: relationalStore.StoreConfig = {
    name: "Store.db",
    securityLevel: relationalStore.SecurityLevel.S1,
  };

  // 默认数据库文件路径为 context.databaseDir + rdb + StoreConfig.name
  await relationalStore.deleteRdbStore(context, CONFIG);
  console.info(`Delete Store.db successfully!`);
}

@Entry
@Component
struct SharedTaskPoolPage {
  @State message: string = 'Hello World';

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('HelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(async () => {
          let context = getContext(this);

          // 数据准备
          const count = 5
          let valueBucketArray = collections.Array.create<SharedValuesBucket | undefined>(count, undefined);
          for (let i = 0; i < count; i++) {
            let v: IValueBucket = {
              id: i,
              name: "zhangsan" + i,
              age: 20,
              salary: 5000 + 50 * i
            };
            valueBucketArray[i] = new SharedValuesBucket(v);
          }
          await taskpool.execute(create, context)
          await taskpool.execute(insert, context, valueBucketArray)
          let index = 0
          let ret: collections.Array<SharedValuesBucket> =
            await taskpool.execute(query, context) as collections.Array<SharedValuesBucket>
          for (let v of ret.values()) {
            console.info(`Row[${index}].id = ${v.id}`)
            console.info(`Row[${index}].name = ${v.name}`)
            console.info(`Row[${index}].age = ${v.age}`)
            console.info(`Row[${index}].salary = ${v.salary}`)
            index++
          }
          await taskpool.execute(clear, context)
        })
    }
    .height('100%')
    .width('100%')
  }
}