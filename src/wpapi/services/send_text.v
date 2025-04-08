module services

import json
import net.http
import wpapi.models
import shareds.conf_env

pub fn send_text(param models.RequestText) !models.ResponseText {
	env := conf_env.load_env()

	url := '${const_url}/${env.whatsapp_api_key_instance}/message/text'

	// resp := http.post_json(url, json.encode(param))!
	resp := http.fetch(
		method:      .post
		url:         url
		data:        json.encode(param)
		header:      http.new_header(key: .content_type, value: 'application/json')
		max_retries: 1
	)!

	if resp.status_code != 200 {
		return error('${resp.status_code} - ${resp.status_msg}')
	}

	return json.decode(models.ResponseText, resp.body) or { models.ResponseText{} }
}
