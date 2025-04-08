module entities

import time

@[table: 'Contacts']
pub struct Contact {
pub:
	id                      int     @[primary; serial]
	whatsapp                ?string @[unique]
	email                   ?string @[unique]
	updated_at              time.Time = time.now()
	latest_recomendation_at ?time.Time
	uuid_confirm_cancel     ?string
}
