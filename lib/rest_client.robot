*** Settings ***
Library           Collections
Library           String
Library           RequestsLibrary.RequestsKeywords
Library           OperatingSystem

*** Variables ***
${HOST}           192.168.122.100    # openbmc ip address
${DBUS_PREFIX}    /bus/session
${PORT}           3000
${AUTH_URI}       http://${HOST}:${PORT}
${USERNAME}       root
${PASSWORD}       abc123
# Response codes
${HTTP_CONTINUE}    100
${HTTP_SWITCHING_PROTOCOLS}    101
${HTTP_PROCESSING}    102
${HTTP_OK}        200
${HTTP_CREATED}    201
${HTTP_ACCEPTED}    202
${HTTP_NON_AUTHORITATIVE_INFORMATION}    203
${HTTP_NO_CONTENT}    204
${HTTP_RESET_CONTENT}    205
${HTTP_PARTIAL_CONTENT}    206
${HTTP_MULTI_STATUS}    207
${HTTP_IM_USED}    226
${HTTP_MULTIPLE_CHOICES}    300
${HTTP_MOVED_PERMANENTLY}    301
${HTTP_FOUND}     302
${HTTP_SEE_OTHER}    303
${HTTP_NOT_MODIFIED}    304
${HTTP_USE_PROXY}    305
${HTTP_TEMPORARY_REDIRECT}    307
${HTTP_BAD_REQUEST}    400
${HTTP_UNAUTHORIZED}    401
${HTTP_PAYMENT_REQUIRED}    402
${HTTP_FORBIDDEN}    403
${HTTP_NOT_FOUND}    404
${HTTP_METHOD_NOT_ALLOWED}    405
${HTTP_NOT_ACCEPTABLE}    406
${HTTP_PROXY_AUTHENTICATION_REQUIRED}    407
${HTTP_REQUEST_TIMEOUT}    408
${HTTP_CONFLICT}    409
${HTTP_GONE}      410
${HTTP_LENGTH_REQUIRED}    411
${HTTP_PRECONDITION_FAILED}    412
${HTTP_REQUEST_ENTITY_TOO_LARGE}    413
${HTTP_REQUEST_URI_TOO_LONG}    414
${HTTP_UNSUPPORTED_MEDIA_TYPE}    415
${HTTP_REQUESTED_RANGE_NOT_SATISFIABLE}    416
${HTTP_EXPECTATION_FAILED}    417
${HTTP_UNPROCESSABLE_ENTITY}    422
${HTTP_LOCKED}    423
${HTTP_FAILED_DEPENDENCY}    424
${HTTP_UPGRADE_REQUIRED}    426
${HTTP_INTERNAL_SERVER_ERROR}    500
${HTTP_NOT_IMPLEMENTED}    501
${HTTP_BAD_GATEWAY}    502
${HTTP_SERVICE_UNAVAILABLE}    503
${HTTP_GATEWAY_TIMEOUT}    504
${HTTP_HTTP_VERSION_NOT_SUPPORTED}    505
${HTTP_INSUFFICIENT_STORAGE}    507
${HTTP_NOT_EXTENDED}    510

*** Keywords ***
OpenBMC Get Request
    [Arguments]    ${uri}    &{kwargs}
    ${base_uri}=    Catenate    SEPARATOR=    ${DBUS_PREFIX}    ${uri}
    Log Request    method=Get    base_uri=${base_uri}    args=&{kwargs}
    Initialize OpenBMC
    ${ret}=    Get Request    openbmc    ${base_uri}    &{kwargs}
    Log Response    ${ret}
    [Return]    ${ret}

OpenBMC Post Request
    [Arguments]    ${uri}    &{kwargs}
    ${base_uri}=    Catenate    SEPARATOR=    ${DBUS_PREFIX}    ${uri}
    Log Request    method=Post    base_uri=${base_uri}    args=&{kwargs}
    Initialize OpenBMC
    ${ret}=    Post Request    openbmc    ${base_uri}    &{kwargs}
    Log Response    ${ret}
    [Return]    ${ret}

OpenBMC Put Request
    [Arguments]    ${uri}    &{kwargs}
    ${base_uri}=    Catenate    SEPARATOR=    ${DBUS_PREFIX}    ${uri}
    Log Request    method=Put    base_uri=${base_uri}    args=&{kwargs}
    Initialize OpenBMC
    ${ret}=    Put Request    openbmc    ${base_uri}    &{kwargs}
    Log Response    ${ret}
    [Return]    ${ret}

Initialize OpenBMC
    Create Session    openbmc    ${AUTH_URI}

Log Request
    [Arguments]    &{kwargs}
    ${msg}=    Catenate    SEPARATOR=    URI:    ${AUTH_URI}    ${kwargs["base_uri"]}    , method:
    ...    ${kwargs["method"]}    , args:    ${kwargs["args"]}
    Logging    ${msg}    console=True

Log Response
    [Arguments]    ${resp}
    ${msg}=    Catenate    SEPARATOR=    Response code:    ${resp.status_code}    , Content:    ${resp.content}
    Logging    ${msg}    console=True

Logging
    [Arguments]    ${msg}    ${console}=default False
    Log    ${msg}    console=True
