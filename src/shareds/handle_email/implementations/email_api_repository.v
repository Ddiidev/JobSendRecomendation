module implementations

import json
import net.http
import shareds.conf_env

pub struct EmailApiRepositoryBrevo {
pub:
	env conf_env.EnvConfig
}

const url = 'https://api.brevo.com/v3/smtp/email'

pub fn (e EmailApiRepositoryBrevo) send(to string, subject string, body string) ! {
	data := json.encode(EmailJsonContract{
		subject:      subject
		html_content: body
		to:           [
			To{
				email: to
			},
		]
		sender:       Sender{
			email: e.env.handle_email_from
		}
		reply_to:     ReplyTo{
			email: e.env.handle_email_from
		}
	})
	res := http.fetch(http.FetchConfig{
		url:    url
		method: .post
		header: http.new_custom_header_from_map({
			'api-key': e.env.handle_email_token
		})!
		data:   data
	}) or { return err }

	// TODO: adicionar logs
	dump(res.body)
}
