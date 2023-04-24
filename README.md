# Starting

To run the app if it stops and didn't restart for any reason,  run:
```
docker-compose up -d
```

---

# Updating

After making any changes to files, to update the app you have to run the following to stop the container:
```
docker-compose down
```

then the following to build a new image with the changes:
```
docker-compose build
```

then finally just run the compose stack again:
```
docker-compose up -d
```

---

# Rails Console

Run
```
RAILS_ENV=production rails c
```
to get into the Rails console where you can run code against the production database
Without the RAILS_ENV variable set it will run using the SQLite dev database; `db/development.sqlite3`

```
Building.create(number: 70)
```
The above command creates a new Building with a number of 70 for example

# General Rails Structure

## HTML/Page Display Issues
All of the HTML ERB files should be under the `app/views` directory, so for any bugs relating to how things looks this should be where it's located.

## Javascript Issues
Javascript files will be in the `app/javascript` directory. Rails uses a Javascript library called `Hotwire`, which has sub-libraries called `Turbo` and `Stimulus` that are part of it

https://hotwired.dev/

## Other Issues
If it's some other sort of logical issue it'll probably be in either `app/controllers` or `app/models`.

Controllers are what processes and responds to requests, and models are Ruby objects that can have methods defined to modify how types are written to the database

https://guides.rubyonrails.org/action_controller_overview.html

https://guides.rubyonrails.org/active_model_basics.html
