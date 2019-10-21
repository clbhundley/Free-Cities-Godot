extends Node

var price = 0
var origin = 0

func _ready():
	randomize()
	get_tree().get_root().get_node('Game/Clock').connect('timeout',self,'frame')
	frame()

func frame():
	return origin + cycle()

func negative(input):
	return input * -1

func trend(frame,theta):
	return frame * tan(deg2rad(theta))

func counter(frame,theta):
	return -1 * frame * tan(deg2rad(theta))

var m_theta
var motive = 36000
func motive_wave():
	var frame
	if motive > 28000:
		if motive == 36000:
			m_theta = rand_range(0.0001, 1)
			origin = price
		motive -= 1
		frame = 36000 - motive
		return trend(frame,m_theta)
	elif motive > 23000:
		if motive == 28000:
			m_theta = rand_range(0.0001, 1)
			origin = price
		motive -= 1
		frame = 28000 - motive
		return counter(frame,m_theta)
	elif motive > 13000:
		if motive == 23000:
			m_theta = rand_range(0.0001, 1)
			origin = price
		motive -= 1
		frame = 23000 - motive
		return trend(frame,m_theta)
	elif motive > 8000:
		if motive == 13000:
			m_theta = rand_range(0.0001, 1)
			origin = price
		motive -= 1
		frame = 13000 - motive
		return counter(frame,m_theta)
	elif motive > 0:
		if motive == 8000:
			m_theta = rand_range(0.0001, 1)
			origin = price
		motive -= 1
		frame = 8000 - motive
		return trend(frame,m_theta)
	else:
		#restart
		origin = price
		motive = 35999
		frame = 36000 - motive
		m_theta = rand_range(0.0001, 1)
		return trend(frame,m_theta)

var c_theta
var corrective = 21600
func corrective_wave():
	var frame
	if corrective > 13230:
		if corrective == 21600:
			c_theta = rand_range(0.0001, 1)
			origin = price
		corrective -= 1
		frame = 21600 - corrective
		return negative(trend(frame,c_theta))
	elif corrective > 8370:
		if corrective == 13230:
			c_theta = rand_range(0.0001, 1)
			origin = price
		corrective -= 1
		frame = 13230 - corrective
		return negative(counter(frame,c_theta))
	elif corrective > 0:
		if corrective == 8370:
			c_theta = rand_range(0.0001, 1)
			origin = price
		corrective -= 1
		frame = 8370 - corrective
		return negative(trend(frame,c_theta))
	else:
		#restart
		origin = price
		corrective = 21599
		frame = 21600 - corrective
		c_theta = rand_range(0.0001, 1)
		return negative(trend(frame,c_theta))

var minor = 57600
func minor_wave():
	if minor > 21600:
		minor -= 1
		return motive_wave()
	elif minor > 0:
		minor -= 1
		return corrective_wave()
	else:
		#restart
		minor = 57599
		return motive_wave()

var r_minor = 57600
func reversed_minor_wave():
	if r_minor > 36000:
		r_minor -= 1
		return negative(corrective_wave())
	elif r_minor > 0:
		r_minor -= 1
		return negative(motive_wave())
	else:
		#restart
		r_minor = 57599
		return negative(corrective_wave())

var intermediate = 244800
func intermediate_wave():
	if intermediate > 129600:
		#loop minor x2
		intermediate -= 1
		return minor_wave()
	elif intermediate > 93600:
		intermediate -= 1
		return motive_wave()
	elif intermediate > 57600:
		intermediate -= 1
		return negative(motive_wave())
	elif intermediate > 0:
		intermediate -= 1
		return reversed_minor_wave()
	else:
		#restart
		intermediate = 244799
		return minor_wave()

var r_intermediate = 244800
func reversed_intermediate_wave():
	if r_intermediate > 187200:
		r_intermediate -= 1
		return minor_wave()
	elif r_intermediate > 151200:
		r_intermediate -= 1
		return motive_wave()
	elif r_intermediate > 115200:
		r_intermediate -= 1
		return negative(motive_wave())
	elif r_intermediate > 0:
		#loop minor x2
		r_intermediate -= 1
		return reversed_minor_wave()
	else:
		#restart
		r_intermediate = 244799
		return minor_wave()

var primary = 1036800
func primary_wave():
	if primary > 547200:
		#loop intermediate x2
		primary -= 1
		return intermediate_wave()
	elif primary > 432000:
		#loop minor x2
		primary -= 1
		return minor_wave()
	elif primary > 396000:
		primary -= 1
		return motive_wave()
	elif primary > 360000:
		primary -= 1
		return negative(motive_wave())
	elif primary > 244800:
		primary -= 1
		return reversed_minor_wave()
	elif primary > 0:
		primary -= 1
		return reversed_intermediate_wave()
	else:
		#restart
		primary = 1036799
		return intermediate_wave()

var cycle = 2073600
func cycle():
	if cycle > 1036800:
		cycle -= 1
		return primary_wave()
	elif cycle > 0:
		cycle -= 1
		return negative(primary_wave())
	else:
		#restart
		cycle = 2073599
		return primary_wave()
