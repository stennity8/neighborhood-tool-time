#Neighborhood Tool Time
###General Info:
This will be a marketplace for a neighborhood that allows neighbors to lend/borrow tools, lawn equipment, etc.

### Models

User, Tool, Category, Session, Borrows, Tool_category

### User

\*required

| **Attributes:**           | **Associations**                   |
| ------------------------- | ---------------------------------- |
| e-mail\* - string         | has_many :tools                    |
| password\* - string       | has_many :borrows                  |
| first_name\* - string     | has_many :tools, through: :borrows |
| last_name\* - string      |                                    |
| street_address\* - string |                                    |
| city\* - string           |                                    |
| state \*- string          |                                    |
| zip_code\* - integer      |                                    |

### Tool

\*required

| **Attributes:**                      | **Associations**                                |
| ------------------------------------ | ----------------------------------------------- |
| name\* - string                      | belongs_to :user                                |
| brand\* - string                     | has_many :borrows                               |
| description\* - string               | has_many :users, through: :borrows              |
| pic_url\* - string                   | has_many :tool_categories                       |
| available - boolean -> default: true | has_many :categories, through: :tool_categories |

### Borrows

\*required

| **Attributes:**         | **Associations**                                |
| ----------------------- | ----------------------------------------------- |
| begin_date\* - datetime | belongs_to :user                                |
| end_date\* - datetime   | has_many :borrows                               |
| return_date - datetime  | has_many :users, through: :borrows              |
| tool_id\* - integer     | has_many :tool_categories                       |
| user_id\* - integer     | has_many :categories, through: :tool_categories |

### Category

\*required

| **Attributes:**  | **Associations**                           |
| ---------------- | ------------------------------------------ |
| title\* - string | has_many :tool_categories                  |
|                  | has_many :tools, through: :tool_categories |

### Tool_Category

\*required

| **Attributes:**         | **Associations**     |
| ----------------------- | -------------------- |
| tool_id\* - integer     | belongs_to :category |
| category_id\* - integer | belongs_to :tool     |

## MVP

Users will be able to sign up, sign in, and sign out. Users will also be able to sign in using Google. Users will be able to create a base of all their tools. Users will then be able to borrow tools from other users. Validations will be included for models and for security to ensure only users with the appropriate access are making changes. Search: tool name and filter: by category utilites will be implemented.

## Stretch Goals

- Tests
- Admin user and admin access
- Reservations - i.e. reserving tools for future dates
- Calendar view for tools and their booked dates
