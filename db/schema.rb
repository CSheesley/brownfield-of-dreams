ActiveRecord::Schema.define(version: 20_190_513_223_417) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'friendships', force: :cascade do |t|
    t.integer 'user_id'
    t.integer 'friend_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'taggings', id: :serial, force: :cascade do |t|
    t.integer 'tag_id'
    t.string 'taggable_type'
    t.integer 'taggable_id'
    t.string 'tagger_type'
    t.integer 'tagger_id'
    t.string 'context', limit: 128
    t.datetime 'created_at'
    t.index ['context'], name: 'index_taggings_on_context'
    t.index %w[tag_id taggable_id taggable_type context tagger_id tagger_type], name: 'taggings_idx', unique: true
    t.index ['tag_id'], name: 'index_taggings_on_tag_id'
    t.index %w[taggable_id taggable_type context], name: 'index_taggings_on_taggable_id_and_taggable_type_and_context'
    t.index %w[taggable_id taggable_type tagger_id context], name: 'taggings_idy'
    t.index ['taggable_id'], name: 'index_taggings_on_taggable_id'
    t.index ['taggable_type'], name: 'index_taggings_on_taggable_type'
    t.index %w[tagger_id tagger_type], name: 'index_taggings_on_tagger_id_and_tagger_type'
    t.index ['tagger_id'], name: 'index_taggings_on_tagger_id'
  end

  create_table 'tags', id: :serial, force: :cascade do |t|
    t.string 'name'
    t.integer 'taggings_count', default: 0
    t.index ['name'], name: 'index_tags_on_name', unique: true
  end

  create_table 'tutorials', force: :cascade do |t|
    t.string 'title'
    t.text 'description'
    t.string 'thumbnail'
    t.string 'playlist_id'
    t.boolean 'classroom', default: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'user_videos', force: :cascade do |t|
    t.bigint 'user_id'
    t.bigint 'video_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_user_videos_on_user_id'
    t.index ['video_id'], name: 'index_user_videos_on_video_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email'
    t.string 'first_name'
    t.string 'last_name'
    t.string 'password_digest'
    t.integer 'role', default: 0
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'git_key'
    t.integer 'git_id'
    t.index ['email'], name: 'index_users_on_email'
  end

  create_table 'videos', force: :cascade do |t|
    t.string 'title'
    t.text 'description'
    t.string 'video_id'
    t.string 'thumbnail'
    t.bigint 'tutorial_id'
    t.integer 'position', default: 0
    t.index ['tutorial_id'], name: 'index_videos_on_tutorial_id'
  end

  add_foreign_key 'user_videos', 'users'
  add_foreign_key 'user_videos', 'videos'
end
