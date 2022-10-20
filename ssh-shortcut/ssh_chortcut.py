class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

print (bcolors.OKGREEN + "  _________ _________ ___ ___     _________.__                   __                 __    "+ bcolors.ENDC)
print (bcolors.OKGREEN + " /   _____//   _____//   |   \   /   _____/|  |__   ____________/  |_  ____  __ ___/  |_  "+ bcolors.ENDC)
print (bcolors.OKGREEN + " \_____  \ \_____  \/    ~    \  \_____  \ |  |  \ /  _ \_  __ \   __\/ ___\|  |  \   __\ "+ bcolors.ENDC)
print (bcolors.OKGREEN + " /        \/        \    Y    /  /        \|   Y  (  <_> )  | \/|  | \  \___|  |  /|  |   "+ bcolors.ENDC)
print (bcolors.OKGREEN + "/_______  /_______  /\___|_  /  /_______  /|___|  /\____/|__|   |__|  \___  >____/ |__|   "+ bcolors.ENDC)
print (bcolors.OKGREEN + "        \/        \/       \/           \/      \/                        \/              "+ bcolors.ENDC)

print (bcolors.OKGREEN + "loading..."+ bcolors.ENDC)
print ()
print (bcolors.WARNING +"Press 'Ctrl + C' to exit the Programm"+ bcolors.ENDC)
print ()
print(bcolors.OKGREEN +"==============="+ bcolors.ENDC)
print()

while True :
    host = input(bcolors.OKGREEN +"Host: "+ bcolors.ENDC)
    hostname = input(bcolors.OKGREEN +"HostName: "+ bcolors.ENDC)
    port = input(bcolors.OKGREEN +"Port: "+ bcolors.ENDC)
    user = input(bcolors.OKGREEN +"User: "+ bcolors.ENDC)
    print(bcolors.OKGREEN +"==============="+ bcolors.ENDC)
    print()
    print()
    print(bcolors.WARNING + "Please Confirm:"+ bcolors.ENDC)
    print(bcolors.OKGREEN +"Host:     "+bcolors.WARNING, host + bcolors.ENDC)
    print(bcolors.OKGREEN +"HostName: "+bcolors.WARNING, hostname + bcolors.ENDC)
    print(bcolors.OKGREEN +"Port:     "+bcolors.WARNING, port + bcolors.ENDC)
    print(bcolors.OKGREEN +"User:     "+bcolors.WARNING, user + bcolors.ENDC)
    print()

    confirm = input(bcolors.WARNING +"Apply? (Y/n) "+ bcolors.ENDC).lower()
    if confirm == "y" or confirm == "Y" :
        with open("/Users/shoellein/.ssh/config", "a") as ssh_config:
            ssh_config.write("Host " +host +"\n" +"HostName " +hostname +"\n" +"Port " +port +"\n" +"User " +user +"\n")
        print()

        rsa = input(bcolors.WARNING +"Default IdentityFile (Y/n) "+ bcolors.ENDC).lower()
        if rsa == "y" or rsa == "Y" :
            with open("/Users/shoellein/.ssh/config", "a") as ssh_config:
                ssh_config.write("IdentityFile /Users/shoellein/.ssh/id_rsa" +"\n" +"\n")
            print(bcolors.OKGREEN +"==============="+bcolors.ENDC)
            print(bcolors.OKGREEN +"#--- Host", hostname, "has been added"+bcolors.ENDC)
            print()
            print()
            pass

        else:
            with open("/Users/shoellein/.ssh/config", "a") as ssh_config:
                ssh_config.write("\n")
            print(bcolors.OKGREEN +"==============="+bcolors.ENDC)
            print(bcolors.OKGREEN +"#--- Host", hostname, "has been added"+bcolors.ENDC)
            print()
            print()
        pass

    else:
        print(bcolors.FAIL +"==============="+bcolors.ENDC)
        print(bcolors.FAIL +"try again:"+ bcolors.ENDC)
        print()
    