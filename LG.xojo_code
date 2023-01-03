#tag Module
Protected Module LG
	#tag Constant, Name = cAutoFill, Type = String, Dynamic = True, Default = \"For automatic detection of title and class\x2C click on the box and release over the target window.", Scope = Protected
		#Tag Instance, Platform = Any, Language = de, Definition  = \"Zum automatischen F\xC3\xBCllen auf das Rechteck klicken und \xC3\xBCber dem gew\xC3\xBCnschten Fenster los lassen:"
	#tag EndConstant

	#tag Constant, Name = cAutoStart, Type = String, Dynamic = True, Default = \"Autostart after Login", Scope = Protected
		#Tag Instance, Platform = Any, Language = de, Definition  = \"Autostart nach Login"
	#tag EndConstant

	#tag Constant, Name = cButtonSave, Type = String, Dynamic = True, Default = \"&Save", Scope = Protected
		#Tag Instance, Platform = Any, Language = de, Definition  = \"&Speichern"
	#tag EndConstant

	#tag Constant, Name = cButtonTest, Type = String, Dynamic = True, Default = \"&Test", Scope = Protected
		#Tag Instance, Platform = Any, Language = de, Definition  = \"&Testen"
	#tag EndConstant

	#tag Constant, Name = cDetectionMethod, Type = String, Dynamic = True, Default = \"The following method is used for finding the target window:", Scope = Protected
		#Tag Instance, Platform = Any, Language = de, Definition  = \"Zur Erkennung des Zielfensters wird folgendes System verwendet:"
	#tag EndConstant

	#tag Constant, Name = cERROR_KEYREDIRECTOR, Type = String, Dynamic = True, Default = \"Key redirector could not be initialized.", Scope = Protected
		#Tag Instance, Platform = Any, Language = de, Definition  = \"RedirectKeys konnte nicht initialisiert werden."
	#tag EndConstant

	#tag Constant, Name = cERROR_Tray, Type = String, Dynamic = True, Default = \"Could not initialize trayitem.", Scope = Protected
		#Tag Instance, Platform = Any, Language = de, Definition  = \"TrayItem konnte nicht initialisiert werden."
	#tag EndConstant

	#tag Constant, Name = cINFO, Type = String, Dynamic = True, Default = \"This program redirects all keyboard Inputs to the preselected window if scrolllock is active.\r\n\r\nThis can help with exclusive fullscreen programs who don\'t Play nicely with switching between programs.", Scope = Protected
		#Tag Instance, Platform = Any, Language = de, Definition  = \"Bei aktivierter Rollen Taste werden alle Tasten an das gew\xC3\xA4hlte Programm geschickt\x2C ohne den Fokus zu ver\xC3\xA4ndern.\r\rDies kann vor allem bei \xC3\xA4lteren Spielen welche das Tabben nicht m\xC3\xB6gen hilfreich sein.\r"
	#tag EndConstant

	#tag Constant, Name = cOptions, Type = String, Dynamic = True, Default = \"Options", Scope = Protected
		#Tag Instance, Platform = Any, Language = de, Definition  = \"Optionen"
	#tag EndConstant

	#tag Constant, Name = cQuit, Type = String, Dynamic = True, Default = \"Quit", Scope = Protected
		#Tag Instance, Platform = Any, Language = de, Definition  = \"Beenden"
	#tag EndConstant

	#tag Constant, Name = cSETFocus, Type = String, Dynamic = True, Default = \"Set Keyboard Focus", Scope = Protected
		#Tag Instance, Platform = Any, Language = de, Definition  = \"Setze Tastaturfokus"
	#tag EndConstant

	#tag Constant, Name = cSETFocusInfo, Type = String, Dynamic = True, Default = \"Sends the preselected window a keyboard focus message whenever the scrolllock-key is toggled. Some programms may grab the main focus if they receive this message. Programms only show a caret with keyboard focus.", Scope = Protected
		#Tag Instance, Platform = Any, Language = de, Definition  = \"Sended an das eingestellte Fenster ein Keyboard-Focusevent. Einige Programme ziehen den Hauptfokus auf sich\x2C wenn sie den Tastaturfokus erhalten. Programme zeigen keinen Caret ohne Tastaturfokus."
	#tag EndConstant

	#tag Constant, Name = cWindowClass, Type = String, Dynamic = True, Default = \"Window Class", Scope = Protected
		#Tag Instance, Platform = Any, Language = de, Definition  = \"Fenster Klasse"
	#tag EndConstant

	#tag Constant, Name = cWindowClassAndTitle, Type = String, Dynamic = True, Default = \"Window Class and Title", Scope = Protected
		#Tag Instance, Platform = Any, Language = de, Definition  = \"Fenster Klasse und Titel"
	#tag EndConstant

	#tag Constant, Name = cWindowDetection, Type = String, Dynamic = True, Default = \"Window Detection", Scope = Protected
		#Tag Instance, Platform = Any, Language = de, Definition  = \"Fenster Erkennung"
	#tag EndConstant

	#tag Constant, Name = cWindowTitle, Type = String, Dynamic = True, Default = \"Window Title", Scope = Protected
		#Tag Instance, Platform = Any, Language = de, Definition  = \"Fenster Titel"
	#tag EndConstant


End Module
#tag EndModule
