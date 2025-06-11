import { connection } from '@kit.NetworkKit';
import Logger from '../common/Logger';
import { BusinessError } from '@kit.BasicServicesKit';


// 构造单例对象。
export class GlobalContext {
  private static instance: GlobalContext;
  public netList: connection.NetHandle[] = [];
  public netHandle: connection.NetHandle | null = null;
  private _objects = new Map<string, Object>();

  private constructor() {
  }

  public static getContext(): GlobalContext {
    if (!GlobalContext.instance) {
      GlobalContext.instance = new GlobalContext();
    }
    return GlobalContext.instance;
  }


  getObject(value: string): Object | undefined {
    return this._objects.get(value);
  }


  setObject(key: string, objectClass: Object): void {
    this._objects.set(key, objectClass);
  }
}


// 调用getDefaultNet方法，获取默认的数据网络(NetHandle)。
connection.getDefaultNet().then((data: connection.NetHandle) => {
  if (data.netId == 0) { // 当前无默认网络时，获取的netHandler的netid为0,属于异常情况，需要额外处理。
    return;
  }
  if (data) {
    Logger.info('GlobalContext',"sdfasdfasdfasdfadfdfsdfasdf\nasdfasdfadfdfsdfasdfasdfasdfadfd\nfsdfasdfasdfasdfadfdfsdfasdfasdfasdfadfdfsdfasdfasdfasdfadfdfsdfasdfasdfasdfadfdfsdfasdfasdfasdfadfdfsdfasdfasdfasdfadfdfsdfasdfasdfasdfadfdfsdfasdfasdfasdfadfdfsdfasdfasdfasdfadfdfsdfasdfasdfasdfadfdfsdfasdfasdfasdfadfdfsdfasdfasdfasdfadfdfsdfasdfasdfasdfadfdfsdfasdfasdfasdfadfdfsdfasdfasdfasdfadfdf")
    Logger.info('GlobalContext', "getDefaultNet get data: " + JSON.stringify(data));
    GlobalContext.getContext().netHandle = data; // 获取netHandle对应网络的能力信息。能力信息包含了网络类型、网络具体能力等网络信息。
    connection.getNetCapabilities(GlobalContext.getContext().netHandle).then((data: connection.NetCapabilities) => {
      console.info('GlobalContext', "getNetCapabilities get data: " + JSON.stringify(data)); // 获取网络类型(bearerTypes)。
      let bearerTypes: Set<number> = new Set(data.bearerTypes);
      let bearerTypesNum = Array.from(bearerTypes.values());
      for (let item of bearerTypesNum) {
        if (item == 0) { // 蜂窝网络。
          Logger.log('GlobalContext', JSON.stringify("BEARER_CELLULAR"));
        } else if (item == 1) { // Wi-Fi网络。
          Logger.log('GlobalContext', JSON.stringify("BEARER_WIFI"));
        } else if (item == 3) { // 以太网网络。
          Logger.log('GlobalContext', JSON.stringify("BEARER_ETHERNET"));
        }
      }


      // 获取网络具体能力(networkCap)。
      let itemNumber: Set<number> = new Set(data.networkCap);
      let dataNumber = Array.from(itemNumber.values());
      for (let item of dataNumber) {
        if (item == 0) { // 表示网络可以访问运营商的MMSC(Multimedia Message Service，多媒体短信服务)发送和接收彩信。
          Logger.log('GlobalContext', JSON.stringify("NET_CAPABILITY_MMS"));
        } else if (item == 11) { // 表示网络流量未被计费。
          Logger.log('GlobalContext', JSON.stringify("NET_CAPABILITY_NOT_METERED"));
        } else if (item == 12) { // 表示该网络应具有访问Internet的能力，该能力由网络提供者设置。
          Logger.log('GlobalContext', JSON.stringify("NET_CAPABILITY_INTERNET"));
        } else if (item == 15) { // 表示网络不使用VPN(Virtual Private Network，虚拟专用网络)。
          Logger.log('GlobalContext', JSON.stringify("NET_CAPABILITY_NOT_VPN"));
        } else if (item == 16) { // 表示该网络访问Internet的能力被网络管理成功验证，该能力由网络管理模块设置。
          Logger.log('GlobalContext', JSON.stringify("NET_CAPABILITY_VALIDATED"));
        }
      }
    })
  }
});


// 获取netHandle对应网络的连接信息。连接信息包含了链路信息、路由信息等。
connection.getConnectionProperties(GlobalContext.getContext().netHandle)
  .then((data: connection.ConnectionProperties) => {
    Logger.info('GlobalContext', "getConnectionProperties get data: " + JSON.stringify(data));
  })


// 调用getAllNets,获取所有处于连接状态的网络列表(Array<NetHandle>)。
connection.getAllNets().then((data: connection.NetHandle[]) => {
  Logger.info('GlobalContext', "getAllNets get data: " + JSON.stringify(data));
  if (data) {
    GlobalContext.getContext().netList = data;


    let itemNumber: Set<connection.NetHandle> = new Set(GlobalContext.getContext().netList);
    let dataNumber = Array.from(itemNumber.values());
    for (let item of dataNumber) { // 循环获取网络列表每个netHandle对应网络的能力信息。
      connection.getNetCapabilities(item).then((data: connection.NetCapabilities) => {
        Logger.info('GlobalContext', "getNetCapabilities get data: " + JSON.stringify(data));
      })


      // 循环获取网络列表每个netHandle对应的网络的连接信息。
      connection.getConnectionProperties(item).then((data: connection.ConnectionProperties) => {
        Logger.info('GlobalContext', "getConnectionProperties get data: " + JSON.stringify(data));
      })
    }
  }
})

// 使用默认网络解析主机名以获取所有IP地址。
try {
  connection.getAddressesByName("https://www.baidu.com/").then((data: connection.NetAddress[]) => {
    Logger.info('GlobalContext', "Succeeded to get data: " + JSON.stringify(data));
  });
} catch (e) {
  Logger.info('GlobalContext', "Failed to get data: " + JSON.stringify(e));
}