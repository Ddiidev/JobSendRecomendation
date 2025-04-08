module conf_env

import os
import dotenv

// EnvConfig represents all environment variables from .env.local
pub struct EnvConfig {
pub:
	name_db                   string
	name_db_test              string
	host_db                   string
	port_db                   string
	user_db                   string
	pass_db                   string
	path_pages                string
	handle_email_from         string
	handle_email_port         string
	handle_email_username     string
	handle_email_password     string
	handle_email_token        string
	base_domain               string
	email_maisfoco_suporte    string
	recaptcha                 string
	recaptcha_secret          string
	whatsapp_api_key_instance string
}

// load_env loads environment variables from system env first, then from .env.local file as fallback
pub fn load_env() EnvConfig {
	env_map := if !os.exists('.env.local') {
		map[string]string{}
	} else {
		dotenv.parse('.env.local')
	}

	// Create and populate the config struct
	return EnvConfig{
		name_db:                   get_env('NAME_DB', env_map)
		name_db_test:              get_env('NAME_DB_TEST', env_map)
		host_db:                   get_env('HOST_DB', env_map)
		port_db:                   get_env('PORT_DB', env_map)
		user_db:                   get_env('USER_DB', env_map)
		pass_db:                   get_env('PASS_DB', env_map)
		path_pages:                get_env('PATH_PAGES', env_map)
		handle_email_from:         get_env('HANDLE_EMAIL_FROM', env_map)
		handle_email_port:         get_env('HANDLE_EMAIL_PORT', env_map)
		handle_email_username:     get_env('HANDLE_EMAIL_USERNAME', env_map)
		handle_email_password:     get_env('HANDLE_EMAIL_PASSWORD', env_map)
		handle_email_token:        get_env('HANDLE_EMAIL_TOKEN', env_map)
		base_domain:               get_env('BASE_DOMAIN', env_map)
		email_maisfoco_suporte:    get_env('EMAIL_MAISFOCO_SUPORTE', env_map)
		recaptcha:                 get_env('RECAPTCHA', env_map)
		recaptcha_secret:          get_env('RECAPTCHA_SECRETKEY', env_map)
		whatsapp_api_key_instance: get_env('WHATSAPP_API_KEY_INSTANCE', env_map)
	}
}

fn get_env(key string, env_map map[string]string) string {
	sys_env := os.getenv(key)
	if sys_env != '' {
		return sys_env
	}
	return env_map[key] or { '' } // panic('Missing required environment variable: ${key}') }
}
