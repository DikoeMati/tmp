import sys,numpy as np, logging
import db
import math
import datetime
import mysql.connector
logging.basicConfig(filename="log.log", level=logging.INFO)
curTime = datetime.datetime.now().timestamp()
try:
    f = open("data.txt", 'r')
except IOError:
    print("No file")
    sys.exit(2)
try:
    data = np.loadtxt(f)
    a = [a[len(data[0])-1] for a in data]
    data = np.hsplit(data, (len(data[0])-1, len(data[0])))
    result: object = np.linalg.solve(data[0], a)
    print(result)
    assert isinstance(result, object)
   # str(result)
except ValueError:
    print(str(error))
try:
    db.DataBase.callFunction('setUr', str(data), str(result))
except mysql.connector.IntegrityError:
    db.DataBase.callFunction('setLogs', str(result), str(curTime))
    logging.info("\nleveln: INFO message: equation: %s result: %s" % (data, result))
f.close()




