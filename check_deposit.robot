*** Setting *** 
Library   RequestsLibrary

*** Test Cases ***
account 38200015 ฝาก 500 ณ เวลา 25/03/2019 19:45:00 จะได้ QR Code 3820001520190325194500
    Create Session    Bomb's Bank    http://localhost:8080
    &{request}=    Create Dictionary    account_no=38200015    amount=500
    ${response}=   POST Request     Bomb's Bank    /check_deposit     json=${request}
    Should Be Equal As Strings	   ${response.status_code}	   200
    ${data}=    To JSON    ${response.content}
    Should Be Equal As Strings	   ${data['transaction_code']}	   3820001520190325194500

account 38200016 ฝาก 99 จะต้อง Error ว่า ยอดเงินต่ำกว่าที่กำหนด
    Create Session    Bomb's Bank    http://localhost:8080
    &{request}=    Create Dictionary    account_no=38200016    amount=99
    ${response}=   POST Request     Bomb's Bank    /check_deposit     json=${request}
    Should Be Equal As Strings	   ${response.status_code}	   400
    ${data}=    To JSON    ${response.content}
    Should Be Equal As Strings	   ${data['error_code']}    0001
    Should Be Equal As Strings	   ${data['error_message']}    ยอดเงินต่ำกว่าที่กำหนด


