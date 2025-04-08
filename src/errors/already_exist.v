module errors

pub struct ErrorAlreadyExist {
	Error
}

pub fn (error ErrorAlreadyExist) msg() string {
	return 'Já está registrado no sistema. Obrigado!'
}
