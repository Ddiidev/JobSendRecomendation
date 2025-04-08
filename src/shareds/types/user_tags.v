module types

pub type UserTags = string

pub fn (ut UserTags) to_list() []string {
	return ut.split(',').map(it.trim_space())
}

pub fn (ut UserTags) add(tags ...string) UserTags {
	return ut + ',' + tags.join(',')
}
