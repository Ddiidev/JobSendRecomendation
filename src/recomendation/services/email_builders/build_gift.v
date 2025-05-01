module email_builders

import mf_core.features.gift_cards.entities as gift_cards_entities

// Função para gerar o HTML do gift card
pub fn generate_gift_html(gift gift_cards_entities.GiftCard) string {
	return $tmpl('./views/gift.html')
}
