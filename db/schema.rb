# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120214220636) do

  create_table "corpora", :force => true do |t|
    t.string "name",        :null => false
    t.text   "description"
  end

  create_table "corpora_projects", :force => true do |t|
    t.integer "corpus_id"
    t.integer "project_id"
  end

  create_table "document_projects", :force => true do |t|
    t.integer "document_id"
    t.integer "project_id"
  end

  create_table "documents", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "file_name",  :null => false
    t.integer  "user_id"
  end

  create_table "elan_parser_alignable_annotations", :force => true do |t|
    t.string "svg_ref"
    t.string "ext_ref"
    t.string "annotation_value"
  end

  create_table "elan_parser_alignable_annotations_time_slots", :force => true do |t|
    t.integer "alignable_annotation_id"
    t.integer "time_slot_ref1",          :null => false
    t.integer "time_slot_ref2",          :null => false
  end

  create_table "elan_parser_annotation_controlled_vocabularies_documents", :force => true do |t|
    t.integer "annotation_document_id"
    t.integer "controlled_vocabularie_id"
  end

  create_table "elan_parser_annotation_documents", :force => true do |t|
    t.string   "author",                            :null => false
    t.datetime "date",                              :null => false
    t.string   "format"
    t.string   "version"
    t.string   "xsi_no_name_space_schema_location", :null => false
    t.string   "file_name",                         :null => false
  end

  create_table "elan_parser_annotation_documents_constraints", :force => true do |t|
    t.integer "annotation_document_id"
    t.integer "constraint_id"
  end

  create_table "elan_parser_annotation_documents_external_refs", :force => true do |t|
    t.integer "annotation_document_id"
    t.integer "external_ref_id"
  end

  create_table "elan_parser_annotation_documents_lexicon_refs", :force => true do |t|
    t.integer "annotation_document_id"
    t.integer "lexicon_ref_id"
  end

  create_table "elan_parser_annotation_documents_linguistic_types", :force => true do |t|
    t.integer "annotation_document_id"
    t.integer "linguistic_type_id"
  end

  create_table "elan_parser_annotation_documents_locales", :force => true do |t|
    t.integer "annotation_document_id"
    t.integer "locale_id"
  end

  create_table "elan_parser_annotation_documents_tiers", :force => true do |t|
    t.integer "annotation_document_id"
    t.integer "tier_id"
  end

  create_table "elan_parser_annotations", :force => true do |t|
    t.integer "alignable_annotation_id"
    t.integer "ref_annotation_id"
  end

  create_table "elan_parser_annotations_tiers", :force => true do |t|
    t.integer "tier_id"
    t.integer "annotation_id"
  end

  create_table "elan_parser_constraints", :force => true do |t|
    t.string "stereotype"
    t.string "description"
  end

  create_table "elan_parser_controlled_cv_entries_vocabularies", :force => true do |t|
    t.integer "controlled_vocabularie_id"
    t.integer "cv_entrie_id"
  end

  create_table "elan_parser_controlled_vocabularies", :force => true do |t|
    t.string "cv_id",       :null => false
    t.string "description", :null => false
    t.string "ext_ref"
  end

  create_table "elan_parser_cv_entries", :force => true do |t|
    t.string "description"
    t.string "ext_ref"
  end

  create_table "elan_parser_external_references", :force => true do |t|
    t.string "ext_ref_id",   :null => false
    t.string "type",         :null => false
    t.string "value",        :null => false
    t.string "iso12620"
    t.string "ecv"
    t.string "cve_id"
    t.string "lexen_id"
    t.string "resource_url"
  end

  create_table "elan_parser_headers", :force => true do |t|
    t.string  "media_file"
    t.string  "time_units",             :null => false
    t.integer "annotation_document_id"
  end

  create_table "elan_parser_headers_linked_file_descriptors", :force => true do |t|
    t.integer "header_id"
    t.integer "linked_file_descriptor_id"
  end

  create_table "elan_parser_headers_media_descriptors", :force => true do |t|
    t.integer "header_id"
    t.integer "media_descriptor_id"
  end

  create_table "elan_parser_headers_properties", :force => true do |t|
    t.integer "header_id"
    t.integer "property_id"
  end

  create_table "elan_parser_lexicon_references", :force => true do |t|
    t.string "lex_ref_id",   :null => false
    t.string "name",         :null => false
    t.string "type",         :null => false
    t.string "url"
    t.string "lexicon_id",   :null => false
    t.string "lexicon_name", :null => false
    t.string "datcat_id",    :null => false
    t.string "datcat_name",  :null => false
  end

  create_table "elan_parser_linguistic_types", :force => true do |t|
    t.string  "linguistic_type_id"
    t.boolean "time_alignable"
    t.string  "constraints"
    t.boolean "graphic_references"
    t.string  "controlled_vocabulary_ref"
    t.string  "ext_ref"
    t.string  "lexicon_ref"
  end

  create_table "elan_parser_linked_file_descriptors", :force => true do |t|
    t.string  "link_url"
    t.string  "relative_link_url"
    t.string  "mime_type"
    t.integer "time_origin"
    t.string  "associated_with"
  end

  create_table "elan_parser_locales", :force => true do |t|
    t.string "language_code"
    t.string "country_code"
    t.string "variant"
  end

  create_table "elan_parser_media_descriptors", :force => true do |t|
    t.string "media_url",          :null => false
    t.string "relative_media_url", :null => false
    t.string "mime_type",          :null => false
    t.string "time_origin",        :null => false
    t.string "extracted_from"
  end

  create_table "elan_parser_properties", :force => true do |t|
    t.string "name",  :null => false
    t.string "value", :null => false
  end

  create_table "elan_parser_reference_annotations", :force => true do |t|
    t.string "ext_ref"
    t.string "annotation_ref"
    t.string "previous_annotation"
    t.string "annotation_value"
  end

  create_table "elan_parser_tiers", :force => true do |t|
    t.string "participant"
    t.string "annotator"
    t.string "linguistic_type_ref", :null => false
    t.string "default_locale",      :null => false
    t.string "parent_ref"
    t.string "tier_id",             :null => false
  end

  create_table "elan_parser_time_orders", :force => true do |t|
    t.integer "annotation_document_id"
  end

  create_table "elan_parser_time_orders_time_slots", :force => true do |t|
    t.integer "time_slot_id"
    t.integer "time_order_id"
  end

  create_table "elan_parser_time_slots", :force => true do |t|
    t.integer "time_value", :null => false
  end

  create_table "projects", :force => true do |t|
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "project_name", :null => false
    t.text     "description",  :null => false
    t.integer  "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
