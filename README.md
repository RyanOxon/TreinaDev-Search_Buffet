# Cade Buffet? App and API

## Requirements

- Ruby version: 3.2.0
- Database initialization: Run `rails db:seed` to populate the database with the necessary categories, payment methods, and event features.

## API Endpoints

### Buffets

- `GET /api/v1/buffets`: Returns a list of all registered buffets with their ID, name, city, state_code, and current accepted payment methods. You can pass a `search` parameter to search buffets by name, like so: `/api/v1/buffets/?search=<search_term>`.

### Buffet Details

- `GET /api/v1/buffets/:buffet_id`: Returns all available information about a specific buffet, including its accepted payment methods.

### Buffet Events

- `GET /api/v1/buffets/:buffet_id/events`: Returns a detailed list of all events that a specific buffet is offering.

### Buffet Availability

- `GET /api/v1/buffets/:buffet_id/events/:event_id/availability?date=<DATE>&num_people=<INT>`: Checks if a specific buffet is available on a given date to hold an event and can support a certain number of people. Both `date` and `num_people` parameters are required.