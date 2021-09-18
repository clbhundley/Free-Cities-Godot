extends Node

onready var _slave = get_parent()

var assignment_motivation setget ,get_assignment_motivation
func get_assignment_motivation():
	match _slave.assignment:
		"Prostitute":
			_slave.devotion
			_slave.libido
			_slave.submission
			_slave.skills.prostitution
			_slave.skills.sexual_total
			#emotional_slut
			#attention_whore

func basic_needs():
	var basic_needs = ['bathroom','hunger','fatigue','arousal'] #happiness
	var ranked_needs = []
	for need in basic_needs:
		ranked_needs.append(Entry.new(need,_slave.get(need)))
	ranked_needs.sort_custom(Entry.SortByValue,'sort_descending')
	return ranked_needs

func greatest_need():
	var ranked_needs = basic_needs()
	for need in ranked_needs:
		match need.name:
			'bathroom':
				if need.value >= 80:
					return need
				elif need.value >= 50:
					need.value += 10
			'hunger':
				if need.value >= 70:
					return need
				elif need.value >= 60:
					need.value += 10
			'fatigue':
				if _slave.bathroom > rand_range(40,50):
					return Entry.new('bathroom',_slave.bathroom)
				elif _slave.hunger > rand_range(50,60):
					return Entry.new('hunger',_slave.hunger)
				elif need.value >= 90:
					return need
				elif need.value >= 70:
					need.value += 10
			'arousal':
				if _slave.bathroom > rand_range(50,60):
					return Entry.new('bathroom',_slave.bathroom)
				elif _slave.hunger > rand_range(60,70):
					return Entry.new('hunger',_slave.hunger)
				if need.value >= 90:
					return need
				elif need.value >= 80:
					need.value += 10
		if clamp(need.value,0,100) >= randi()%100:
			return need
	return ranked_needs[0]

func action_end():
	_slave.get_node('UI/Activity/Time').set_text("Done")
	_slave.get_node('UI/Activity/Action').set_text("")
	choose_next_action()

#greatest need * inverse motivation
#check motivation for assignment vs greatest need
#high fear = + chance to do assignment
#low devotion = - chance to do assignment
func choose_next_action():
	var greatest_need = greatest_need()
	if _slave.queued_action:
		_slave.action = _slave.queued_action
		_slave.queued_action = null
		return
	match greatest_need.name: #consider assignment_motivation here
		'bathroom':
			if _slave.bathroom > rand_range(40,60):
				seek_bathroom()
				return
		'hunger':
			if _slave.hunger > rand_range(50,70):
				seek_food()
				return
		'fatigue':
			if _slave.fatigue > rand_range(60,75):
				seek_rest()
				return
		'arousal':
			if _slave.arousal > rand_range(40,80):
				seek_sex()
				return
	match _slave.assignment:
		'Prostitute':
			set_action('Soliciting')
			set_queued_action('ServicingCustomer')
		'Resting':
			if randi()%4 == 0:
				seek_social_interaction()
			else:
				set_action('Idle')

func set_action(action):
	_slave.action = _slave.get_node('Actions/'+action)

func set_queued_action(queued_action):
	_slave.queued_action = _slave.get_node('Actions/'+queued_action)

func seek_bathroom():
	if _slave.location == _slave.quarters:
		set_action('Bathroom')
	else:
		_slave.destination = _slave.quarters
		set_action('Travel')
		set_queued_action('Bathroom')

func seek_food():
	var nutrition_system_location = ArcUtils.get_nutrition_system()
	if _slave.location == nutrition_system_location:
		set_action('Eating')
	else:
		_slave.destination = nutrition_system_location
		set_action('Travel')
		set_queued_action('Eating')

func seek_rest():
	if _slave.location == _slave.quarters:
		set_action('Sleeping')
	else:
		_slave.destination = _slave.quarters
		set_action('Travel')
		set_queued_action('Sleeping')

func seek_sex():
	if _slave.location == _slave.quarters:
		set_action('SeekSex')
	else:
		_slave.destination = _slave.quarters
		set_action('Travel')
		set_queued_action('SeekSex')

func seek_social_interaction():
	var proximity_social = SlaveUtils.proximity_social(_slave)
	if proximity_social.size() > 0:
		var negative_social = []
		for other_slave in proximity_social:
			if sign(other_slave.values()[0]) == -1:
				negative_social.append(other_slave)
		for other_slave in negative_social:
			proximity_social.erase(other_slave)
		if proximity_social.size() > 0:
			set_action('Socializing')
#			if proximity_social.size() > 2 and randi()%2 == 0:
#				pass
#			elif proximity_social.size() > 0:
#				var roll = abs(math.gaussian(0,1))
#				var target = min(roll,proximity_social.size()-1)
#				var selected_slave = proximity_social[target].keys()[0]
	elif _slave.location != _slave.quarters:
		_slave.destination = _slave.quarters
		set_action('Travel')
	else:
		set_action('Idle')

#chance for masturbation
#in a relationship?
#Emotionally bonded to player?
#Emotional slut?
#check devotion
# if devotion <
#chance for consensual interaction
#chance for nonconsensual interaction
