module maisfoco_server

import net.http

struct AppServer {}

fn (h AppServer) handle(req http.Request) http.Response {
	mut res := http.Response{
		header: http.new_header_from_map({
			.content_type: 'application/json'
		})
	}
	mut status_code := 200
	res.body = match req.url {
		'/layer-maisfoco/confirm-cancel-whatsapp' {
			if req.method == .post {
				send_message_confirm_cancel(req.data)
				'{"status": "ok"}'
			} else {
				status_code = 405
				'Method not allowed\n'
			}
		}
		else {
			status_code = 404
			'Not found\n'
		}
	}
	res.status_code = status_code
	return res
}

pub fn start_server() ! {
	mut server := http.Server{
		handler: AppServer{}
		addr:    ':9009'
	}
	server.listen_and_serve()
}
