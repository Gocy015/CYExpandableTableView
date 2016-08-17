## CYExpandableTableView
An expandable table view for iOS ,has its default behaviors ,but you can also customize it easily !


### Preview

By default ,CYExpandableTableView displays only text contents.

![](Images/Default.gif)

You can easily change text color / fill color just by setting following attributes (tbvc is an instance of CYExpandableTableViewController):
<pre>
<code>
    tbvc.selectedHeaderFillColor = Header color when you selected a header;
    tbvc.selectedHeaderTextColor = Text color when you selected a header;
    tbvc.normalHeaderFillColor = Header color when a header is not selected;
    tbvc.normalHeaderTextColor = Text color when a header is not selected;
</code>
</pre>

and the colors will show as expected.

##### Customization?
By implementing a few protocols ,you can also fully customize the appearance of the table view ,just like what i did in the demo project:

![](Images/Custom.gif)


### Integration

If you uses Cocoapods , just add
`pod 'CYExpandableTableView'`  
 to your Podfile ,and cocoapods does the magic !
 
You can also download or clone the project ,and drag the entire 'CYExpandableTableView' into your project !

Either way ,you are now ready to go :)


### Usage

#### Basic usage

If you are to use the very basis of the table view ,it couldn't be easier :

First , add `import "ExpandableObjectProtocol.h"` to your data model class ,and implement all methods & properties of the protocol.

Next , go to your view controller which is going to hold the actual table view ,import `"CYExpandableTableViewController.h"` , set up appearance like colors ,and then add the table view to your own view ,assign your array of data to the CYExpandableTableViewController instance ,and that's it ! Build and run !

If you want to receive table view selection event ,you just have to implement `UITableViewDelegate` ,and add `expandableTableVC.tableViewDelegate = self;` when you initialize the CYExpandableTableViewController instance ,then you will receive `didSelectRowAtIndexPath:` when user taps a certain row.


#### One Step Forward

When labels and texts cannot meet your needs ,it's time to do some customization.

Everything you need is in `"CustomExpandableViewProtocol.h"` ,implement `CustomHeaderViewDataSource` ,and the table view hands over the responsibility of constructing appearacnce of the header view to you ; Implement `CustomCellDataSource` , and you get to create your own table view cell. Of course ,you can implement both of them if you need to.

To learn more about setting the table view's header or cell to your custom view ,I strongly recommend you to download the sample project and see the whole picture ,but basically ,you are going to do serval things.

##### To Customize Header View
1.For your controlling object ,implement `CustomHeaderViewDataSource` protocol.

2.For your view that's showing as the header view ,implement `CustomHeaderView` protocol.

3.Set the expandable table view object's headerViewDataSource to your controlling object.

4.Since you use a custom header view ,in your data model ,you no longer need to implement `-(NSString *)description;` in `ExpandableObjectProtocol.h`


##### To Customize TableView Cell
1.For your controlling object ,implement 		`CustomCellDataSource` protocol.

2.Set the expandable table view object's cellDataSource to your controlling object.

3.Since you use a custom cell ,in your data model ,you no longer need to implement `-(NSString *)descriptionForSecondaryObjects;` in `ExpandableObjectProtocol.h`



#### Take Full Control

If you need something more than customizing views (say you want to add gestures or take full control of the table view) ,feel free to alter the code ! And if any bugs occurs when you're using CYExpandableTableView ,please report an issue ! :)
