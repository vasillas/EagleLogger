import sgMail from '@sendgrid/mail'
import config from '../../api/config'

exports.create = async(req) => {
  sgMail.setApiKey(config.sendgrid.apikey)
  console.log('req', req)
  const msg = {
    to: req.to,
    from: config.sendgrid.from,
    subject: req.subject,
    text: req.message
  }
  if (req.html) msg.html = req.html

  let res = await sgMail.send(msg)
  console.log('res', res)
}
