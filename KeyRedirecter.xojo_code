#tag Class
Protected Class KeyRedirecter
Inherits WindowsKeyFilterMBS
	#tag Event
		Function KeyDown(vkCode as integer, scanCode as integer, flags as integer, time as integer) As Boolean
		  //We got Informed about a new Key Down
		  //Check if ScrollLock is on.
		  //Redirect Key to the Window.
		  //If this routine ever takes longer than 1 Sek, we will get kicked by Windows.
		  
		  Dim iLParam As Integer
		  Dim bScrollLock As Boolean
		  Dim bReturn As Boolean = False
		  
		  // the flag bits are like this:
		  // bit 0: Specifies whether the key Is an extended key, such As a Function key Or a key on the numeric keypad. The value Is 1 If the key Is an extended key; otherwise, it Is 0.
		  // bit 4: Specifies whether the Event was injected. The value Is 1 If the Event was injected; otherwise, it Is 0.
		  // bit 5: Specifies the context code. The value Is 1 If the ALT key Is pressed; otherwise, it Is 0.
		  // bit 7: Specifies the transition state. The value Is 0 If the key Is pressed And 1 If it Is being released.
		  // Other bits are reserved.
		  
		  bScrollLock = isScrollLockOn()
		  
		  
		  //Global modifiers like Capslock and Numlock need to get handled by Windows
		  If(bScrollLock And _
		    vkCode <> VK_SCROLL And _
		    vkCode <> VK_CAPITAL And _
		    vkCode <> VK_NUMLOCK) Then
		    //iLParam:
		    //0-15 Repitition (unsupported currently)
		    //16-23 Scancode
		    iLParam = 1 + Bitwise.ShiftLeft(scanCode, 16)
		    //24 Extended Key
		    iLParam = iLParam + Bitwise.ShiftLeft(Bitwise.BitAnd(flags, 1), 24)
		    
		    //ALT Keys need to be send as WM_SYSKEYDOWN.
		    If (Bitwise.BitAnd(flags, &B00100000) >= 1) Then
		      //29 = ALTKeyDown
		      iLParam = iLParam + Bitwise.ShiftLeft(1,29)
		      bReturn = WindowFunctions.SendMessage(iHWND, WM_SYSKEYDOWN, vkCode, iLParam)
		    Else
		      bReturn = WindowFunctions.SendMessage(iHWND, WM_KEYDOWN, vkCode, iLParam)
		    End If
		    
		    //Let windows also send these keys, so the global keymap gets updated and functions like Keyboard.AsyncControlKey work.
		    If vkCode = VK_CONTROL Or vkCode = VK_LCONTROL Or vkCode = VK_RCONTROL Or _
		      vkCode = VK_MENU Or vkCode = VK_LMENU Or vkCode = VK_RMENU Or _
		      vkCode = VK_SHIFT Or vkCode = VK_LSHIFT Or vkCode = VK_RSHIFT Then
		      bReturn = False
		    End If
		    
		  ElseIf (App.bSendFocusMessage And vkCode = VK_SCROLL) Then
		    
		    If bScrollLock Then
		      If bFirstScrolllockActive Then
		        bFirstScrolllockActive = False
		        Call WindowFunctions.SendMessage(iHWND, WM_SETFOCUS, 0, 0)
		      End If
		      bFirstScrolllockDeactive = True
		    Else
		      If bFirstScrolllockDeactive Then
		        bFirstScrolllockDeactive = False
		        Call WindowFunctions.SendMessage(iHWND, WM_KILLFOCUS, 0, 0)
		      End If
		      bFirstScrolllockActive = true
		    End If
		    
		  End If
		  
		  Return breturn
		End Function
	#tag EndEvent

	#tag Event
		Function KeyUp(vkCode as integer, scanCode as integer, flags as integer, time as integer) As Boolean
		  //We got informed about a new Key Up.
		  //Check if ScrollLock is on.
		  //Redirect Key to the Window.
		  
		  Dim iLParam As Integer
		  Dim bReturn As Boolean = False
		  
		  // the flag bits are like this:
		  // bit 0: Specifies whether the key Is an extended key, such As a Function key Or a key on the numeric keypad. The value Is 1 If the key Is an extended key; otherwise, it Is 0.
		  // bit 4: Specifies whether the Event was injected. The value Is 1 If the Event was injected; otherwise, it Is 0.
		  // bit 5: Specifies the context code. The value Is 1 If the ALT key Is pressed; otherwise, it Is 0.
		  // bit 7: Specifies the transition state. The value Is 0 If the key Is pressed And 1 If it Is being released.
		  // Other bits are reserved.
		  
		  //Global modifiers like Capslock and Numlock need to get handled by Windows
		  If(isScrollLockOn() And _
		    vkCode <> VK_SCROLL And _
		    vkCode <> VK_CAPITAL And _
		    vkCode <> VK_NUMLOCK) Then
		    //iLParam:
		    //0-15 Repitition (unsupported currently)
		    //16-23 Scancode
		    iLParam = 1 + Bitwise.ShiftLeft(scanCode, 16)
		    //24 Extended Key
		    iLParam = iLParam + Bitwise.ShiftLeft(Bitwise.BitAnd(flags, 1), 24)
		    
		    //30 Prev. State; 31 Transition State; Always 1
		    iLParam = iLParam + Bitwise.ShiftLeft(&b11, 30)
		    
		    //ALT Keys need to be send as WM_SYSKEYDOWN.
		    If (Bitwise.BitAnd(flags, &B00100000) >= 1 Or vkCode = VK_MENU Or vkCode = VK_LMENU) Then
		      //29 = ALTKeyDown
		      iLParam = iLParam + Bitwise.ShiftLeft(1,29)
		      bReturn = WindowFunctions.SendMessage(iHWND, WM_SYSKEYUP, vkCode, iLParam)
		    Else
		      bReturn = WindowFunctions.SendMessage(iHWND, WM_KEYUP, vkCode, iLParam)
		    End If
		    
		    //Let windows also send these keys, so the global keymap gets updated and functions like Keyboard.AsyncControlKey work.
		    If vkCode = VK_CONTROL Or vkCode = VK_LCONTROL Or vkCode = VK_RCONTROL Or _
		      vkCode = VK_MENU Or vkCode = VK_LMENU Or vkCode = VK_RMENU Or _
		      vkCode = VK_SHIFT Or vkCode = VK_LSHIFT Or vkCode = VK_RSHIFT Then
		      bReturn = False
		    End If
		  End If
		  Return bReturn
		End Function
	#tag EndEvent


	#tag Method, Flags = &h0
		Function isScrollLockOn() As Boolean
		  Declare Function GetKeyState Lib "User32.dll" (nVirtKey as integer) as Int16
		  
		  return ((GetKeyState(&h91) AND 1) = 1)
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private bFirstScrolllockActive As Boolean = true
	#tag EndProperty

	#tag Property, Flags = &h21
		Private bFirstScrolllockDeactive As Boolean = true
	#tag EndProperty

	#tag Property, Flags = &h0
		iHWND As Integer
	#tag EndProperty


	#tag Constant, Name = VK_CAPITAL, Type = Double, Dynamic = False, Default = \"&h14", Scope = Private
	#tag EndConstant

	#tag Constant, Name = VK_CONTROL, Type = Double, Dynamic = False, Default = \"&h11", Scope = Private
	#tag EndConstant

	#tag Constant, Name = VK_LCONTROL, Type = Double, Dynamic = False, Default = \"&hA2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = VK_LMENU, Type = Double, Dynamic = False, Default = \"&hA4", Scope = Private
	#tag EndConstant

	#tag Constant, Name = VK_LSHIFT, Type = Double, Dynamic = False, Default = \"&hA0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = VK_MENU, Type = Double, Dynamic = False, Default = \"&h12", Scope = Private
	#tag EndConstant

	#tag Constant, Name = VK_NUMLOCK, Type = Double, Dynamic = False, Default = \"&h90", Scope = Private
	#tag EndConstant

	#tag Constant, Name = VK_RCONTROL, Type = Double, Dynamic = False, Default = \"&hA3", Scope = Private
	#tag EndConstant

	#tag Constant, Name = VK_RMENU, Type = Double, Dynamic = False, Default = \"&hA5", Scope = Private
	#tag EndConstant

	#tag Constant, Name = VK_RSHIFT, Type = Double, Dynamic = False, Default = \"&hA1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = VK_SCROLL, Type = Double, Dynamic = False, Default = \"&h91", Scope = Private
	#tag EndConstant

	#tag Constant, Name = VK_SHIFT, Type = Double, Dynamic = False, Default = \"&h10", Scope = Private
	#tag EndConstant

	#tag Constant, Name = WM_KEYDOWN, Type = Double, Dynamic = False, Default = \"&h100", Scope = Private
	#tag EndConstant

	#tag Constant, Name = WM_KEYUP, Type = Double, Dynamic = False, Default = \"&h101", Scope = Private
	#tag EndConstant

	#tag Constant, Name = WM_KILLFOCUS, Type = Double, Dynamic = False, Default = \"&h8", Scope = Private
	#tag EndConstant

	#tag Constant, Name = WM_SETFOCUS, Type = Double, Dynamic = False, Default = \"&h7", Scope = Private
	#tag EndConstant

	#tag Constant, Name = WM_SYSKEYDOWN, Type = Double, Dynamic = False, Default = \"&h104", Scope = Private
	#tag EndConstant

	#tag Constant, Name = WM_SYSKEYUP, Type = Double, Dynamic = False, Default = \"&h105", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="iHWND"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
