module models

pub enum TypeInstantGamingImage {
	full
	thumbnail
}

pub struct InstantGamingProductImage {
pub mut:
	id         int @[primary; sql: serial]
	parent_id  int
	image_url  string
	type_image TypeInstantGamingImage
}
