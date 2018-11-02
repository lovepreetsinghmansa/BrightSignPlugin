Function test_Initialize(msgPort As Object, userVariables As Object, bsp as Object)
    test = newtest(msgPort, userVariables, bsp)
    return test
End Function

Function newtest(msgPort As Object, userVariables As Object, bsp as Object)
	s = {}
	s.version = 1
	s.msgPort = msgPort
	s.userVariables = userVariables
	s.bsp = bsp
	s.ProcessEvent = test_ProcessEvent
	s.objectName = "test_object"
	s.debug  = true
	return s
End Function

Function test_ProcessEvent(event As Object) as boolean
	if type(event) = "roAssociativeArray" then
        if type(event["EventType"]) = "roString" then
             if (event["EventType"] = "SEND_PLUGIN_MESSAGE") then
                if event["PluginName"] = "test" then
					pluginMessege$ = event["PluginMessage"]
					if pluginMessege$ = "message" then
						? "Plugin working successfully"
					endif
				endif
            endif
        endif
	endif
	return false
End Function