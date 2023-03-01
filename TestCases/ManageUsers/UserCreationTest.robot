*** Settings ***
Documentation    Generate new token
Library     SeleniumLibrary
Library     RequestsLibrary
Library     Collections
Library     String

Variables   ../../PageObjects/Base.py
Resource    ../../Ressources/TokenControllerResources/TokenControllerKeywords.robot
Resource    ../../Ressources/UserControllerRessources/UserControllerKeywords.robot


*** Variables ***
${NewUserName}
${NewUserPassword}
${Unvalidtoken}     Bearer c88ef7419ca7370bd285adde159fd416d910a2669df4ca8b01bc6b3ccd542165u
*** Test Cases ***
successful user creation
    Log    ${Refreshtoken}
    ${NewUserName}=     Generate Random String  length=7
    ${NewUserPassword}=     Generate Random String  length=7
    Set Global Variable    ${NewUserName}
    Set Global Variable    ${NewUserPassword}
    Create user    ${BaseUrl}  ${ApiUsers}  ${NewUserName}     ${NewUserPassword}    ${Refreshtoken}

Attempting to create a duplicate user
    Create duplicate user    ${BaseUrl}  ${ApiUsers}  ${userName}     ${userPassword}    ${Refreshtoken}


Call without a valid unexpired token
    Create user without valid unexpired token   ${BaseUrl}  ${ApiUsers}  ${userName}     ${userPassword}    ${Unvalidtoken}

call with a valid unexpired non-admin token
    Create token    ${BaseUrl}  ${ApiTOken}  ${NewUserName}     ${NewUserPassword}
    Create user with non admin token    ${BaseUrl}  ${ApiUsers}  ${userName}     ${userPassword}    ${token}
