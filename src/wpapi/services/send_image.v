module services

import json
import net.http
import wpapi.models
import mf_core.conf_env

pub fn send_image(param models.RequestImage) !models.ResponseImage {
	env := conf_env.load_env()

	url := '${const_url}/${env.whatsapp_api_key_instance}/message/image'

	resp := http.fetch(
		method:      .post
		url:         url
		data:        json.encode(param)
		header:      http.new_header(key: .content_type, value: 'application/json')
		max_retries: 1
	)!

	if resp.status_code != 200 {
		return error_with_code(resp.status_msg, resp.status_code)
	}

	return json.decode(models.ResponseImage, resp.body) or { models.ResponseImage{} }
}
