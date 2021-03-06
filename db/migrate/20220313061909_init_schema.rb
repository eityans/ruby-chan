class InitSchema < ActiveRecord::Migration[6.1]
  def up # rubocop:disable Metrics/MethodLength
    # These are extensions that must be enabled in order to support this database
    enable_extension "plpgsql"
    create_table "contributes" do |t|
      t.integer "user_id", null: false
      t.integer "word_id", null: false
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.index ["user_id"], name: "index_contributes_on_user_id"
    end
    create_table "markov_dics" do |t|
      t.string "prefix_1", null: false
      t.string "prefix_2", null: false
      t.string "suffix", null: false
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.index %w[prefix_1 prefix_2 suffix], name: "index_markov_dics_on_prefix_1_and_prefix_2_and_suffix",
                                            unique: true
      t.index %w[prefix_1 prefix_2], name: "index_markov_dics_on_prefix_1_and_prefix_2"
    end
    create_table "users" do |t|
      t.string "user_id", null: false
      t.string "name", null: false
      t.boolean "premium", default: false, null: false
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.string "picture_url"
      t.index ["user_id"], name: "index_users_on_user_id", unique: true
    end
    create_table "words" do |t|
      t.string "surface", null: false
      t.string "reading", null: false
      t.string "pos", null: false
      t.datetime "created_at", precision: 6, null: false
      t.datetime "updated_at", precision: 6, null: false
      t.integer "contribute_user_id"
      t.integer "appearance", default: 0
      t.index %w[surface reading pos], name: "index_words_on_surface_and_reading_and_pos", unique: true
      t.index ["surface"], name: "index_words_on_surface"
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "The initial migration is not revertable"
  end
end
