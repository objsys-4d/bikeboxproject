//%attributes = {}

// ----------------------------------------------------
// User name (OS): Mike Beatty
// Date and time: 08/16/21, 19:43:24
// ----------------------------------------------------
// Method: DataCreate
// Description
// 
//
// Parameters
//
// Change History
// ----------------------------------------------------

For ($i;1;100)
	
	$objLearner:=ds:C1482.Learner.new()
	$objLearner.firstName:="First"+String:C10($i)
	$objLearner.lastName:="Last"+String:C10($i)
	$objLearner.emailAddress:=$objLearner.firstName+$objLearner.lastName+"@gmail.com"
	
	$objLearner.save()
End for 

For ($i;1;100)
	
	$objCourse:=ds:C1482.Course.new()
	$objCourse.courseName:="Course"+String:C10($i)
	
	$objCourse.save()
End for 


For ($i;1;100)
	
	$objVoucher:=ds:C1482.Voucher.new()
	$objVoucher.voucherNumber:="Voucher"+String:C10($i)
	
	$objVoucher.save()
End for 




