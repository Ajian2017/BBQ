# BBQ
this bbq library is created to simplify the iOS layout use language swift

# Basic Usage

## Step1: Prepare view to layout, the following code will create 'subview' to layout
<p>
let parentview = UIView()<br>
let subview = UIView()<br>
parentview.addSubview(subview)<br>
 </p>	

## layout1: the following code will positing the 'subview' to the center of it's superview, and with width 200 and height 100 
subview.bbq()!.centerX().centerY().size(200, 100)

## layout2: the following code will positing the 'subview' 50 to the left of superview, 60 to the top of superview,  meanwhile with width 150 and height 200 
subview.bbq()!.left(50).top(60).size(150, 200)

## layout3: the following code will create another view say 'subview2', and the 'subview2' 200 to the bottom of 'subview', 50 to the left of 'superview', meanwhile it's width is 1.5 times 'subview' minus 50 and height same with 'subview'

<p>
let subview2 = UIView()<br>
parentview.addSubview(subview)<br>       
subview2.bbq()!.top(200, subview, true).left(50).widthEqualTo(subview, 1.5, -50).heightEqualTo(subview)<br>
 </p>	


# summary
 more usage please see the source code, cause the code is really less and easy to understand
  
