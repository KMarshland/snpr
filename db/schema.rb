# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180312231610) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "diseases", force: :cascade do |t|
    t.string "name"
    t.string "short_form"
    t.boolean "checked_gwas", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["short_form"], name: "index_diseases_on_short_form", unique: true
  end

  create_table "diseases_snps", id: false, force: :cascade do |t|
    t.bigint "snp_id", null: false
    t.bigint "disease_id", null: false
  end

  create_table "documents", force: :cascade do |t|
    t.string "external_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "source_id"
    t.string "file_url"
    t.boolean "imported", default: false
    t.datetime "processing_start_time"
    t.boolean "erroneous", default: false
    t.index ["erroneous"], name: "index_documents_on_erroneous"
    t.index ["external_id"], name: "index_documents_on_external_id", unique: true
    t.index ["imported"], name: "index_documents_on_imported"
    t.index ["source_id"], name: "index_documents_on_source_id"
  end

  create_table "genomic_contexts", force: :cascade do |t|
    t.bigint "snp_id"
    t.string "gene"
    t.integer "distance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["snp_id"], name: "index_genomic_contexts_on_snp_id"
  end

  create_table "snps", force: :cascade do |t|
    t.string "rsid"
    t.string "chromosome"
    t.integer "position"
    t.string "allele1"
    t.string "allele2"
    t.boolean "checked_gwas", default: false
    t.string "functional_class"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rsid"], name: "index_snps_on_rsid", unique: true
  end

  create_table "snps_sources", id: false, force: :cascade do |t|
    t.bigint "snp_id", null: false
    t.bigint "source_id", null: false
    t.index ["snp_id"], name: "index_snps_sources_on_snp_id"
    t.index ["source_id"], name: "index_snps_sources_on_source_id"
  end

  create_table "sources", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_sources_on_name", unique: true
  end

  add_foreign_key "documents", "sources"
  add_foreign_key "genomic_contexts", "snps"
end
