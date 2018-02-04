extends Node

static func new():
    var ethnicities = {
        "Africa": ["Arabic", "Ethiopian", "Egyptian"],
        "Asia": ["Korean", "Japanese", "Chinese", "Indian"],
        "Australia": ["British", "Italian", "Vietnamese"],
        "Europe": ["British", "French", "German", "Italian", "Spanish", "Russian", "Turkish"],
        "Middle East": ["Egyptian", "Iranian", "Saudi", "Turkish"],
        "North America": ["British", "French", "German", "Italian", "Spanish", "Korean", "Japanese", "Chinese", "Indian", "Mexican"], 
        "South America": ["Brazilian", "Colombian", "Mexican", "Latina"]
	}
    randomize()
    return(ethnicities[arcology.location][randi() % ethnicities[arcology.location].size()])
