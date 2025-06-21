// Config.ets


import { ArkTSUtils } from '@kit.ArkTS';


"use shared"


@Sendable
class Config {
  lock: ArkTSUtils.locks.AsyncLock = new ArkTSUtils.locks.AsyncLock
  isLogin: boolean = false;
  loginUser?: string;
  wifiOn: boolean = false


  async login(user: string) {
    return this.lock.lockAsync(() => {
      this.isLogin = true;
      this.loginUser = user
    }, ArkTSUtils.locks.AsyncLockMode.EXCLUSIVE)
  }


  async logout(user?: string) {
    return this.lock.lockAsync(() => {
      this.isLogin = false
      this.loginUser = ""
    }, ArkTSUtils.locks.AsyncLockMode.EXCLUSIVE)
  }


  async getIsLogin(): Promise<boolean> {
    return this.lock.lockAsync(() => {
      return this.isLogin
    }, ArkTSUtils.locks.AsyncLockMode.SHARED)
  }


  async getUser(): Promise<string> {
    return this.lock.lockAsync(() => {
      return this.loginUser!
    }, ArkTSUtils.locks.AsyncLockMode.SHARED)
  }


  async setWifiState(state: boolean) {
    return this.lock.lockAsync(() => {
      this.wifiOn = state
    }, ArkTSUtils.locks.AsyncLockMode.EXCLUSIVE)
  }


  async isWifiOn() {
    return this.lock.lockAsync(() => {
      return this.wifiOn;
    }, ArkTSUtils.locks.AsyncLockMode.SHARED)
  }
}


export let config = new Config()