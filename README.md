## Cupertino风格版本网易云音乐7.0新版

> 之前有大神写过Material风格的网易云音乐 [github地址](https://github.com/fluttercandies/NeteaseCloudMusic),本着学习的态度，参考大神的工程架构和代码风格，尝试做一个Cupertino风格（iOS）的网易云音乐。恰逢最近网易云更新7.0版本，页面有很大变化。具有挑战难度。
>
> 我是19年12月才接触futter和dart，之前是web前端开发，现阶段代码有写丑陋，以联系widget使用和实现ui构建，简单功能实现为主

### 注意事项

接口使用的开源的node接口，[github地址](https://github.com/Binaryify/NeteaseCloudMusicApi)
构建项目之前先在本地启动node服务
修改net_utils.dart文件中的baseUrl配置
```dart
class NetUtils {
   ...
  static const String baseUrl = 'http://192.168.1.103:3000';
```

### 部分效果图

#### 发现页面
![发现页面](pic/发现页面.png)

#### 我的页面
![我的页面](pic/我的页面.png)


### 系列文章
> + [《Flutter实战: 如何同时设置Container的图片和颜色》](https://juejin.im/post/5e1c1a94e51d4557eb6205c0)
> 
> + [《Flutter 实战：如何设置一个透明的CupertinoNavigationBar》](https://juejin.im/post/5e1c1ddce51d451c774dc7af)
> 
> + [《Flutter实战： 如何实现网易云音乐7.0（新版）我的页面的动态背景效果》](https://juejin.im/post/5e20a7086fb9a02fcb1f7bf2)
