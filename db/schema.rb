# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_05_16_202639) do
  create_table "admins", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.integer "rol", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_token", null: false
    t.datetime "confirmed_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["remember_token"], name: "index_admins_on_remember_token", unique: true
  end

  create_table "asignaturas", force: :cascade do |t|
    t.string "asignatura", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "seriada_id"
    t.index ["seriada_id"], name: "index_asignaturas_on_seriada_id"
  end

  create_table "auth_users", force: :cascade do |t|
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "confirmed_at"
    t.string "password_digest", null: false
    t.string "unconfirmed_email"
    t.string "remember_token", null: false
    t.string "matricula", null: false
    t.string "nombre", null: false
    t.string "apaterno", null: false
    t.string "amaterno"
    t.integer "rol"
    t.index ["email"], name: "index_auth_users_on_email", unique: true
    t.index ["matricula"], name: "index_auth_users_on_matricula", unique: true
    t.index ["remember_token"], name: "index_auth_users_on_remember_token", unique: true
  end

  create_table "calificacions", force: :cascade do |t|
    t.float "calificacion"
    t.boolean "habilitar", null: false
    t.integer "codigo", null: false
    t.integer "periodo_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tomo_clase_id", null: false
    t.index ["periodo_id"], name: "index_calificacions_on_periodo_id"
    t.index ["tomo_clase_id"], name: "index_calificacions_on_tomo_clase_id"
  end

  create_table "carreras", force: :cascade do |t|
    t.string "carrera"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clases", force: :cascade do |t|
    t.integer "asignatura_id", null: false
    t.integer "periodo_id", null: false
    t.string "grupo", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cupo"
    t.integer "maestro_id"
    t.integer "carrera_id"
    t.index ["asignatura_id"], name: "index_clases_on_asignatura_id"
    t.index ["carrera_id"], name: "index_clases_on_carrera_id"
    t.index ["grupo"], name: "index_clases_on_grupo", unique: true
    t.index ["maestro_id"], name: "index_clases_on_maestro_id"
    t.index ["periodo_id"], name: "index_clases_on_periodo_id"
  end

  create_table "horarios", force: :cascade do |t|
    t.integer "clase_id", null: false
    t.time "hora"
    t.string "dia"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.time "fin"
    t.index ["clase_id"], name: "index_horarios_on_clase_id"
  end

  create_table "maestros", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "nombre", null: false
    t.string "apaterno", null: false
    t.string "grado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "confirmed_at"
    t.string "amaterno"
    t.string "remember_token", null: false
    t.integer "rol"
    t.index ["email"], name: "index_maestros_on_email", unique: true
    t.index ["remember_token"], name: "index_maestros_on_remember_token", unique: true
  end

  create_table "periodos", force: :cascade do |t|
    t.string "periodo", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "habilitar"
  end

  create_table "tomo_clases", force: :cascade do |t|
    t.integer "alumno_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "clase_id", null: false
    t.boolean "aprobada"
    t.integer "asistencias"
    t.integer "faltas"
    t.index ["alumno_id"], name: "index_tomo_clases_on_alumno_id"
    t.index ["clase_id"], name: "index_tomo_clases_on_clase_id"
  end

  add_foreign_key "asignaturas", "asignaturas", column: "seriada_id"
  add_foreign_key "calificacions", "periodos"
  add_foreign_key "calificacions", "tomo_clases"
  add_foreign_key "clases", "asignaturas"
  add_foreign_key "clases", "carreras"
  add_foreign_key "clases", "maestros"
  add_foreign_key "clases", "periodos"
  add_foreign_key "horarios", "clases"
  add_foreign_key "tomo_clases", "auth_users", column: "alumno_id"
  add_foreign_key "tomo_clases", "clases"
end
