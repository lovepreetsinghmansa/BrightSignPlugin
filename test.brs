function test_Initialize(msgPort as object, userVariables as object, bsp as object)
	test = newtest(msgPort, userVariables, bsp)
	return test
end function

function newtest(msgPort as object, userVariables as object, bsp as object)
	s = {}
	s.version = 1
	s.msgPort = msgPort
	s.userVariables = userVariables
	s.bsp = bsp
	s.ProcessEvent = test_ProcessEvent
	s.objectName = "test_object"
	s.debug  = true
	return s
end function

function test_ProcessEvent(event as object) as boolean
	if type(event) = "roAssociativeArray" then
		if type(event["EventType"]) = "roString" then
			if (event["EventType"] = "SEND_PLUGIN_MESSAGE") then
				if event["PluginName"] = "test" then
					pluginMessage$ = event["PluginMessage"]
					if pluginMessage$ = "message" then
						? "Plugin working successfully"
					end if
				end if
			end if
		end if
	end if
	return false
end function

sub sendPluginMessage(msgport as object, message$ as string)
	pluginMessageCmd = CreateObject("roAssociativeArray")
	pluginMessageCmd["EventType"] = "EVENT_PLUGIN_MESSAGE"
	pluginMessageCmd["PluginName"] = "test"
	pluginMessageCmd["PluginMessage"] = message$
	msgPort.PostMessage(pluginMessageCmd)
end sub

function updateUserVariable(userVariables as object,name as string,value as string)
	if userVariables <> invalid and name <> invalid and value <> invalid then
		if userVariables.lookup(name) <> invalid then
			userVariables.Lookup(name).setCurrentValue(value,true)
			return true
		else
			return false
		end if
	else
		return false
	end if
end function

function getUserVariableValue(userVariables as object,name as string) as string
	retval = invalid
	if userVariables <> invalid and name <> invalid then
		if userVariables.lookup(name) <> invalid then
			retval = userVariables.Lookup(name).getCurrentValue()
		end if
	end if
	return retval
end function