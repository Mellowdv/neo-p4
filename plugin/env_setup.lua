local p4_user = os.getenv("P4USER")
local json_info = io.popen("p4 -Mj -z tag info"):read("a")
print(p4_user)
print(json_info)
