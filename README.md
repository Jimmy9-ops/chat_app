# README

to run the projet : docker compose up 
(this is based on my os whitch is CentOS, it might change to *docker-compose up*, based on your os.)

projectUrl : http://localhost:3000/


Endpoints of the project >>


Create Application:

Endpoint: POST /applications
Description: Creates a new application with a token and name.
Request Body:

 {
    "application": {
        "name": "New Application Name"
    }
}

Read Application:

Endpoint: GET /applications/:token
Description: Retrieves the details of a specific application by its token.
Response Body: JSON with the application's details.

Update Application:

Endpoint: Put/Patch  /applications/:token
Description: Updates an application with a token and name.
Request Body:

 {
    "application": {
        "name": "New Application Name"
    }
}


Create Chat:

Endpoint: POST /applications/:token/chats
Description: Creates a new chat for a specific application.
Request Body: no need for a body as the count increases auto.
Response Body: JSON with the created chat's details.

Get Chat:

Endpoint: GET /applications/:token/chats/:id
*id = chat_number* 
Description: Retrieves the details of a specific chat by its ID within a specific application.

Endpoint: GET /applications/:token/chats/
Description: Retrieves all the chats within a specific application.
Response Body: JSON with the chat's details.
Update Chat:

Endpoint: PATCH /applications/:token/chats/:id
Description: Updates the details of a specific chat within a specific application.
Request Body: JSON with the updated chat parameters.
Response Body: JSON with the updated chat's details.

Delete Chat:

Endpoint: DELETE /applications/:token/chats/:id
Description: Deletes a specific chat within a specific application.
Response Body: Empty response with status code 204 No Content.


Create Message:

Endpoint: POST /applications/:token/chats/:chat_number/messages
Description: Creates a new message within a specific chat.
Request Body: 
{
    "message": {
        "body": "New chat message"
    }
}
Response Body: JSON with the created message's details.


Get Message:

Endpoint: GET /applications/:token/chats/:chat_number/messages/:id
*id = message_number* 
Description: Retrieves the details of a specific message by its ID within a specific chat.

Endpoint: GET /applications/:token/chats/:chat_number/messages/
Description: Retrieves all the messages within a specific chat.
Response Body: JSON with the message's details.

Update Message:

Endpoint: PATCH /applications/:token/chats/:chat_number/messages/:id
Description: Updates the details of a specific message within a specific chat.
Request Body: 

{
    "message": {
        "body": "New message body"
    }
}
Response Body: JSON with the updated message's details.

Delete Message:

Endpoint: DELETE /applications/:token/chats/:chat_number/messages/:id
Description: Deletes a specific message within a specific chat.
Response Body: Empty response with status code 204 No Content.

Search Messages:

Endpoint: GET /applications/:token/chats/:chat_number/messages/search?q=searchQuery
*searchQuery=yourSearchQuery*
Description: Searches through messages of a specific chat based on partial match of message bodies.
Query Parameters: q for search query.
Response Body: JSON with the matched messages.



