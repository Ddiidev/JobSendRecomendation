module maisfoco_server

import json
import wpapi.services as wpapi

pub fn send_message_confirm_cancel(rsequest string) {
	data := json.decode(map[string]string, rsequest) or {
		map[string]string{}
	}

	link := data['link'] or {
		'(FALHA AO GERAR O LINK PARA CANCELAR, por favor reportar via email: contato@maisfoco.life)'
	}

	wpapi.send_text(
		to:   data['contact']
		text: 'Olá! Só por segurança mais uma confirmação para cancelar a newsletter do Mais foco 🌱: ${link}'
	) or {}
}
