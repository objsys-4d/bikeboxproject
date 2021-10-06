//%attributes = {"shared":true}
C_DATE:C307($dDate)

C_OBJECT:C1216($oDonations)  // ORDERS YTD
C_OBJECT:C1216($oItems)  // ORDER ITEMS YTD

C_REAL:C285($rYTD)

// CURRENCY SYMBOL

oConnection.data.userCurrency:=Substring:C12(oConnection.session.userCurrency; 1; 1)

// MONTH NAMES (ABBREVIATED)...

oConnection.data.jan:=Substring:C12(Ltg_Str_Localise("%january"); 1; 3)
oConnection.data.feb:=Substring:C12(Ltg_Str_Localise("%february"); 1; 3)
oConnection.data.mar:=Substring:C12(Ltg_Str_Localise("%march"); 1; 3)
oConnection.data.apr:=Substring:C12(Ltg_Str_Localise("%april"); 1; 3)
oConnection.data.may:=Substring:C12(Ltg_Str_Localise("%may"); 1; 3)
oConnection.data.jun:=Substring:C12(Ltg_Str_Localise("%june"); 1; 3)
oConnection.data.jul:=Substring:C12(Ltg_Str_Localise("%july"); 1; 3)
oConnection.data.aug:=Substring:C12(Ltg_Str_Localise("%august"); 1; 3)
oConnection.data.sep:=Substring:C12(Ltg_Str_Localise("%september"); 1; 3)
oConnection.data.oct:=Substring:C12(Ltg_Str_Localise("%october"); 1; 3)
oConnection.data.nov:=Substring:C12(Ltg_Str_Localise("%november"); 1; 3)
oConnection.data.dec:=Substring:C12(Ltg_Str_Localise("%december"); 1; 3)


//count summary (top of page)
oConnection.data.personCount:=String:C10(ds:C1482.Person.all().length; "###,###,###")
oConnection.data.donationCount:=String:C10(ds:C1482.Donation.all().length; "###,###,###")
oConnection.data.eventCount:=String:C10(ds:C1482.Event.all().length; "###,###,###")
oConnection.data.orderCount:=String:C10(ds:C1482.Order.all().length; "###,###,###")


// YEAR TO DATE...

$dDate:=!2021-01-01!

$oDonations:=ds:C1482.Orders.query("Order_Date >= :1"; $dDate)

$oItems:=ds:C1482.Order_Items.query("Order_Date >= :1"; $dDate)

// TOP THREE PRODUCTS (PIE CHART)...
C_OBJECT:C1216($oMerch; $oMerchandise)
ARRAY TEXT:C222($atxtProducts; 0)
ARRAY REAL:C219($arAmount; 0)
$oMerchandise:=ds:C1482.Merchandise.all()

C_OBJECT:C1216($oOrderItem; $oOrderSelection; $esOrderItems; $oMerchValid; $oOrderValid)
$oOrderSelection:=ds:C1482.Order.query("status # :1 or status # :2"; "Cancelled"; "Disputed")
$esOrderItems:=$oOrderSelection.Order_OrderItem

For each ($oMerch; $oMerchandise)
	
	//$oOrderValid:=$oMerch.Merchandise_OrderItem.OrderItem_Order.query("status # :1 or status # :2"; "Cancelled"; "Disputed")
	//$oMerchValid:=$oOrderValid.Order_OrderItem.query("merchID = :1"; $oMerch.merchID)
	
	//$oMerchValid2:=$oMerch.Merchandise_OrderItem.OrderItem_Order.query("status # :1 or status # :2"; "Cancelled"; "Disputed").Order_OrderItem.query("merchID = :1"; $oMerch.merchID)
	
	
	$esMerchandise:=$esOrderItems.query("merchID = :1"; $oMerch.merchID)
	
	APPEND TO ARRAY:C911($atxtProducts; $oMerch.merchName)
	APPEND TO ARRAY:C911($arAmount; Int:C8($esMerchandise.sum("amount")))
	
End for each 



//For each ($oOrder; $oOrderSelection)
//$oOrderIte

//End for each 
//$arAmount{1}:=Int($oItems.query("Product = :1"; "SHT@").sum("Amount"))
//$arAmount{2}:=Int($oItems.query("Product = :1"; "GLV@").sum("Amount"))
//$arAmount{3}:=Int($oItems.query("Product = :1"; "HAT@").sum("Amount"))
//$arAmount{4}:=Int($oItems.query("Product = :1"; "SOK@").sum("Amount"))
//$arAmount{5}:=Int($oItems.query("Product = :1"; "SUN@").sum("Amount"))
//$arAmount{6}:=Int($oItems.query("Product = :1"; "SHO@").sum("Amount"))

SORT ARRAY:C229($arAmount; $atxtProducts; <)

oConnection.data.product1:=$atxtProducts{1}
oConnection.data.amount1:=String:C10($arAmount{1})

oConnection.data.product2:=$atxtProducts{2}
oConnection.data.amount2:=String:C10($arAmount{2})

oConnection.data.product3:=$atxtProducts{3}
oConnection.data.amount3:=String:C10($arAmount{3})

// TOTAL (LINE CHART)...

$oDonations:=ds:C1482.Donation.query("dateDonation >= :1"; $dDate)

