//%attributes = {"shared":true}
C_DATE:C307($dDate)

C_OBJECT:C1216($oOrders)  // ORDERS YTD
C_OBJECT:C1216($oItems)  // ORDER ITEMS YTD

C_REAL:C285($rYTD)

  // CURRENCY SYMBOL

oConnection.data.userCurrency:=Substring:C12(oConnection.session.userCurrency;1;1)

  // MONTH NAMES (ABBREVIATED)...

oConnection.data.jan:=Substring:C12(Ltg_Str_Localise ("%january");1;3)
oConnection.data.feb:=Substring:C12(Ltg_Str_Localise ("%february");1;3)
oConnection.data.mar:=Substring:C12(Ltg_Str_Localise ("%march");1;3)
oConnection.data.apr:=Substring:C12(Ltg_Str_Localise ("%april");1;3)
oConnection.data.may:=Substring:C12(Ltg_Str_Localise ("%may");1;3)
oConnection.data.jun:=Substring:C12(Ltg_Str_Localise ("%june");1;3)
oConnection.data.jul:=Substring:C12(Ltg_Str_Localise ("%july");1;3)
oConnection.data.aug:=Substring:C12(Ltg_Str_Localise ("%august");1;3)
oConnection.data.sep:=Substring:C12(Ltg_Str_Localise ("%september");1;3)
oConnection.data.oct:=Substring:C12(Ltg_Str_Localise ("%october");1;3)
oConnection.data.nov:=Substring:C12(Ltg_Str_Localise ("%november");1;3)
oConnection.data.dec:=Substring:C12(Ltg_Str_Localise ("%december");1;3)

  // ORDER STATUSES...

oConnection.data.shipped:=String:C10(ds:C1482.Orders.query("Status = Shipped").length;"###,###,###")
oConnection.data.processing:=String:C10(ds:C1482.Orders.query("Status = Processing").length;"###,###,###")
oConnection.data.disputed:=String:C10(ds:C1482.Orders.query("Status = Disputed").length;"###,###,###")
oConnection.data.cancelled:=String:C10(ds:C1482.Orders.query("Status = Cancelled").length;"###,###,###")

  // YEAR TO DATE...

$dDate:=!2020-01-01!

$oOrders:=ds:C1482.Orders.query("Order_Date >= :1";$dDate)

$oItems:=ds:C1482.Order_Items.query("Order_Date >= :1";$dDate)

  // TOP THREE PRODUCTS (PIE CHART)...

ARRAY TEXT:C222($atxtProducts;6)

$atxtProducts{1}:=Ltg_Str_Localise ("%shirts")
$atxtProducts{2}:=Ltg_Str_Localise ("%gloves")
$atxtProducts{3}:=Ltg_Str_Localise ("%hats")
$atxtProducts{4}:=Ltg_Str_Localise ("%socks")
$atxtProducts{5}:=Ltg_Str_Localise ("%sunglasses")
$atxtProducts{6}:=Ltg_Str_Localise ("%shoes")

ARRAY REAL:C219($arAmount;6)

$arAmount{1}:=Int:C8($oItems.query("Product = :1";"SHT@").sum("Amount"))
$arAmount{2}:=Int:C8($oItems.query("Product = :1";"GLV@").sum("Amount"))
$arAmount{3}:=Int:C8($oItems.query("Product = :1";"HAT@").sum("Amount"))
$arAmount{4}:=Int:C8($oItems.query("Product = :1";"SOK@").sum("Amount"))
$arAmount{5}:=Int:C8($oItems.query("Product = :1";"SUN@").sum("Amount"))
$arAmount{6}:=Int:C8($oItems.query("Product = :1";"SHO@").sum("Amount"))

SORT ARRAY:C229($arAmount;$atxtProducts;<)

oConnection.data.product1:=$atxtProducts{1}
oConnection.data.amount1:=String:C10($arAmount{1})

oConnection.data.product2:=$atxtProducts{2}
oConnection.data.amount2:=String:C10($arAmount{2})

oConnection.data.product3:=$atxtProducts{3}
oConnection.data.amount3:=String:C10($arAmount{3})

  // TOTAL (LINE CHART)...

$rYTD:=$oOrders.sum("Subtotal")

oConnection.data.month1:=String:C10($oOrders.query("Month = :1";1).sum("Subtotal"))
oConnection.data.month2:=String:C10($oOrders.query("Month = :1";2).sum("Subtotal"))
oConnection.data.month3:=String:C10($oOrders.query("Month = :1";3).sum("Subtotal"))
oConnection.data.month4:=String:C10($oOrders.query("Month = :1";4).sum("Subtotal"))
oConnection.data.month5:=String:C10($oOrders.query("Month = :1";5).sum("Subtotal"))
oConnection.data.month6:=String:C10($oOrders.query("Month = :1";6).sum("Subtotal"))
oConnection.data.month7:=String:C10($oOrders.query("Month = :1";7).sum("Subtotal"))
oConnection.data.month8:=String:C10($oOrders.query("Month = :1";8).sum("Subtotal"))
oConnection.data.month9:=String:C10($oOrders.query("Month = :1";9).sum("Subtotal"))
oConnection.data.month10:=String:C10($oOrders.query("Month = :1";10).sum("Subtotal"))
oConnection.data.month11:=String:C10($oOrders.query("Month = :1";11).sum("Subtotal"))
oConnection.data.month12:=String:C10($oOrders.query("Month = :1";12).sum("Subtotal"))

  // TOTALS BY SALESPERSON (SLIDERS)...

ARRAY TEXT:C222($atxtSalesperson;5)

ARRAY REAL:C219($arAmount;5)

$atxtSalesperson{1}:="mbenson"
$atxtSalesperson{2}:="mhammond"
$atxtSalesperson{3}:="jsturgess"
$atxtSalesperson{4}:="stevedavids"
$atxtSalesperson{5}:="tsutherland"

$arAmount{1}:=Int:C8($oOrders.query("Salesperson = :1";"mbenson").sum("Subtotal"))
$arAmount{2}:=Int:C8($oOrders.query("Salesperson = :1";"mhammond").sum("Subtotal"))
$arAmount{3}:=Int:C8($oOrders.query("Salesperson = :1";"jsturgess").sum("Subtotal"))
$arAmount{4}:=Int:C8($oOrders.query("Salesperson = :1";"stevedavids").sum("Subtotal"))
$arAmount{5}:=Int:C8($oOrders.query("Salesperson = :1";"tsutherland").sum("Subtotal"))

SORT ARRAY:C229($arAmount;$atxtSalesperson;<)

oConnection.data.person1:=ds:C1482.Users.get($atxtSalesperson{1}).First_Name
oConnection.data.percent1:=String:C10(Int:C8(($arAmount{1}/$rYTD)*100);"###")

oConnection.data.person2:=ds:C1482.Users.get($atxtSalesperson{2}).First_Name
oConnection.data.percent2:=String:C10(Int:C8(($arAmount{2}/$rYTD)*100);"###")

oConnection.data.person3:=ds:C1482.Users.get($atxtSalesperson{3}).First_Name
oConnection.data.percent3:=String:C10(Int:C8(($arAmount{3}/$rYTD)*100);"###")

oConnection.data.person4:=ds:C1482.Users.get($atxtSalesperson{4}).First_Name
oConnection.data.percent4:=String:C10(Int:C8(($arAmount{4}/$rYTD)*100);"###")

oConnection.data.person5:=ds:C1482.Users.get($atxtSalesperson{5}).First_Name
oConnection.data.percent5:=String:C10(Int:C8(($arAmount{5}/$rYTD)*100);"###")