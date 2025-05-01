module gift_draw_module

import time
import gift_draw
import mf_core.features.contacts.entities as contacts_entities
import mf_core.infradb

fn init_contacts() ! {
	mut db := infradb.ConnectionDb.new()!

	defer {
		db.close()
	}

	c := [
		contacts_entities.Contact{
			email:                   'teste1@example.com'
			latest_recomendation_at: time.parse('2024-01-01 00:00:00')!
		},
		contacts_entities.Contact{
			email:                   'teste2@example.com'
			latest_recomendation_at: time.parse('2024-01-02 00:00:00')!
		},
		contacts_entities.Contact{
			email:                   'teste3@example.com'
			latest_recomendation_at: time.parse('2024-01-03 00:00:00')!
		},
	]

	for cc in c {
		sql db.conn {
			insert cc into contacts_entities.Contact
		} or {}
	}
}

fn test_draw_lots() {
	init_contacts()!

	mut current_time := time.parse('2025-03-03 00:00:00')!
	chan_sorted := chan contacts_entities.Contact{}
	th := go gift_draw.draw_lots(current_time, chan_sorted)

	res := <-chan_sorted or { println('channel has been closed') }
	dump(res)
}
