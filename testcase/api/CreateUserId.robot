*** Settings ***
Library        RequestsLibrary
Library        JSONLibrary
Library        Collections

*** Variables ***
${Base_url}         https://jsonplaceholder.typicode.com

*** Test Cases ***
TCP-USR-002 Verify data after create user
    Verify Response Matches Input Payload

*** Keywords ***
Verify Response Matches Input Payload
    [Tags]                                   API
    Create Session                           listUser                      ${Base_url}      verify=True

    ${payload}                               Create Dictionary
    ...                                      title=Recommandation
    ...                                      body=Motorcycle
    ...                                      userId=12

    ${response}                              POST On Session               listUser     /posts      json=${payload}
    Should Be Equal As Strings               ${response.status_code}       201

    ${response_data}                         Set Variable                  ${response.json()}

    Should Be Equal As Strings               ${response_data['title']}     ${payload['title']}
    Should Contain                           ${response_data['title']}     ${payload['title']}
    Should Be Equal As Strings               ${response_data['body']}      ${payload['body']}
    Should Contain                           ${response_data['body']}      ${payload['body']}
    Should Be Equal As Strings               ${response_data['userId']}    ${payload['userId']}
    Should Contain                           ${response_data['userId']}    ${payload['userId']}

    Delete All Sessions