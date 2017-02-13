# database design

## users table
    - string   "email",                  default: "", null: false
    - string   "encrypted_password",     default: "", null: false
    - string   "reset_password_token"
    - datetime "reset_password_sent_at"
    - datetime "remember_created_at"
    - integer  "sign_in_count",          default: 0,  null: false
    - datetime "current_sign_in_at"
    - datetime "last_sign_in_at"
    - string   "current_sign_in_ip"
    - string   "last_sign_in_ip"
    - datetime "created_at",                          null: false
    - datetime "updated_at",                          null: false
    - string   "name",                                null: false
    - index ["email"], name: "index_users_on_email", unique: true, using: :btree
    - index ["name"], name: "index_users_on_name", using: :btree
    - index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

## chat_groups table
    - string   "name",       null: false
    - datetime "created_at", null: false
    - datetime "updated_at", null: false

## messages table
    - string   "body"
    - string   "image"
    - integer  "user_id"
    - integer  "chat_group_id"
    - datetime "created_at",    null: false
    - datetime "updated_at",    null: false
    - index ["chat_group_id"], name: "index_messages_on_chat_group_id", using: :btree
    - index ["user_id"], name: "index_messages_on_user_id", using: :btree
