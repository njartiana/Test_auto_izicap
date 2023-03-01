*** Settings ***
Documentation    Generate new token
Library     SeleniumLibrary
Library     RequestsLibrary
Library     Collections
Library     String

Variables   ../../PageObjects/Base.py
Resource    ../../Ressources/TokenControllerResources/TokenControllerKeywords.robot
Resource    ../../Ressources/UserCOntrollerRessources/UserControllerKeywords.robot


*** Variables ***
${userName}     admin
${userPassword}     admin

${invalideUserName}
${invalideUserPassword}
${newTokenCreate}

*** Test Cases ***
Create a new token
    Create token    ${BaseUrl}  ${ApiToken}  ${userName}     ${userPassword}
    ${lastToken}=   Set Variable    ${token}
    Sleep    62s
    Create token    ${BaseUrl}  ${ApiToken}  ${userName}     ${userPassword}
    ${newTokenCreate}=  Set Variable    ${token}
    IF    "${lastToken}" != "${newTokenCreate}"
         Log    "New token generated "${newTokenCreate}" is different to last token "${lastToken}
    END
Refresh an existing and unexpired token
    Refresh token    ${BaseUrl}  ${ApiToken}  ${userName}     ${userPassword}

Generate 401 status with wrong username/password
    ${invalideUserName}=     Generate Random String  length=7
    ${invalideUserPassword}=     Generate Random String  length=7
    Used invalide username/password     ${BaseUrl}  ${ApiTOken}  ${invalideUserName}     ${invalideUserPassword}
