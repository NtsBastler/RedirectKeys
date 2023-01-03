#tag Class
Protected Class App
Inherits Application
	#tag Event
		Sub Close()
		  //Remove the Tray Icon we created in the Open Event.
		  If oTray <> Nil Then
		    me.RemoveTrayItem(oTray)
		  end if
		End Sub
	#tag EndEvent

	#tag Event
		Sub Open()
		  //This is by default a Windowless app.
		  //We disable AutoQuit (Quit after Last Windows closes) and add our Tray Icon for User Interaction.
		  Me.AutoQuit = False
		  
		  oTray = new Tray()
		  
		  //Add small Tray Icon
		  if not me.AddTrayItem(oTray) then
		    oTray = NIL
		    MsgBox LG.cERROR_Tray
		    Quit
		  end if
		  
		  MBS_Lizenz
		  
		  InstallProfile()
		  
		  //Add redirector
		  oRedirector = New KeyRedirecter()
		  updateWindowHandle()
		  If Not oRedirector.Install Then
		    MsgBox LG.cERROR_KEYREDIRECTOR
		    Quit
		  End If
		  
		  //Update Window Handle every secound
		  oTimer = New UpdateWindowHandle
		  oTimer.Period = 1000
		  oTimer.RunMode = Timer.RunModes.Multiple
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1
		Protected Sub InstallProfile()
		  Dim oReg As RegistryItem
		  
		  oReg = new RegistryItem("HKEY_CURRENT_USER\Software\Bastler\RedirectKeys", true)
		  
		  if(oReg.Value("Class") <> NIL) then
		    sClass = oReg.Value("Class").StringValue
		  else
		    oReg.Value("Class") = ""
		    sClass = ""
		  end if
		  
		  If(oReg.Value("Title") <> Nil) Then
		    sTitle = oReg.Value("Title").StringValue
		  else
		    oReg.Value("Title") = ""
		    sTitle = ""
		  End If
		  
		  If(oReg.Value("Focus") <> Nil) Then
		    bSendFocusMessage = oReg.Value("Focus").BooleanValue
		  Else
		    oReg.Value("Focus") = False
		    bSendFocusMessage = False
		  End If
		  
		  if(sClass = "" AND sTitle = "") then
		    
		    W_Optionen.Show
		    
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub updateWindowHandle()
		  If App.oRedirector <> Nil Then
		    App.oRedirector.iHWND = WindowFunctions.getWindow(App.sClass, App.sTitle)
		  end if
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		bSendFocusMessage As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		oRedirector As KeyRedirecter
	#tag EndProperty

	#tag Property, Flags = &h0
		oTimer As UpdateWindowHandle
	#tag EndProperty

	#tag Property, Flags = &h0
		oTray As Tray
	#tag EndProperty

	#tag Property, Flags = &h0
		sClass As String
	#tag EndProperty

	#tag Property, Flags = &h0
		sTitle As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="sTitle"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="sClass"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
