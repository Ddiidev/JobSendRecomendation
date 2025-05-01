module gift_draw

import time
import recomendation.services.email_builders
import mf_core.context_service as ctx_service
import recomendation.services.whtasapp_builders
import mf_core.handle_email.service as email_service
import mf_core.features.contacts.repository as contacts_repository
import mf_core.features.raffle_gift.repository as raffle_gift_repository

const segunda = 1

// draw_lots verifica se é a primeira segunda-feira do mês e sorteia um cartão de presente para um contato.
pub fn draw_lots(current_time time.Time) {
	week_day := current_time.day_of_week()

	if week_day != segunda {
		return
	}

	if current_time.day > 7 {
		return
	}

	contact := contacts_repository.get_rand()

	if contact != none {
		gift := raffle_gift_repository.bind_gift_to_contact(contact)

		if gift != none {
			raffle_gift_repository.disable_gift_card(gift) or {
				// TODO: logar erro
			}

			if contact.email != none {
				body_email := email_builders.generate_gift_html(gift)

				hemail := email_service.get()
				hemail.send(contact.email, '🎁 Você foi sorteado!', body_email) or {
					// TODO: logar erro
				}
			} else if contact.whatsapp != none {
				ctx := ctx_service.ContextService{}
				whtasapp_builders.build_gift(ctx, contact.whatsapp, gift)
			}
		}
	}
}
