#include "napi/native_api.h"
#include <thread>
static void *CreateArkRuntimeFunc(void *arg) {
    // 1. 创建基础运行环境
    napi_env env = nullptr;
    napi_status ret = napi_create_ark_runtime(&env);
    if (ret != napi_ok) {
        std::abort();
    }
    // 2. 加载自定义模块，假定SendableObjTest中提供创建sendable对象的方法newSendable
    napi_value test = nullptr;
    ret = napi_load_module_with_info(env, "entry/src/main/ets/pages/arkts/threadexample/SendableObjTest",
                                     "com.example.myapplication/entry", &test);
    if (ret != napi_ok) {
        std::abort();
    }
    napi_value sendableObjTest = nullptr;
    ret = napi_get_named_property(env, test, "SendableObjTest", &sendableObjTest);
    if (ret != napi_ok) {
        std::abort();
    }
    // 3. 使用ArkTS中的newSendable，假设sendableObjTest中有一个函数newSendable能返回sendable对象
    napi_value newSendable = nullptr;
    ret = napi_get_named_property(env, sendableObjTest, "newSendable", &newSendable);
    if (ret != napi_ok) {
        std::abort();
    }
    // 4. 调用newSendable函数返回新创建的sendable对象，并保存在result中
    napi_value result = nullptr;
    ret = napi_call_function(env, sendableObjTest, newSendable, 0, nullptr, &result);
    if (ret != napi_ok) {
        std::abort();
    }
    // 5. 获取ArkTS返回的结果
    int value0;
    napi_get_value_int32(env, result, &value0);
    if (value0 != 1024) {
        std::abort();
    }
    // 6. 销毁ArkTS环境
    ret = napi_destroy_ark_runtime(&env);
    return nullptr;
}

static void *serializationData = nullptr;
static void *CreateEnvAndSendSendable(void *) {
    // 1. 创建基础运行环境
    napi_env env = nullptr;
    napi_status ret = napi_create_ark_runtime(&env);
    if (ret != napi_ok) {
        std::abort();
    }
    // 2. 加载自定义模块，假定SendableObjTest中提供创建sendable对象的方法newSendable
    napi_value test = nullptr;
    ret = napi_load_module_with_info(env, "entry/src/main/ets/pages/arkts/threadexample/SendableObjTest", "com.example.myapplication/entry",
                                     &test);
    if (ret != napi_ok) {
        std::abort();
    }
    napi_value sendableObjTest = nullptr;
    ret = napi_get_named_property(env, test, "SendableObjTest", &sendableObjTest);
    if (ret != napi_ok) {
        std::abort();
    }
    // 3. 使用ArkTS中的newSendable，假设sendableObjTest中有一个函数newSendable能返回sendable对象
    napi_value newSendable = nullptr;
    ret = napi_get_named_property(env, sendableObjTest, "newSendable", &newSendable);
    if (ret != napi_ok) {
        std::abort();
    }
    // 4. 调用newSendable函数返回新创建的sendable对象，并保存在result中
    napi_value result = nullptr;
    ret = napi_call_function(env, sendableObjTest, newSendable, 0, nullptr, &result);
    if (ret != napi_ok) {
        std::abort();
    }
    // 5. 序列化sendable对象
    napi_value undefined;
    napi_get_undefined(env, &undefined);
    ret = napi_serialize(env, result, undefined, undefined, &serializationData);
    if (ret != napi_ok) {
        std::abort();
    }
    return nullptr;
}

static void *CreateEnvAndReceiveSendable(void *) {
    // 1. 创建基础运行环境
    napi_env env = nullptr;
    napi_status ret = napi_create_ark_runtime(&env);
    if (ret != napi_ok) {
        std::abort();
    }
    // 2. 反序列化获取sendable共享对象，结果保存在result中，这个result就可以通过napi接口进行各种操作了
    napi_value result = nullptr;
    ret = napi_deserialize(env, serializationData, &result);
    if (ret != napi_ok) {
        std::abort();
    }
    // 3. 删除序列化数据
    ret = napi_delete_serialization_data(env, serializationData);
    if (ret != napi_ok) {
        std::abort();
    }
    napi_valuetype valuetype0;
    napi_typeof(env, result, &valuetype0);
    if (valuetype0 != napi_number) {
        std::abort();
    }
    int value0;
    napi_get_value_int32(env, result, &value0);
    if (value0 != 1024) {
        std::abort();
    }
    return nullptr;
}

static napi_value TestSendSendable([[maybe_unused]] napi_env env, [[maybe_unused]] napi_callback_info info) {
    std::thread t1(CreateEnvAndSendSendable, nullptr);
    t1.join();
    std::thread t2(CreateEnvAndReceiveSendable, nullptr);
    t2.join();
    return nullptr;
}

EXTERN_C_START
static napi_value Init(napi_env env, napi_value exports) {
    napi_property_descriptor desc[] = {
        {"testSendSendable", nullptr, TestSendSendable, nullptr, nullptr, nullptr, napi_default, nullptr}};
    napi_define_properties(env, exports, sizeof(desc) / sizeof(desc[0]), desc);
    return exports;
}
EXTERN_C_END

static napi_module demoModule = {
    .nm_version = 1,
    .nm_flags = 0,
    .nm_filename = nullptr,
    .nm_register_func = Init,
    .nm_modname = "entry",
    .nm_priv = ((void *)0),
    .reserved = {0},
};

extern "C" __attribute__((constructor)) void RegisterEntryModule(void) { napi_module_register(&demoModule); }


static napi_value Add(napi_env env, napi_callback_info info) {
    size_t argc = 2;
    napi_value args[2] = {nullptr};

    napi_get_cb_info(env, info, &argc, args, nullptr, nullptr);

    napi_valuetype valuetype0;
    napi_typeof(env, args[0], &valuetype0);

    napi_valuetype valuetype1;
    napi_typeof(env, args[1], &valuetype1);

    double value0;
    napi_get_value_double(env, args[0], &value0);

    double value1;
    napi_get_value_double(env, args[1], &value1);

    napi_value sum;
    napi_create_double(env, value0 + value1, &sum);

    return sum;
}

//EXTERN_C_START
//static napi_value Init(napi_env env, napi_value exports) {
//    napi_property_descriptor desc[] = {{"add", nullptr, Add, nullptr, nullptr, nullptr, napi_default, nullptr}};
//    napi_define_properties(env, exports, sizeof(desc) / sizeof(desc[0]), desc);
//    return exports;
//}
//EXTERN_C_END
//
//static napi_module demoModule = {
//    .nm_version = 1,
//    .nm_flags = 0,
//    .nm_filename = nullptr,
//    .nm_register_func = Init,
//    .nm_modname = "entry",
//    .nm_priv = ((void *)0),
//    .reserved = {0},
//};
//extern "C" __attribute__((constructor)) void RegisterEntryModule(void) { napi_module_register(&demoModule); }
