import Model from '../Model/Model'

exports.create = async (callsignId, passwordHash) => {
  let sql = `
    INSERT INTO users (callsign_id, password_hash)
    VALUES ($1, $2)
    RETURNING id
  `
  let bind = [callsignId, passwordHash]

  return Model.query(sql, bind, true, true)
}

exports.retrieve = async (id) => {
  let sql = `
    SELECT * FROM users WHERE callsign_id = $1
  `
  let bind = [id]

  return Model.query(sql, bind, true)
}

exports.update = async (id, fields) => {
  return Model.update('users', id, fields)
}