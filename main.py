import sys, numpy as np, logging, datetime
import db
logging.basicConfig(filename="log.log", level=logging.INFO)
CTime = datetime.datetime.now().timestamp()
try:
    f = open("data.txt", 'r')
except IOError:
    print("No file")
    sys.exit(2)
try:
    data = np.loadtxt(f)
    a = [a[len(data[0])-1] for a in data]
    data = np.hsplit(data, (len(data[0])-1,len(data[0])))
    result = np.linalg.solve(data[0], a)
    print(result)
except ValueError:
    print(str(error))
try:
    db.DataBase.callFunction('setUr', str(data), str(np.linalg.solve(result)))
except mysql.connector.IntegrityError:
    db.DataBase.callFunction('setLogs', str(np.linalg.solve(result)), str(CTime))
    logging.info("\nleveln: INFO message: equation: %s result: %s" % (data, result))
f.close()




