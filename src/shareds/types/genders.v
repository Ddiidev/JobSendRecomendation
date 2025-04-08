module types

pub type Genders = string

pub fn (g Genders) to_list() []string {
	return g.split(',').map(it.trim_space())
}

pub fn (g Genders) add(genders ...string) Genders {
	return g + ',' + genders.join(',')
}
