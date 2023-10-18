local p4_user = os.getenv("P4USER")
local json_info = os.execute("p4 -Mj -z tag info")
print(p4_user)
print(json_info)
