需要自己配置的地方使用 @@@ 来标记

//下面是创建主工程和添加两个拷贝进来的动态链接库的流程
1. 搭建工程框架
2. 创建PluginProjects 和 Plugins两个文件夹
3. 拷贝添加PluginPlatform文件夹及其内文件
4. 以上三个文件夹添加到工程中
5. 拷贝两个动态链接库到Plugins文件夹内，并在工程中引入
    此时 主target -> Build Settings -> Runpath Search Paths 配置自动变为 @executable_path/Frameworks
            主target -> Build Settings -> Framework Search Paths 配置自动变为 $(PROJECT_DIR)/Plugins 
    以上这两项不需要动，项目会自己配置好
6. 主target -> General ->Embedded Binaries里边添加两个动态链接库 @@@
7. dylib运行正常

//下面是添加一个framework工程的流程
8. 创建一个framework工程PluginOne，直接放在PluginProjects里边
9. 创建framework里边用到的类，正常写代码编写。
10. 在PluginOne.h里边添加对自己类的头文件引用，例如 #import <PluginOne/OnePrincipal.h>。 @@@
11. PluginOne的target -> Build Phases -> Headers里边添加要暴露在外面的头文件 @@@
12. 在PluginOne的工程info.plist里边，设定 Principal class 为 OnePrincipal。@@@
13. 在 PluginOne 的 target ->  Build phases 左上角点加号，添加 New Run Script Phases , 在 Run Script里边，添加脚本(备注1里边有)，该脚本把framework的输出路径指定到工程的Plugins文件夹 @@@
14. 编译一次，在Plugins文件夹内，会出现PluginOne.framework
15. 在项目中的Plugins Group中，添加PluginOne.framework的引用。@@@
16. 在主target -> General -> Embedded Binaries里边添加PluginOne.framework库 @@@
17. 正常#import <PluginOne/PluginOne.h> 然后正常调用即可。

//完成以上步骤，已经可以真机跑起来正常的动态插件了，包括内部嵌入工程的，以及外部拷贝过来的dylib，都是在相同的模式下使用了。
//实现到目前的框架结构，已经可以如下部署插件化工程：
a.  主工程只用来处理插件之间的逻辑关系，以及框架相关的优化。
b.  所有的项目内部的模块，比如首页，购物车，单品页等，都做成framework工程，直接嵌入到主工程来联合编译，可以和主工程一样进行正常的代码编写，编译输出的dylib都会汇总到Plugins文件夹内。
c.  所有的项目外部模块，比如第三方类库，工具类库等，或者远程团队单独通过framework来开发的dylib，直接拷贝到Plugins文件夹内。
d.  两种来源的dylib，采用相同的使用方式，在程序内部发挥作用，framework之间尽量不要发生耦合，




//TO DO: 需要考虑的问题是，如果一个模块级的framework需要调用到另一个功能级的framework的时候，该如何处理？

//但是目前所有的动态链接库都是在工程内部直接使用的，并不会被添加到app的bundle里边。不能通过文件读取的方式来直接拿到dylib的主负责文件。

//接下来要考虑的内容是，如何把dylib添加到app的bundle里边，并能通过PluginPlatformManager来直接获取到dylib的文件，拿到主类以后，通过反射直接启动dylib的方法。这一点还说i 比较重要，关系到是否可以通过下载dylib的方式，直接开启一个新的功能页面等。

//##这个框架里边，还需要加入router这种东西，用来做frame'work的中转
//##然后还需要再定义一套中转协议，就彻底解耦了,可以考虑一套更合理的，或者现在业界比较通用的，可能会比较好点
//##然后还得考虑埋点系统在各个插件上的部署方便性
//##还有各framework之间的调用规则，都需要考虑


。。继续




//接下来别忘了：
1. 考虑从bundle把framework拷贝到document里边，然后使用PluginPlatformManager来读取使用动态库文件，完善插件化框架
2. RDUserNotificationCenter放到github上，做成开源pods库
3. RDPushTool做成framework，添加到Star工程里边使用
4. 完成Star聊天开发






//------------------------------------------------------------------------------------------------------
备注1: 放在target里边使用的脚本：

FMK_NAME=${PROJECT_NAME}
INSTALL_DIR=${SRCROOT}/../../Plugins/${FMK_NAME}.framework
FRAMEWORK_DIR=${BUILT_PRODUCTS_DIR}/${FMK_NAME}.framework
if [ -d "${INSTALL_DIR}" ]
then
rm -rf "${INSTALL_DIR}"
fi
mkdir -p "${INSTALL_DIR}"
cp -R "${FRAMEWORK_DIR}/" "${INSTALL_DIR}/"








