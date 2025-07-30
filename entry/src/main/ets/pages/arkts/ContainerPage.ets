import { ArrayList, Deque, Stack, List, LinkedList, Queue, HashMap, TreeMap, LightWeightMap,
  PlainArray,
  HashSet,
  TreeSet,
  LightWeightSet} from '@kit.ArkTS';

@Entry
@Component
struct ContainerPage {
  build() {
    Column({space: 20}) {
      Button('线性容器')
        .onClick(() => {
          this.linearContainer()
        })

      Button('非线性容器')
        .onClick(() => {
          this.nonLinearContainer()
        })
    }
    .height('100%')
    .width('100%')
  }

  linearContainer() {
    // ArrayList	动态数组，占用一片连续的内存空间。需要频繁读取元素时推荐使用。
    let arrayList1: ArrayList<string> = new ArrayList();
    arrayList1.add('a'); // 增加一个值为'a'的元素
    let arrayList2: ArrayList<number> = new ArrayList();
    arrayList2.add(1); // 增加一个值为1的元素
    console.info(`result: ${arrayList2[0]}`); // 访问索引为0的元素。输出：result: 1
    arrayList1[0] = 'one'; // 修改索引为0的元素
    console.info(`result: ${arrayList1[0]}`); // 输出：result: one

    // List	单向链表，占用的空间可以不连续。推荐在需要频繁插入和删除元素，且需要使用单向链表时使用。
    let list1: List<string> = new List();
    list1.add('a'); // 增加一个值为'a'的元素
    let list2: List<number> = new List();
    list2.insert(0, 0); // 在0号位置插入（增加）一个值为0的元素
    let list3: List<Array<number>> = new List();
    let b2 = [1, 2, 3];
    list3.add(b2); // 增加一个Array类型的元素
    console.info(`result: ${list1[0]}`); // 访问索引为0的元素。输出：result: a
    console.info(`result: ${list3.get(0)}`); // 访问索引为0的元素。输出：result: 1,2,3


    // LinkedList	双向链表，占用的空间可以不连续。推荐在需要频繁插入和删除元素，且需要使用双向链表时使用。
    let linkedList : LinkedList<string> = new LinkedList();
    linkedList.add('1');
    linkedList.removeFirst();
    linkedList.add('1');

    // Deque	双端队列，支持从头尾两端进行元素的插入和删除操作，占用连续的内存空间。推荐在需要频繁访问和操作头尾元素时使用。
    let deque1: Deque<string> = new Deque();
    deque1.insertFront('a'); // 头部增加一个值为'a'的元素
    let deque2: Deque<number> = new Deque();
    deque2.insertFront(1); // 头部增加一个值为1的元素
    console.info(`result: ${deque2.getFirst()}`); // 访问队列首部的元素。输出：result: 1
    deque1.insertEnd('one'); // 尾部增加一个值为'one'的元素
    console.info(`result: ${deque1.getLast()}`); // 访问队列尾部的元素。输出：result: one

    // Queue	队列，是一种从尾部插入元素、从头部移除元素的数据结构，占用连续的内存空间，适用于先进先出的场景。
    let queue: Queue<string> = new Queue();
    queue.add('1');
    queue.add('2');
    queue.pop();

    // Stack	栈，只能从一端进行插入和删除操作，占用连续的内存空间。适用于先进后出的场景。
    let stack1: Stack<string> = new Stack();
    stack1.push('a'); // 向栈里增加一个值为'a'的元素
    let stack2: Stack<number> = new Stack();
    stack2.push(1); // 向栈里增加一个值为1的元素
    console.info(`result: ${stack1.peek()}`); // 访问栈顶元素。输出：result: a
    console.info(`result: ${stack2.pop()}`); // 删除栈顶元素并返回该删除元素。输出：result: 1
    console.info(`result: ${stack2.length}`); // 输出：result: 0

    // Vector	动态数组，占用连续的内存空间。已不再维护，推荐使用 ArrayList。
  }

