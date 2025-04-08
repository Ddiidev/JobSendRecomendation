module implementations

import net.smtp
import shareds.conf_env

pub struct EmailSMTPRepositoryBrevo {
pub:
	env conf_env.EnvConfig
}

pub fn (e EmailSMTPRepositoryBrevo) send(to string, subject string, body string) ! {
	client_cfg := smtp.Client{
		server:   'smtp-relay.brevo.com'
		from:     e.env.handle_email_from
		port:     e.env.handle_email_port.int()
		username: e.env.handle_email_username
		password: e.env.handle_email_password
	}
	send_cfg := smtp.Mail{
		to:        to
		from:      e.env.handle_email_from
		subject:   subject
		body_type: .html
		body:      body
	}

	// TODO: Adicionar log
	mut client := smtp.new_client(client_cfg)!
	client.send(send_cfg)!
}
