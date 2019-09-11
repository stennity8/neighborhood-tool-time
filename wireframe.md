# Neighborhood Tool Time

### General Info:

This will be a marketplace for a neighborhood that allows neighbors to lend/borrow equipments, lawn equipment, etc.

### Models

User, equipment, Category, Session, Borrows, equipment_category

### User

\*required

| **Attributes:**           | **Associations**                       |
| ------------------------- | -------------------------------------- |
| e-mail\* - string         | has_many :equipments                   |
| password\* - string       | has_many :borrows                      |
| first_name\* - string     | has_many :equipment, through: :borrows |
| last_name\* - string      |                                        |
| street_address\* - string |                                        |
| city\* - string           |                                        |
| state \*- string          |                                        |
| zip_code\* - integer      |                                        |

### equipment

\*required

| **Attributes:**                      | **Associations**                                     |
| ------------------------------------ | ---------------------------------------------------- |
| name\* - string                      | belongs_to :user                                     |
| brand\* - string                     | has_many :borrows                                    |
| description\* - string               | has_many :users, through: :borrows                   |
| pic_url\* - string                   | has_many :equipment_categories                       |
| available - boolean -> default: true | has_many :categories, through: :equipment_categories |

### Borrows

\*required

| **Attributes:**          | **Associations**                                     |
| ------------------------ | ---------------------------------------------------- |
| begin_date\* - datetime  | belongs_to :user                                     |
| end_date\* - datetime    | has_many :borrows                                    |
| return_date - datetime   | has_many :users, through: :borrows                   |
| equipment_id\* - integer | has_many :equipment_categories                       |
| user_id\* - integer      | has_many :categories, through: :equipment_categories |

### Category

\*required

| **Attributes:**  | **Associations**                                    |
| ---------------- | --------------------------------------------------- |
| title\* - string | has_many :equipment_categories                      |
|                  | has_many :equipment, through: :equipment_categories |

### equipment_Category

\*required

| **Attributes:**          | **Associations**      |
| ------------------------ | --------------------- |
| equipment_id\* - integer | belongs_to :category  |
| category_id\* - integer  | belongs_to :equipment |

## MVP

Users will be able to sign up, sign in, and sign out. Users will also be able to sign in using Google. Users will be able to create a base of all their equipment. Users will then be able to borrow equipment from other users. Validations will be included for models and for security to ensure only users with the appropriate access are making changes. Search: equipment name and filter: by category utilites will be implemented.

## Stretch Goals

- Tests
- Admin user and admin access
- Reservations - i.e. reserving equipment for future dates
- Calendar view for equipment and their booked dates
