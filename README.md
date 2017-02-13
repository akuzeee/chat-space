# Database Design

## Tables
### users table
    - string   "name",                   null: false, with: index

### chat_groups table
    - string   "name",                   null: false

### messages table
    - string   "body"
    - string   "image"
    - integer  "user_id"                 forein_key: true
    - integer  "chat_group_id"           forein_key: true

### group_members table
    - integer  "user_id"                 foreign_key: true, null: false
    - integer  "chat_group_id"           foreign_key: true, null: false

## Associations
### user model
    - has_many :messages
    - has_many :chat_groups, through: :messages

### chat_group model
    - has_many :messages
    - has_many :users,       through: :messages

### message model
    - belongs_to :user
    - belongs_to :chat_groups
