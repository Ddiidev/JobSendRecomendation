module service

import shareds.conf_env
import shareds.handle_email.interfaces
import shareds.handle_email.implementations

pub fn get() interfaces.IEmail {
	return implementations.EmailSMTPRepositoryBrevo{conf_env.load_env()}
}
