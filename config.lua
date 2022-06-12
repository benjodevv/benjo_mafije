
Config = {
	BossMenuUsers = {

		['boss'] = {canWithdraw = true, canDeposit = true, canHire = true, canRank = true, canFire = true, canBonus = true},
		['recruit'] = {canWithdraw = false, canDeposit = true, canHire = false, canRank = false, canFire = false, canBonus = false}
	
	},
	
	
	DefaultJobsInJobCenter = { 
		
		{job = 'unemployed', label = "Nezaposlen", icon = "fas fa-user-times", description = "Bez posla!"},
		{job = 'garbage', label = "Smecar", icon = "fas fa-recycle", description = "Radite kao smecar, skupljajte i prevozite smece!"},
		{job = 'trucker', label = "Kamiondzija", icon = "fas fa-microchip", description = "Prevozite Prikolice sa kamionom!"},
		{job = 'miner', label = "Rudar", icon = "fas fa-gem", description = "Sakupljate i prodajete rude!"}
	},
}


Config.Organizacije = { 
	ballas = {
		--vozila
		name = "ballas",
		coords = vector3(1170.113, -3061.13, 5.9021), -- kordinate za peda i za target za vozila
		debug = false,
		heading = 80.0, -- heading za peda i target za vozila
		width = 0.9, -- dimenzije polyzone
		length = 0.9, -- dimenzije polyzone
		event = 'nh-context:mafijav3', -- event za spawn vozila
		model = "g_m_y_azteca_01", -- hash peda
		job = 'ballas',
    
        --- sef 
		ImeSefa = "ballassef",
		label = "Ballas Sef",
		slots = 50,
		weight = 100000,
		owner = false,
		prop = 'prop_ld_int_safe_01',
		lokacija = vector3(-110.846, 911.9935, 235.99),
		headings = 0.0,
		widths = 0.9, -- dimenzije polyzone
		lengths = 0.9, --dimenzije polyzone 


		----bossmenui
	
		bossmenu = "Ballas BossMenu",
		blokacija = vector3(1172.207, -3068.16, 5.8991),
		headingb = 100.0,
		widthb = 0.9, -- dimenzije polyzone
		lengthb = 0.9, --dimenzije polyzone 
		debugb = false -- upalite ovo da bi vam bilo lakse namjestiti polozaj targeta


	},
	zemunski = {
		--vozila
		name = "zemunski",
		coords = vector3(-118.512, 1008.077, 234.75), -- kordinate za peda i za target za vozila(ako ped bude u vazduhu 'z' smanji za 1)
		debug = false,
		heading = 100.0, -- heading za peda i target za vozila
		width = 0.9, -- dimenzije polyzone
		length = 0.9, -- dimenzije polyzone
		event = 'nh-context:mafijav', -- event za spawn vozila
		model = "g_m_y_azteca_01", -- hash peda
		job = 'zemunski',
    
        --- sef 
		ImeSefa = "zemunskisef",
		label = "Zemunski sef",
		slots = 50,
		weight = 100000,
		owner = false,
		prop = 'prop_ld_int_safe_01',
		lokacija = vector3(-97.7434, 997.2805, 234.75),
		headings = 90.0,
		widths = 0.9, -- dimenzije polyzone
		lengths = 0.9, --dimenzije polyzone 


		----bossmenui
	
		bossmenu = "Zemunski bossmeni",
		blokacija = vector3(-106.459, 980.9487, 240.88),
		headingb = 100.0,
		widthb = 3.5, -- dimenzije polyzone
		lengthb = 3.5, --dimenzije polyzone 
		debugb = false -- upalite ovo da bi vam bilo lakse namjestiti polozaj targeta


	},

}

Config.Diler = {
	zemunski = {
		--dilerxD
		name = "zemunski",
		coords = vector3(-882.742, 7.984716, 43.553), -- kordinate za peda i za target dilera
		debug = false,
		heading = 100.0, -- heading za peda i target za dilera
		width = 0.9, -- dimenzije polyzone
		length = 0.9, -- dimenzije polyzone
		event = 'nh-context:katalogprodaje', -- event za spawn dilera
		model = "g_m_y_azteca_01", -- hash peda
		job = 'zemunski',
    },
}

Config.Maksimalnodroge = 20 -- najvise koliko moze da proda droge
Config.Cenapojednom = 500 -- cena za 1 komad
Config.Policijazaprodaju = 0