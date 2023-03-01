*** Settings ***
Documentation   Manage token
Library     SeleniumLibrary
Library     RequestsLibrary
Library     Collections
Library     String

Variables   ../../PageObjects/Base.py

*** Keywords ***
Create token
    [Arguments]     ${BaseUrl}  ${ApiToken}  ${userName}     ${userPassword}
    Create Session    mysession    ${BaseUrl}
    ${body}=    Create Dictionary   username=${userName}    password=${userPassword}
    ${headers}=     Create Dictionary   content-type=application/json
    ${response}=    POST On Session     mysession   url=/${ApiTOken}    json=${body}    headers=${headers}
    Status Should Be    201     ${response}
    ${bodyResult}=  Convert To String    ${response.content}
    ${jsonBodyResult}=      Evaluate    json.loads('${bodyResult}')     json
    Log    ${jsonBodyResult}
    ${token}=   Set Variable    ${jsonBodyResult["token"]}
    ${creationDate}=    Set Variable    ${jsonBodyResult["creationDate"]}
    ${expirationDate}=      Set Variable    ${jsonBodyResult["expirationDate"]}

    Set Global Variable    ${token}
    Set Global Variable    ${creationDate}
    Set Global Variable    ${expirationDate}

    Log    ${token}
    Log    ${creationDate}
    Log    ${expirationDate}

Refresh token
    Sleep    5s
    [Arguments]     ${BaseUrl}  ${ApiToken}  ${userName}     ${userPassword}
    Create Session    mysession    ${BaseUrl}
    ${body}=    Create Dictionary   username=${userName}    password=${userPassword}
    ${headers}=     Create Dictionary   content-type=application/json
    ${response}=    POST On Session     mysession   url=/${ApiTOken}    json=${body}    headers=${headers}
    ${bodyResult}=  Convert To String    ${response.content}
    ${jsonBodyResult}=      Evaluate    json.loads('${bodyResult}')     json
    Log    ${jsonBodyResult}

    ${Refreshtoken}=   Set Variable    ${jsonBodyResult["token"]}
    ${RefreshcreationDate}=    Set Variable    ${jsonBodyResult["creationDate"]}
    ${RefreshexpirationDate}=      Set Variable    ${jsonBodyResult["expirationDate"]}

    Set Global Variable    ${Refreshtoken}
    Set Global Variable    ${RefreshcreationDate}
    Set Global Variable    ${RefreshexpirationDate}

    IF    "${Refreshtoken}" == "${token}" and "${expirationDate}" != "${RefreshexpirationDate}"
         Status Should Be    200    ${response}
    END

Used invalide username/password
    [Arguments]     ${BaseUrl}  ${ApiToken}  ${invalideUserName}     ${invalideUserPassword}
    Create Session    mysession    ${BaseUrl}
    ${body}=    Create Dictionary   username=${invalideUserName}    password=${invalideUserPassword}
    ${headers}=     Create Dictionary   content-type=application/json
    ${response}=    POST On Session      mysession      expected_status=any   url=/${ApiTOken}    json=${body}    headers=${headers}
    Status Should Be    401     ${response}


