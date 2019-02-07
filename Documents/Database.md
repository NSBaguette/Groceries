Tables:

units
=======================================================
uid       | int       | primary, unique | unique id
name      | int       |                 | name
position  | int       |                 | position in the list

aisles
================================================================================
uid       | int       | primary, unique | unique id
name      | string    |                 | name of the aisle
color     | string    |                 | color name (probably hex, will figure out)
icon      | string    |                 | icon name
position  | int       |                 | position in the list

product
=======================================================
uid       | int       | primary, unique |
name      | string    |                 |
note      | string    |                 | 
last_used | timestamp |                 |
aisle_id  | int       | foreign key     |
unit_id   | int       | foreign key     |


