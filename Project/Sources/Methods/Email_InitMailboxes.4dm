//%attributes = {}

// ----------------------------------------------------
// User name (OS): Edu
// Date and time: 10/08/21, 18:28:51
// ----------------------------------------------------
// Method: Email_InitMailboxes
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_OBJECT:C1216($1; $IMAP_Transporter; $oMailBox)
C_COLLECTION:C1488($cBoxList)
C_LONGINT:C283($collctr)
$IMAP_Transporter:=$1

$cBoxList:=$IMAP_Transporter.getBoxList()
$collctr:=$cBoxList.count()

ARRAY TEXT:C222(arMailbox; 0)
ARRAY TEXT:C222(arMailboxName; 0)
ARRAY LONGINT:C221(arMailboxPosition; 0)
For ($i; 1; $collctr)
	$oMailBox:=$cBoxList[$i-1]
	
	Case of 
		: ($oMailBox.name="Inbox")
			APPEND TO ARRAY:C911(arMailbox; <>Email_UserName)
			APPEND TO ARRAY:C911(arMailboxName; $oMailBox.name)
			APPEND TO ARRAY:C911(arMailboxPosition; 1)
			
		: ($oMailBox.name="Sent@")
			APPEND TO ARRAY:C911(arMailbox; <>Email_UserName)
			APPEND TO ARRAY:C911(arMailboxName; $oMailBox.name)
			APPEND TO ARRAY:C911(arMailboxPosition; 2)
			
		: ($oMailBox.name="Drafts")
			APPEND TO ARRAY:C911(arMailbox; <>Email_UserName)
			APPEND TO ARRAY:C911(arMailboxName; $oMailBox.name)
			APPEND TO ARRAY:C911(arMailboxPosition; 3)
			
		: ($oMailBox.name="Deleted@")
			APPEND TO ARRAY:C911(arMailbox; <>Email_UserName)
			APPEND TO ARRAY:C911(arMailboxName; $oMailBox.name)
			APPEND TO ARRAY:C911(arMailboxPosition; 4)
			
		: ($oMailBox.name="Junk@")
			APPEND TO ARRAY:C911(arMailbox; <>Email_UserName)
			APPEND TO ARRAY:C911(arMailboxName; $oMailBox.name)
			APPEND TO ARRAY:C911(arMailboxPosition; 5)
			
		: ($oMailBox.name="Spam@")
			APPEND TO ARRAY:C911(arMailbox; <>Email_UserName)
			APPEND TO ARRAY:C911(arMailboxName; $oMailBox.name)
			APPEND TO ARRAY:C911(arMailboxPosition; 6)
			
		: ($oMailBox.name="Outbox")
			APPEND TO ARRAY:C911(arMailbox; <>Email_UserName)
			APPEND TO ARRAY:C911(arMailboxName; $oMailBox.name)
			APPEND TO ARRAY:C911(arMailboxPosition; 7)
			
		: ($oMailBox.name="Archive")
			APPEND TO ARRAY:C911(arMailbox; <>Email_UserName)
			APPEND TO ARRAY:C911(arMailboxName; $oMailBox.name)
			APPEND TO ARRAY:C911(arMailboxPosition; 8)
	End case 
	
End for 
SORT ARRAY:C229(arMailboxPosition; arMailbox; arMailboxName; >)