# CYDropDownMenu
[English](https://github.com/chenyun122/CYDropDownMenu/blob/master/README.md)   

这是一个iOS下拉菜单(或选项), 有点类似于桌面程序的菜单。运行效果参考下面Gif动图。  

<p align="center" >
<img src="https://github.com/chenyun122/CYDropDownMenu/blob/master/ScreenShots/CYDropDownMenu.gif?raw=true" alt="CYDropDownMenu" title="CYDropDownMenu" width="35%" height="35%" />
</p>

## 集成到项目
###  CocoaPods
在 Xcode 项目中通过 CocoaPods 集成 CYDropDownMenu,只需在 `Podfile` 文件中指定以下内容:
```ruby
platform :ios, '8.0'
use_frameworks!

target 'YourProjectName' do
   pod 'CYDropDownMenu', '~> 1.0.2'
end
```
对于Swift项目, 集成之后，记得在使用前先通过 `import CYDropDownMenu` 导入该模块。

###  手动
把源码文件夹 `CYDropDownMenu` 复制到您项目的相应目录下，再在 Xcode 加入该文件夹即可。

## 使用
集成之后可以像`UIView`那样使用它。通过Demo项目您可以快速了解如何使用，以及更多细节。

**创建 `CYDropDownMenu` 并设置菜单数据:**
```Objective-C
//Use line below or make dropDownMenu's frame.origin.y >= 64 to avoid the wrong insets if ViewController is with an UINavigationController
//self.automaticallyAdjustsScrollViewInsets = NO;

CGFloat navigationBarHeight = ([UIApplication sharedApplication].statusBarFrame.size.height + (self.navigationController.navigationBar.frame.size.height ?: 0.0));

CYDropDownMenu *dropDownMenu = [[CYDropDownMenu alloc] initWithFrame:CGRectMake(0, navigationBarHeight, self.view.frame.size.width, 45)];
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


**样式定制(可选)**
```Objective-C
// Additional customizations:
dropDownMenu.sectionTitleColor = UIColor.lightGrayColor;  //The color of top titles
dropDownMenu.sectionTitleTintColor = UIColor.redColor;    //The color of top selected titles
dropDownMenu.itemColor = UIColor.lightGrayColor;          //The color of menu item
dropDownMenu.itemTintColor = UIColor.redColor;            //The color of selected menu item
dropDownMenu.bottomLineHidden = YES;                      //Indicates whether display the bottom line
dropDownMenu.maxMenuHeight = 100;                         //Keep this to nil usually. The Menu height is automatically calculated, and limited in rootview's height. Set this property if you want to limit the height precisely.
dropDownMenu.rootView = self.view;                        //Keep this to nil usually. The ViewController's view will be considered as rootView if the property is not set. Set this property to limite the DropDownMenu and its actions into a particular SubView.
```


**事件处理**
```Objective-C
#pragma mark - CYDropDownMenuDelegate
- (void)CYDropDownMenu:(CYDropDownMenu *)dropDownMenu didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Menu item '%@' of section '%@' is selected",dropDownMenu.sectionsItems[indexPath.section][indexPath.row], dropDownMenu.sectionTitles[indexPath.section]);
}
```


### Swift项目  
我们推荐使用CocoaPods来集成此库到您的项目中。然后如下编码：
```Swift

import UIKit
import CYDropDownMenu

class ViewController: UIViewController,CYDropDownMenuDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let topbarHeight = UIApplication.shared.statusBarFrame.size.height + (self.navigationController != nil ? self.navigationController!.navigationBar.frame.size.height : CGFloat(0.0))
        let dropDownMenu = CYDropDownMenu(frame: CGRect(x: 0.0, y: topbarHeight, width: self.view.frame.size.width, height: 45.0))
        dropDownMenu.sectionTitles = ["Category", "Price"];
        dropDownMenu.sectionsItems = [["All","Food", "Hotel", "Bank", "Cinema", "Entertainment"],
                                      ["$0", "$1-$100", "$101-$1000", ">$1000"]];
        dropDownMenu.autoCenterTitles = true
        dropDownMenu.delegate = self
        
        self.view.addSubview(dropDownMenu);
    }

    // MARK: CYDropDownMenuDelegate
    func cyDropDownMenu(_ dropDownMenu: CYDropDownMenu!, didSelectItemAt indexPath: IndexPath!) {
        print("Menu item '\(dropDownMenu.sectionsItems[indexPath.section][indexPath.row])' of section '\(dropDownMenu.sectionTitles[indexPath.section])' is selected")
    }
}

```

## 许可协议
CYDropDownMenu is released under the MIT license. See LICENSE for details.
