*** Settings ***
Documentation   Manage token
Library     SeleniumLibrary
Library     RequestsLibrary
Library     Collections
Library     String

Variables   ../../PageObjects/Base.py


*** Keywords ***
Create user
    Set Global Variable    ${userName}
    Set Global Variable    ${userPassword}

    [Arguments]     ${BaseUrl}  ${ApiUsers}  ${userName}     ${userPassword}    ${Refreshtoken}
    Create Session    mysession    ${BaseUrl}

    ${body}=    Create Dictionary   username=${userName}    password=${userPassword}
    ${headers}=     Create Dictionary   content-type=application/json   Authorization=Bearer ${Refreshtoken}
    ${response}=    POST On Session     mysession   url=/${ApiUsers}    json=${body}    headers=${headers}
    Status Should Be    201     ${response}
    ${bodyResult}=  Convert To String    ${response.content}
    ${jsonBodyResult}=      Evaluate    json.loads('${bodyResult}')     json
    Log    ${jsonBodyResult}
    Should Be Equal    ${jsonBodyResult['username']}    ${userName}

Create duplicate user
    [Arguments]     ${BaseUrl}  ${ApiUsers}  ${userName}     ${userPassword}    ${Refreshtoken}
    Create Session    mysession    ${BaseUrl}

    ${body}=    Create Dictionary   username=${userName}    password=${userPassword}
    ${headers}=     Create Dictionary   content-type=application/json   Authorization=Bearer ${Refreshtoken}
    ${response}=    POST On Session     mysession   expected_status=any    url=/${ApiUsers}    json=${body}    headers=${headers}
    Status Should Be    409     ${response}

Create user without valid unexpired token
    [Arguments]     ${BaseUrl}  ${ApiUsers}  ${userName}     ${userPassword}    ${Unvalidtoken}
    Create Session    mysession    ${BaseUrl}

    ${body}=    Create Dictionary   username=${userName}    password=${userPassword}
    ${headers}=     Create Dictionary   content-type=application/json   Authorization=Bearer ${Unvalidtoken}
    ${response}=    POST On Session     mysession   expected_status=any    url=/${ApiUsers}    json=${body}    headers=${headers}
    Status Should Be    401     ${response}

Create user with non admin token
    [Arguments]     ${BaseUrl}  ${ApiUsers}  ${userName}     ${userPassword}    ${nonAdminTOken}
    Create Session    mysession    ${BaseUrl}

    ${body}=    Create Dictionary   username=${userName}    password=${userPassword}
    ${headers}=     Create Dictionary   content-type=application/json   Authorization=Bearer ${nonAdminTOken}
    ${response}=    POST On Session     mysession   expected_status=any    url=/${ApiUsers}    json=${body}    headers=${headers}
    Status Should Be    403     ${response}