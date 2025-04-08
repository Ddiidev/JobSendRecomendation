module main

import time
import maisfoco_server
import recomendation.services

const sabado = 6
const domingo = 7

fn main() {
	println('Iniciando serviço de recomendação...')
	mut is_primary_runner := true

	go maisfoco_server.start_server()

	for {
		current_time := time.now()

		current_date := current_time.custom_format('YYYY-MM-DD')
		current_hour := current_time.hour

		mut serven_hour_today := time.parse('${current_date} 06:00:00') or { time.now() }

		range_start := time.parse('${current_date} 06:00:00') or { time.now() }
		range_end := time.parse('${current_date} 08:00:00') or { time.now() }

		serven_hour_today = match current_time.day_of_week() {
			sabado {
				serven_hour_today.add_days(2)
			}
			domingo {
				serven_hour_today.add_days(1)
			}
			else {
				if current_hour >= 9 {
					// Se a hora atual for maior ou igual a 9:00, define para as 9:00 do dia seguinte.
					serven_hour_today.add_days(1)
				} else {
					serven_hour_today
				}
			}
		}

		mut wait_time := serven_hour_today - current_time

		if wait_time < 0 {
			serven_hour_today = serven_hour_today.add_days(1)
			wait_time = serven_hour_today - current_time
		}

		$if prod {
			println('--> PRODUÇÃO')
			if !(current_time > range_start && current_time < range_end && is_primary_runner) {
				println('Aguardando ${wait_time.debug()} até o próximo envio...')
				time.sleep(wait_time)
			} else if current_time > range_start && current_time < range_end && is_primary_runner {
				println('Primeira vez: Executando imediatamente por estar entre as ${range_start.custom_format('hh:mm:ss')}h e ${range_end.custom_format('hh:mm:ss')}h')
			}
		} $else $if debug ? {
			println('--> DESENVOLVIMENTO')
			if !(current_time > range_start && current_time < range_end && is_primary_runner) {
				println('Aguardando ${wait_time.debug()} até o próximo envio...')
				time.sleep(time.minute * 2)
			} else if current_time > range_start && current_time < range_end && is_primary_runner {
				println('Primeira vez: Executando imediatamente por estar entre as ${range_start.custom_format('hh:mm:ss')}h e ${range_end.custom_format('hh:mm:ss')}h')
			}
		}
		is_primary_runner = false

		println('--> Enviando recomendações...')
		services.send_recomendations()
		println('--> Enviado')
	}
}
