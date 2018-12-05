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
					pluginMessege$ = event["PluginMessage"]
					if pluginMessege$ = "message" then
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

sub updateUserVariable(userVariables as object,name as string,value as string)
	if userVariables <> invalid and name <> invalid and value <> invalid then
		if userVariables.lookup(name) <> invalid then
			userVariables.Lookup(name).setCurrentValue(value,true)
		else
			? "User variable " + name + " not found."
		end if
	else
		? "Plugin Error: Unable to update variable."
	end if
end sub

function getUserVariableValue(userVariables as object,name as string) as string
	retval = ""
	if userVariables <> invalid and name <> invalid then
		if userVariables.lookup(name) <> invalid then
			retval = userVariables.Lookup(name).getCurrentValue()
		else
			? "User variable " + name + " not found."
		end if
	else
		? "Plugin Error: Unable to get variable value."
	end if
	return retval
end function