$rYTD:=$oDonations.sum("amount")
C_DATE:C307($firstDayofYear; $lastDayofYear)
$firstDayofYear:=Date:C102("01/01/"+String:C10(Year of:C25(Current date:C33(*))))
$lastDayofYear:=Date:C102("01/01/"+String:C10(Year of:C25(Current date:C33(*))+1))-1
ARRAY DATE:C224($arFirstDates; 12)
$ctr:=1
For ($i; 1; 12)
	If ($i=1)
		$arFirstDates{$i}:=$firstDayofYear
	Else 
		$date:=Add to date:C393($firstDayofYear; 0; $ctr; 0)
		$arFirstDates{$i}:=GEN_Date_Get_Month_FirstDate($date)
		$ctr:=$ctr+1
	End if 
End for 

oConnection.data.month1:=String:C10($oDonations.query("dateDonation >= :1 and dateDonation <:2"; $arFirstDates{1}; GEN_Date_Get_Month_LastDate($arFirstDates{1})).sum("amount"))  //jan
oConnection.data.month2:=String:C10($oDonations.query("dateDonation >= :1 and dateDonation <:2"; $arFirstDates{2}; GEN_Date_Get_Month_LastDate($arFirstDates{2})).sum("amount"))  //feb
oConnection.data.month3:=String:C10($oDonations.query("dateDonation >= :1 and dateDonation <:2"; $arFirstDates{3}; GEN_Date_Get_Month_LastDate($arFirstDates{3})).sum("amount"))  //mar
oConnection.data.month4:=String:C10($oDonations.query("dateDonation >= :1 and dateDonation <:2"; $arFirstDates{4}; GEN_Date_Get_Month_LastDate($arFirstDates{4})).sum("amount"))  //apr
oConnection.data.month5:=String:C10($oDonations.query("dateDonation >= :1 and dateDonation <:2"; $arFirstDates{5}; GEN_Date_Get_Month_LastDate($arFirstDates{5})).sum("amount"))  //may
oConnection.data.month6:=String:C10($oDonations.query("dateDonation >= :1 and dateDonation <:2"; $arFirstDates{6}; GEN_Date_Get_Month_LastDate($arFirstDates{6})).sum("amount"))  //jun
oConnection.data.month7:=String:C10($oDonations.query("dateDonation >= :1 and dateDonation <:2"; $arFirstDates{7}; GEN_Date_Get_Month_LastDate($arFirstDates{7})).sum("amount"))  //jul
oConnection.data.month8:=String:C10($oDonations.query("dateDonation >= :1 and dateDonation <:2"; $arFirstDates{8}; GEN_Date_Get_Month_LastDate($arFirstDates{8})).sum("amount"))  //aug
oConnection.data.month9:=String:C10($oDonations.query("dateDonation >= :1 and dateDonation <:2"; $arFirstDates{9}; GEN_Date_Get_Month_LastDate($arFirstDates{9})).sum("amount"))  //sep
oConnection.data.month10:=String:C10($oDonations.query("dateDonation >= :1 and dateDonation <:2"; $arFirstDates{10}; GEN_Date_Get_Month_LastDate($arFirstDates{10})).sum("amount"))  //oct
oConnection.data.month11:=String:C10($oDonations.query("dateDonation >= :1 and dateDonation <:2"; $arFirstDates{11}; GEN_Date_Get_Month_LastDate($arFirstDates{11})).sum("amount"))  //nov
oConnection.data.month12:=String:C10($oDonations.query("dateDonation >= :1 and dateDonation <:2"; $arFirstDates{12}; GEN_Date_Get_Month_LastDate($arFirstDates{12})).sum("amount"))  //dec

// TOTALS BY SALESPERSON (SLIDERS)...

ARRAY TEXT:C222($atxtSalesperson; 0)
ARRAY REAL:C219($arAmount; 0)
C_OBJECT:C1216($PersonDonation; $PersonDonationSelection; $Person; $oPersonSelection)
$oPersonSelection:=ds:C1482.Person.all()
$PersonDonationSelection:=$PersonDonationSelection.Person_Donation  //.sum("amount").orderBy("amount desc")

For each ($Person; $oPersonSelection)
	
	$PersonDonation:=$Person.Person_Donation
	$personamt:=$PersonDonation.sum("amount")
	//$PersonDonation
	APPEND TO ARRAY:C911($atxtSalesperson; $Person.firstName)
	APPEND TO ARRAY:C911($arAmount; $personamt)
	
End for each 


SORT ARRAY:C229($arAmount; $atxtSalesperson; <)

oConnection.data.person1:=$atxtSalesperson{1}  //ds.Users.get($atxtSalesperson{1}).First_Name
oConnection.data.percent1:=String:C10(Int:C8(($arAmount{1}/$rYTD)*100); "###")

oConnection.data.person2:=$atxtSalesperson{2}  //ds.Users.get($atxtSalesperson{2}).First_Name
oConnection.data.percent2:=String:C10(Int:C8(($arAmount{2}/$rYTD)*100); "###")

oConnection.data.person3:=$atxtSalesperson{3}  //ds.Users.get($atxtSalesperson{3}).First_Name
oConnection.data.percent3:=String:C10(Int:C8(($arAmount{3}/$rYTD)*100); "###")

oConnection.data.person4:=$atxtSalesperson{4}  //ds.Users.get($atxtSalesperson{4}).First_Name
oConnection.data.percent4:=String:C10(Int:C8(($arAmount{4}/$rYTD)*100); "###")

oConnection.data.person5:=$atxtSalesperson{5}  //ds.Users.get($atxtSalesperson{5}).First_Name
oConnection.data.percent5:=String:C10(Int:C8(($arAmount{5}/$rYTD)*100); "###")