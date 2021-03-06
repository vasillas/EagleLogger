import CheckinsModel from './CheckinsModel'
import AuthModel from '../Auth/AuthModel'
import NetsModel from '../Nets/NetsModel'
import UsersModel from '../Users/UsersModel'

let auth = async (req) => {
  let token = await AuthModel.retrieve(req.token.userId, req.token.code)
  if (!token) return false
  let user = await UsersModel.retrieve(token.userId)
  let net = await NetsModel.retrieve(req.netId)
  return (net.ncsId === user.callsignId)
}

exports.create = async (req) => {
  if (!(await auth(req))) return false

  return CheckinsModel.create(req.netId, req.callsignId)
}

exports.delete = async (req) => {
  if (!(await auth(req))) return false
  let fields = { deleted: true }

  CheckinsModel.update(req.id, fields)
}

exports.list = async (req) => {
  let fields = {
    deleted: !!req.deleted,
    net_id: req.netId
  }

  return CheckinsModel.filter(fields)
}

exports.retrieve = async (req) => {
  return CheckinsModel.retrieve(req.checkinId)
}
