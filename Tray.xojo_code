#tag Class
Protected Class Tray
Inherits TrayItem
	#tag Event
		Sub Action(cause as Integer)
		  Dim oCon As New MenuItem
		  Dim oRet as MenuItem
		  
		  if(cause = TrayItem.RightMouseButton) then
		    oCon.Append(New MenuItem(LG.cOptions, 1))
		    oCon.Append(New MenuItem(LG.cQuit, 2))
		    
		    oRet = oCon.PopUp
		    
		    if(oRet <> NIL) then
		      
		      if(oRet.Tag = 1) then
		        W_Optionen.Show
		      else
		        Quit
		      end if
		    end if
		  elseif(cause = TrayItem.DoubleClick) then
		    W_Optionen.Show
		  end if
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h1000
		Sub Constructor()
		  Me.Icon = tray_icon
		  me.HelpTag = "Redirect Keys"
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Tooltip"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Icon"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Picture"
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
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
