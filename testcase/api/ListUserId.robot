*** Settings ***
Library        RequestsLibrary
Library        JSONLibrary
Library        Collections

*** Variables ***
${Base_url}    https://jsonplaceholder.typicode.com

*** Test Cases ***
TCP-USR-001 Verify Get List userId valid for Data Type
    Validasi Data Type List User

*** Keywords ***
Validasi Data Type List User
    [Tags]                          API
    CreateSession                   listUser                            ${Base_url}                             verify=True
    ${response}                     GET On Session                      listUser                                /posts
    log                             ${response.content}
    log                             ${response.status_code}
    log                             ${response.headers}
    Should Be Equal As Strings      ${response.status_code}             200

    ${json_response}                Set Variable                        ${response.json()}
    FOR                             ${post}                             IN                                      @{json_response}
    ${user_id}                      Set Variable                        ${post['userId']}
    ${id}                           Set Variable                        ${post['id']}
    ${title}                        Set Variable                        ${post['title']}
    ${body}                         Set Variable                        ${post['body']}

    ${result}=                      Evaluate                            isinstance($userId, int)
    Log                             result = ${result}, expected int
    Should be True                  ${result}==True

    ${result}=                      Evaluate                            isinstance($id, int)
    Log                             result = ${result}, expected int
    Should be True                  ${result}==True

    ${result}=                      Evaluate                            isinstance($title, (type(u''), str))
    Log                             result = ${result}, expected str
    Should be True                  ${result}==True

    ${result}=                      Evaluate                            isinstance($body, (type(u''), str))
    Log                             result = ${result}, expected str
    Should be True                  ${result}==True
    END

    Delete All Sessions







