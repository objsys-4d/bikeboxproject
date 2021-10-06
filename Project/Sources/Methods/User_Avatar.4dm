//%attributes = {"shared":true}
C_TEXT:C284($0)

C_BLOB:C604($bloPicture)
C_PICTURE:C286($picField)
C_TEXT:C284($txtBase64)

  // INTIALISE OUTPUT

$txtBase64:=""

  // CREATE THUMBNAIL FOR SPEED, SMALLER = FASTER

CREATE THUMBNAIL:C679([Users:1]Avatar:9;$picField;128;128;Scaled to fit:K6:2)

PICTURE TO BLOB:C692($picField;$bloPicture;"image/jpeg")

BASE64 ENCODE:C895($bloPicture;$txtBase64)

  // APPLY CORRECT MEDIA TYPE (IN THIS CASE A "JPEG" IMAGE)

$txtBase64:="data:image/jpeg;base64,"+$txtBase64

$0:=$txtBase64
