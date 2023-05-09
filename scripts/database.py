import os
import sys
import time
import re
import mysql.connector

host_args = {
    "user": os.environ['MYSQL_USER'],
    "password": os.environ['MYSQL_PASSWORD'],
    "host": "db",
    "database": os.environ['MYSQL_DATABASE']
}

con = mysql.connector.connect(**host_args)

def replace_strings(text: str):
    res = list()
    for q in text.split('\n'):
        if q.startswith(')'):
            res.append(")")
        else:
            res.append(q)
    return "\n".join(res)#.split(';')

def execute_sql_files(name):
    path = "/source/["+name+"]"
    cur = con.cursor(dictionary=True)
    print(name+" database loading start")
    time.sleep(1)
    success = 0
    fails = 0
    for root, dirs, files in os.walk(path):
        for file in files:
            if file.endswith('.sql'):
                file_path = os.path.join(root, file)
                with open(file_path) as f:
                    try:
                        r = f.read()#.decode('utf-8')
                        r = r.replace('AUTO_INCREMENT ', 'AUTO_INCREMENT=1 ')
                        for q in r.split(';'):
                            if q and len(q) > 2 and not "DELIMITER $" in q:
                                cur.execute(q, multi=False)
                                success = success + 1
                        # print("Success "+file)
                    except Exception as e:
                        dublicate = "Duplicate" in str(e)
                        if not dublicate:
                            # print("Error in "+file_path) 
                            # print(e)
                            fails = fails + 1
                        # print('======') 
                        # print(r) 
                        # print('======') 
                        
                    # cur.close() 
                    # cur = con.cursor() 

    con.commit()
    con.close()
    print(name+" database loading complete")
    print("Success   ->  ", success)
    print("Fails     ->  ", fails)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python myscript.py <path>")
        sys.exit(1)

    path = sys.argv[1]
    execute_sql_files(path)