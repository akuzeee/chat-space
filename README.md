# Database Design

## Tables
### users table
    - integer  "id"                      null: false, unique: true
    - string   "name",                   null: false, with: index
    - string   "email",                  null: false, with: index, unique: true
    - string   "encrypted_password",     null: false
    - string   "reset_password_token"
    - datetime "reset_password_sent_at"
    - datetime "remember_created_at"
    - integer  "sign_in_count",          null: false
    - datetime "current_sign_in_at"
    - datetime "last_sign_in_at"
    - string   "current_sign_in_ip"
    - string   "last_sign_in_ip"
    - datetime "created_at",             null: false
    - datetime "updated_at",             null: false

### chat_groups table
    - integer  "id"                      null: false, unique: true
    - string   "name",                   null: false
    - datetime "created_at",             null: false
    - datetime "updated_at",             null: false

### messages table
    - integer  "id"                      null: false, unique: true
    - string   "body"
    - string   "image"
    - integer  "user_id"                 forein_key: true
    - integer  "chat_group_id"           forein_key: true
    - datetime "created_at",             null: false
    - datetime "updated_at",             null: false

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
