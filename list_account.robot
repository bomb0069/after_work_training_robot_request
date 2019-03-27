*** Setting ***
Library   RequestsLibrary
Test Setup    create bomb bank session

*** Testcases ***
ID 00001 จะต้องได้ Account 1 Account หมายเลข 10832555
    ${response}=    Get Request    Bomb's Bank     /list_account?customer_id=0001
    Should Be Equal As Strings	   ${response.status_code}	   200
    ${data}=    To JSON    ${response.content}
    Should Be Equal As Strings	   ${data['account_no']}	   10832555
    Should Be Equal As Strings	   ${data['balance']}	   225

ID 0002 จะต้อง Return Error 0001 Account Not Found
    ${response}=    Get Request    Bomb's Bank     /list_account?customer_id=0002
    Should Be Equal As Strings	   ${response.status_code}	   401
    ${data}=    To JSON    ${response.content}
    Should Be Equal As Strings	   ${data['error_code']}	   0001
    Should Be Equal As Strings	   ${data['error_message']}	   Acccount doesn't exist

*** Keywords ***
create bomb bank session
    Create Session    Bomb's Bank    http://uat.bomb.com

