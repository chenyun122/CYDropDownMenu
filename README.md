# CYDropDownMenu
[简体中文](https://github.com/chenyun122/CYDropDownMenu/blob/master/README_CN.md)   

An iOS Drop Down Menu. It's very similar to menus for desktop applications. Screenshot:  

<p align="center" >
<img src="https://github.com/chenyun122/CYDropDownMenu/blob/master/ScreenShots/CYDropDownMenu.gif?raw=true" alt="CYDropDownMenu" title="CYDropDownMenu" width="35%" height="35%" />
</p>

## Installation
###  CocoaPods
To integrate CYDropDownMenu into your Xcode project using CocoaPods, specify it in your `Podfile`:
```ruby
platform :ios, '8.0'
use_frameworks!

target 'YourProjectName' do
   pod 'CYDropDownMenu', '~> 1.0.0'
end
```
For Swfit, remember to `import CYDropDownMenu` module before using it.

###  Manually
Copy the source code in the **/CYDropDownMenu** folder into your project.  

## Usage
Just use it like `UIView`. You could quickly find out how to use it with more details in the Demo project.

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


**Customization(Optional)**
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


**Handle the event**
```Objective-C
#pragma mark - CYDropDownMenuDelegate
- (void)CYDropDownMenu:(CYDropDownMenu *)dropDownMenu didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Menu item '%@' of section '%@' is selected",dropDownMenu.sectionsItems[indexPath.section][indexPath.row], dropDownMenu.sectionTitles[indexPath.section]);
}
```


### For Swift  
We recommend using `CocoaPods` to integrate the library into your project. Then code it like this:
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

## License
CYDropDownMenu is released under the MIT license. See LICENSE for details.