function printRegistryKeys()
    registrysection = createObject("roregistrysection", "networking")
    for i = 0 to (registrysection.GetKeyList().Count() - 1)
        print registrysection.GetKeyList().GetEntry(i) + " ---> " + registrysection.read(registrysection.GetKeyList().GetEntry(i))
    end for
end function