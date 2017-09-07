###说明
---
在TableViewCell中, 经常使用 UILabel 与 UITextView 来存放cell中的文字, 而计算高度却经常产生问题. 本项目通过不同方式解决此问题.

1. 


###功能
---
* 通过AutoLayout 与 ManualLayout 的两种方式来获取高度.
* 对TextView输入内容即时更新Cell高度.
* iOS8 EstimatedHeightForRow


```
ManualLayout即UILabel或UITextView通过sizeThatFit的方式计算高度.
```

###参考
---
* [动态计算UITableViewCell高度详解](http://www.cocoachina.com/industry/20140604/8668.html)
* [iOS_小松哥 的简书](http://www.jianshu.com/p/64f0e1557562)
* [Mr_GCC的博客](http://blog.csdn.net/mr_gcc/article/details/51657698)

###使用记录
---
使用iOS8的EstimatedHeightForRow方式时遇到使用TextView无法计算高度的问题.更换为UILabel之后展示正确. 估计TextView因内部容器的size与自身size不一致导致.
同理, 如果cell中存在ScrollView及其子类, 应该有同样的问题.
