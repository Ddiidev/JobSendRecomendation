module maisfoco_server

import json
import net.http
import mf_core.context_service as ctx_service
import mf_core.context_service.models as ctx_models

struct AppServer {
pub:
	ctx ctx_service.ContextService
}

fn (h AppServer) handle(req http.Request) http.Response {
	mut res := http.Response{
		header: http.new_header_from_map({
			.content_type: 'application/json'
		})
	}
	mut path := ''
	mut status_code := 200

	defer {
		data := &req.data
		h.ctx.log_api(
			path:        &path
			status_code: &status_code
			additional:  ctx_models.DataContext{
				request: json.decode(map[string]string, *data) or {
					map[string]string{}
				}
			}
		)
	}

	res.body = match req.url {
		'/layer-maisfoco/confirm-cancel-whatsapp' {
			path = '/layer-maisfoco/confirm-cancel-whatsapp'

			if req.method == .post {
				send_message_confirm_cancel(h.ctx, req.data)
				'{"status": "ok"}'
			} else {
				status_code = 405
				'Method not allowed\n'
			}
		}
		else {
			path = req.url
			status_code = 404
			'Not found\n'
		}
	}
	res.status_code = status_code
	return res
}

pub fn start_server() ! {
	app := AppServer{}

	app.ctx.log_info({
		'path': '${@FN} (${@MOD})${@FILE_LINE}'
		'additional':{
			'msg': 'Server API Iniciado'
		}
	})

	mut server := http.Server{
		handler: app
		addr:    ':9009'
	}
	server.listen_and_serve()
}
