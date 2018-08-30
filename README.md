# CYDropDownMenu
An iOS Drop Down Menu. Screenshot:  

<p align="center" >
<img src="https://github.com/chenyun122/CYDropDownMenu/blob/master/ScreenShots/CYDropDownMenu.gif?raw=true" alt="CYDropDownMenu" title="CYDropDownMenu" width="35%" height="35%" />
</p>


## Usage
Copy the source code in the **/CYDropDownMenu** folder into your project, then use it like `UIView`. Please check details in Demo project.

**Create the `CYDropDownMenu` and set data:**
```Objective-C
//Use line below or make dropDownMenu's frame.origin.y >= 64 to avoid the wrong insets if ViewController is with an UINavigationController
//self.automaticallyAdjustsScrollViewInsets = NO;

CYDropDownMenu *dropDownMenu = [[CYDropDownMenu alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 45)];
dropDownMenu.sectionTitles = @[@"Category", @"Price", @"Distance", @"Order", @"More"];
dropDownMenu.sectionsItems = @[@[@"All",@"Food", @"Hotel", @"Bank", @"Cinema", @"Entertainment"],
                                @[@"$0", @"$1-$100", @"$101-$1000", @">$1000"],
                                @[@"0-10km", @"11-100km", @"101-1000km", @">1000km"],
                                @[@"Recommended", @"Near to me", @"The highest sales", @"Hots"],
                                @[@"24 Hours", @"Available in Holidays"]];
dropDownMenu.autoCenterTitles = YES; //for the case there are only 1 or 2 titles, we center them.
dropDownMenu.delegate = self;
[self.view addSubview:dropDownMenu];
```


## Customization(Optional)
```Objective-C
// Additional customizations:
dropDownMenu.sectionTitleColor = UIColor.lightGrayColor;  //The color of top titles
dropDownMenu.sectionTitleTintColor = UIColor.redColor;    //The color of top selected titles
dropDownMenu.itemColor = UIColor.lightGrayColor;          //The color of menu item
dropDownMenu.itemTintColor = UIColor.redColor;            //The color of selected menu item
dropDownMenu.bottomLineHidden = YES;                      //Indicates whether display the bottom line
dropDownMenu.maxMenuHeight = 100;                         //The Menu height is automatically calculated, and limited in rootview's height. Set this property if you want to limit the height precisely.
dropDownMenu.rootView = self.view;                        //The ViewController's view will be considered as rootView if the property is not set. Set this property if limited the DropDownMenu and its actions into a particular SubView.
```

___
[中文]  
这是一个iOS下拉菜单(或选项)。运行效果参考上面Gif动图。

## 使用
拷贝**CYDropDownMenu**目录下源代码到您的项目中，就可以像使用`UIView`那样使用它。请参考上面代码或下载运行Demo项目。

## 定制（可选）
请参考上面代码

___
## License
StepIndicator is released under the MIT license. See LICENSE for details.