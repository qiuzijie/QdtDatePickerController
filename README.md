# QdtDatePickerController

A more modes DatePicker than UIDatePicker

一款可以自由搭配时间样式的时间选择器
---


### 效果展示

#### 支持年、月、日、时、分、秒五种格式选择
![xxx](https://github.com/qiuzijie/QdtDatePickerController/raw/master/gif/2.gif)


#### 五种时间格式的自由搭配，例如年、月、时这种不合理的时间选择也OK
![xxx](https://github.com/qiuzijie/QdtDatePickerController/raw/master/gif/1.gif)


### 介绍及使用

#### QdtDatePickerController
时间控件主体为继承自`UIViewController`的`QdtDatePickerController`类，采用present的方式来展示控件。

通过一个`QdtDatePickerControllerViewModel`来配置`QdtDatePickerController`所需的基本数据，如果传nil则会显示当前时间以及默认样式。

#### QdtDatePickerControllerViewModel
用于决定选择器的样式以及默认时间
`QdtDatePickerControllerDateType`：包含五种类型的位移枚举，自由组合。

#### 使用：
```
QdtDatePickerControllerDateType dateType = (QdtDateTypeDay|QdtDateTypeYear|QdtDateTypeMonth);
QdtDatePickerControllerViewModel *vm = [[QdtDatePickerControllerViewModel alloc] initWithDate:[NSDate date] type:dateType];
QdtDatePickerController *datePicker = [[QdtDatePickerController alloc] initWithViewModel:vm selected:^(NSDate *date) {

}];
[self presentViewController:datePicker animated:YES completion:^{
    ;
}];
```
