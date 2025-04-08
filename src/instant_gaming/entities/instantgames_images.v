module entities

import instant_gaming.models

@[table: 'InstantGamingProductImages']
pub struct InstantGamingProductImage {
pub mut:
	id         int @[primary; sql: serial]
	parent_id  int
	image_url  string
	type_image models.TypeInstantGamingImage
}

pub fn (igi []InstantGamingProductImage) to_model() []models.InstantGamingProductImage {
	return igi.map(models.InstantGamingProductImage{
		id:         it.id
		parent_id:  it.parent_id
		image_url:  it.image_url
		type_image: it.type_image
	})
}
