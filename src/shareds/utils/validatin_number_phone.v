module utils

pub fn validate_phone_number(phone string) bool {
	// Remove any non-digit characters
	clean_number := phone.replace(' ', '').replace('-', '').replace('(', '').replace(')',
		'')

	// Check if number has valid length for Brazilian phone numbers (10 or 11 digits)
	if clean_number.len != 10 && clean_number.len != 11 {
		return false
	}

	// Check if all characters are digits
	for c in clean_number {
		if !c.is_digit() {
			return false
		}
	}

	// For 11-digit numbers, check if it starts with valid mobile prefix (9)
	if clean_number.len == 11 && clean_number[2] != `9` {
		return false
	}

	// Check if area code is valid (10-99)
	area_code := clean_number[..2].int()
	if area_code < 10 || area_code > 99 {
		return false
	}

	return true
}
