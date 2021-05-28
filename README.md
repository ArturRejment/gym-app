### Gym Management Application
An application for gym managment.

---
## Database
Database for the application was created and implemented with Oracle Database.
Entity Relationship Diagram for the database:
![Database ER diagram (crow's foot).png](https://github.com/ArturRejment/gym-app/blob/main/Database/Database%20ER%20diagram%20(crow's%20foot).png?raw=true)


---
## Frontend
Frontend for the application is implemented both in React and Django.

React application uses Redux to fetch the data from the API endpoints.
Application in Django is a full-stack application which handles both frontend and backend.

Landing page of the website:
![landing.png](https://github.com/ArturRejment/gym-app/blob/main/Pics/landing.png?raw=true)

Login page:
![login.png](https://github.com/ArturRejment/gym-app/blob/main/Pics/login.png?raw=true)

Client page:
![client.png](https://github.com/ArturRejment/gym-app/blob/main/Pics/client.png?raw=true)

---
## Backend
Backend for the application is built with Django and REST Framework. It provides API endpoints for the React app.

# How to run the server
To run the server use command `python manage.py runserver` in the 'backend' directory.

# Valid requests

Default hostname and port: http://127.0.0.1:8000/api

Valid sufixes fot GET Method:

- `/address` returns the list of all addresses
- `/address-details/<int:ident>` returns details about particular address
- `/trainer/<int:ident>` returns shedule for particular trainer specified by trainer_id parameter
- `/available-hours-trainer/<int:ident>` returns availabe hours for particular trainer specified by trainer_id parameter
- `/shop-products/<int:ident>` returns list of products in particular shop specified by shop_id parameter

Valid sufixes fot POST Method:

- `/create-address` creates new address
- `/update-hour/<int:ident>` updates particular working hour

Valid sufixes for DELETE Method:

- `/delete-address/<int:ident>` deletes particular address

Exemplary GET Request sent from Postman returns list of products available in shop with id = 1:
![postman.png](https://github.com/ArturRejment/gym-app/blob/main/Pics/postman.png?raw=true)