  nonLinearContainer() {
    // HashMap	存储具有关联关系的键值对集合。键唯一，依据键的hash值确定存储位置。访问速度快，但不能自定义排序。推荐用于需要快速存取、插入删除键值对数据时使用。
    let hashMap1: HashMap<string, number> = new HashMap();
    hashMap1.set('a', 123); // 增加一个键为'a'，值为123的元素
    let hashMap2: HashMap<number, number> = new HashMap();
    hashMap2.set(4, 123); // 增加一个键为4，值为123的元素
    hashMap2.set(null, 1)
    console.info(`result: ${hashMap2.hasKey(4)}`); // 判断是否含有键为4的元素。输出：result: true
    console.info(`result: ${hashMap1.get('a')}`); // 访问键为'a'的元素。输出：result: 123

    // HashSet	存储一系列值的集合。值唯一，依据值的hash确定存储位置。允许放入null值，但不能自定义排序。适用于不重复的集合或去重某个集合。
    let hashSet: HashSet<string> = new HashSet();
    console.log(hashSet.add('1') + '')
    console.log(hashSet.add('1') + '')
    console.log(hashSet.add('1') + '')
    console.log(hashSet.add('1') + '')

    // TreeMap	存储具有关联关系的键值对集合。键唯一，允许用户自定义排序方法。适用于按序存储键值对的场景。
    let treeMap: TreeMap<string, number> = new TreeMap();
    treeMap.set('a', 123); // 增加一个键为'a'，值为123的元素
    treeMap.set('6', 356); // 增加一个键为'6'，值为356的元素
    console.info(`result: ${treeMap.get('a')}`); // 访问键为'a'的元素。输出：result: 123
    console.info(`result: ${treeMap.getFirstKey()}`); // 访问首元素。输出：result: 6
    console.info(`result: ${treeMap.getLastKey()}`); // 访问尾元素。输出：result: a

    // TreeSet	存储一系列值的集合。值唯一，允许用户自定义排序方法，但不建议放入null值。适用于按序存储集合的场景。
    let treeSet: TreeSet<string> = new TreeSet();
    console.log(treeSet.add('1') + '')
    console.log(treeSet.add('1') + '')
    console.log(treeSet.add('1') + '')
    console.log(treeSet.add('1') + '')

    // LightWeightMap	存储具有关联关系的键值对集合。键唯一，底层采用轻量级结构，空间占用小。推荐用于存取键值对数据且内存不充足时。
    let lightWeightMap: LightWeightMap<string, number> = new LightWeightMap();
    lightWeightMap.set('x', 123); // 增加一个键为'x'，值为123的元素
    lightWeightMap.set('8', 356); // 增加一个键为'8'，值为356的元素
    console.info(`result: ${lightWeightMap.get('a')}`); // 访问键为'a'的元素。输出：result: undefined
    console.info(`result: ${lightWeightMap.get('x')}`); // 访问键为'x'的元素，获取其值。输出：result: 123
    console.info(`result: ${lightWeightMap.getIndexOfKey('8')}`); // 访问键为'8'的元素，获取其索引。输出：result: 0

    // LightWeightSet	存储一系列值的集合。值唯一，底层采用轻量级结构，空间占用小。适用于不重复的集合或去重某个集合。
    let lightWeightSet: LightWeightSet<string> = new LightWeightSet();
    let lightWeightSet2: LightWeightSet<string> = new LightWeightSet();
    console.log(lightWeightSet.add('1') + '')
    console.log(lightWeightSet.add('1') + '')
    console.log(lightWeightSet.add('1') + '')
    console.log(lightWeightSet.add('1') + '')
    lightWeightSet.addAll(lightWeightSet2)

    // PlainArray	存储具有关联关系的键值对集合。键唯一，底层与LightWeightMap一样采用轻量级结构，键固定为number类型。适用于存储键为number类型键值对的场景。
    let plainArray: PlainArray<string> = new PlainArray();
    plainArray.add(1, 'sdd'); // 增加一个键为1，值为'sdd'的元素
    plainArray.add(2, 'sff'); // 增加一个键为2，值为'sff'的元素
    console.info(`result: ${plainArray.get(1)}`); // 访问键为1的元素，获取值。输出：result: sdd
    console.info(`result: ${plainArray.getKeyAt(1)}`); // 访问索引为1的元素，获取键。输出：result: 2
  }
}