# ChatSpace

- railsの練習で作ったチャットアプリです。
- 構成: haml, scss, jquery, mysql, unicorn + nginx + capistrano

## Database Design

### Tables
#### users table
    - string   "name",                   null: false, with: index

#### chat_groups table
    - string   "name",                   null: false

#### messages table
    - string   "body"
    - string   "image"
    - integer  "user_id"                 foreign_key: true, null: false
    - integer  "chat_group_id"           foreign_key: true, null: false

#### group_members table
    - integer  "user_id"                 foreign_key: true, null: false
    - integer  "chat_group_id"           foreign_key: true, null: false

### Associations
#### user model
    - has_many :messages
    - has_many :group_members
    - has_many :chat_groups,   through: :group_members

#### chat_group model
    - has_many :messages
    - has_many :group_members
    - has_many :users,         through: :group_members

#### message model
    - belongs_to :user
    - belongs_to :chat_group

#### group_member model
    - belongs_to :user
    - belongs_to :chat_group
