#tag Module
Protected Module WindowFunctions
	#tag Method, Flags = &h1
		Protected Sub AddToStartUp(bEnabled as Boolean)
		  Dim oReg as RegistryItem
		  Dim f as FolderItem
		  Dim sName as String
		  
		  f = App.ExecutableFile
		  
		  sName = "SendKeys"
		  
		  oReg = new RegistryItem("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run")
		  
		  if bEnabled then //Item hinzufügen
		    oReg.Value(sName) = Chr(34)+f.NativePath+Chr(34)
		  else //Item Entfernen
		    oReg.Delete(sName)
		  end if
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function BringWindowToTop(iWindow as Integer) As Boolean
		  Declare Function BringWindowToTop lib "user32" (hWnd as Integer) as Boolean
		  
		  return BringWindowToTop(iWindow)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function FlashWindow(iWindowHandle as Integer, iFlags as Integer, iCount as Integer, iTimeout as Integer) As Boolean
		  Declare Function FlashWindowEx lib "user32" (pfwi as Ptr) as Boolean
		  
		  Dim struc as WindowFunctions.FLASHWINFO
		  Dim m as MemoryBlock
		  
		  struc.cbSize = struc.Size
		  struc.hwnd = iWindowHandle
		  struc.dwFlags = iFlags
		  struc.uCount = iCount
		  struc.dwTimeout = iTimeout
		  
		  m = struc.StringValue(true)
		  
		  return FlashWindowEx(m)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function getWindow(sClass as String, sTitle as String) As Integer
		  Declare Function FindWindowW Lib "user32" (lpClassName as PString, lpWindowName as CString) as Integer
		  Declare Function FindWindowW Lib "user32" (lpClassName as Integer, lpWindowName as CString) as Integer
		  Declare Function FindWindowW Lib "user32" (lpClassName as WString, lpWindowName as Integer) as Integer
		  
		  Dim i as Integer = 0
		  
		  if(sClass <> "" AND sTitle <> "") then
		    
		    i = FindWindowW(sClass, sTitle)
		    
		  elseif(sTitle <> "") then
		    
		    i = FindWindowW(0, sTitle)
		    
		  elseif(sClass <> "") then
		    i = FindWindowW(sClass, 0)
		  end if
		  
		  return i
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function isInStartUp() As Boolean
		  Dim oReg as RegistryItem
		  Dim f as FolderItem
		  Dim sName as String
		  
		  f = App.ExecutableFile
		  
		  sName = "SendKeys"
		  
		  oReg = new RegistryItem("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", false)
		  
		  return (oReg.Value(sName) <> NIL)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SendMessage(iWindow as Integer, iMsg as Integer, iWParam as Integer, iLParam as Integer) As Boolean
		  Declare Function PostMessageW Lib "User32.dll" (hWnd as Integer, Msg as Integer, wParam as Integer, lParam as Integer) as Boolean
		  
		  return PostMessageW(iWindow, iMsg, iWParam, iLParam)
		End Function
	#tag EndMethod


	#tag Constant, Name = FLASHW_ALL, Type = Double, Dynamic = False, Default = \"&h03", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FLASHW_CAPTION, Type = Double, Dynamic = False, Default = \"&h01", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FLASHW_STOP, Type = Double, Dynamic = False, Default = \"&h00", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FLASHW_TIMER, Type = Double, Dynamic = False, Default = \"&h04", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FLASHW_TIMERNOFG, Type = Double, Dynamic = False, Default = \"&h0C", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FLASHW_TRAY, Type = Double, Dynamic = False, Default = \"&h02", Scope = Protected
	#tag EndConstant


	#tag Structure, Name = FLASHWINFO, Flags = &h0, Attributes = \"StructureAlignment \x3D 1"
		cbSize as UInt32
		  hwnd as Integer
		  dwFlags as Integer
		  uCount as UInt32
		dwTimeout as Integer
	#tag EndStructure


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
			InitialValue="-2147483648"
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
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
