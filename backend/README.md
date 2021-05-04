## API for gym database
API for gym database created in Django using rest framework

---
# How to run the server
To run server use command `python manage.py runserver`

---
# Valid GET request

Default hostname and port: http://127.0.0.1:8000/api/

Valid sufixes:

- `Address` returns the list of all addresses
- `Trainer<id>` returns shedule for particular trainer specified by trainer_id parameter
- `AvailableHoursTrainer<id>` returns availabe hours for particular trainer specified by trainer_id parameter
- `ShopProducts<id>` returns list of products in particular shop specified by shop_id parameter
