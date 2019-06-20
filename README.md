# BBQ

## 背景

---

对于iOS繁杂的界面布局语法，以及常用控件松散的代理方法编写, 业界已有SnpKit以及RxSwift框架解决方案，本人还是抽空写了此SDK,主要是因为个人觉SnpKit和RxSwift的框架太过重量级，编译耗时，随便写个小demo就导入一大坨代码。

### 功能

---

BBQ初衷就是让写代码舒服一些，目前主要有两个功能：

1. 简化iOS繁杂的界面布局语法 
2. 将常用控件响应方法由代理改为block回调

### 使用示例

---

一、布局示例

    初始化一个待布局的子视图，将其添加到父视图，假设子视图为subview,父视图为 parentview:
    let parentview = UIView()
    let subview = UIView()
    parentview.addSubview(subview)  

    将subview设置到父视图中央，宽100，高50： 
    subview.bbq!.centerX().centerY().size(100,50)

    将subview设为距离父视图左边50，上边60,宽150,高100: 
    subview.bbq()!.left(50).top(60).size(150, 200)

更多布局示例请参考文件‘UIView+layout.swift’,代码很简单，一看就懂用😄

二、控件响应示例

    UIButton点击响应写法：
    let btn = UIButton();
    btn.onTap { (btn) in  // do stuff}.addOwner(self)

    UITextFiled文字变动监听: 
    let textfield = UITextField(); 
    textfield.onTextChange { (tf) in // do stuff}.addOwner(self)

    UITextView文字变动监听: 
    let textview = UITextView(); 
    textview.onTextViewChange { (tv) in // do stuff}.addOwner(self)

    UISwitch开关监听：
    let switch = UISwitch();
    switch.onToggle { (switch) in //do stuff}.addOwner(self)

上面的addOwner(self)里面self是啥呢，一般就是viewcontroller 对象， 因为该对象持有上述UI控件，为了简化调用者内存管理而存在

更多控件响应示例请参考源码, 代码很简单，一看就懂用😄

### 安装

---

需要先安装cocoaPods

在Podfile加入下面一行：pod 'BBQ'

终端运行 pod install

### 总结

---

本SDK并没有RxSwift异步链式函数响应式功能，主要致力于简化原生iOS繁杂的界面布局语法，以及常用控件松散的代理方法编写。有啥好的建议欢迎@me。