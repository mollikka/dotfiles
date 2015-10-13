from urllib.error import URLError
from urllib.request import urlopen
import json
import datetime
import sys
from os.path import expanduser

api             = 'http://outside.aalto.fi/data.txt'

order    = (
                   "timestamp",
                   "gent-outside-t",
                   "gent-outside-h",
                   "gent-outside-b",
                   "gent-outside-l",
)

conf     = {
                   "timestamp-pre":     "Otaniemen sää",
                   "gent-2.025-t-pre":  "",
                   "gent-2.025-h-pre":  "",
                   "gent-outside-t-pre":"Lämpö:  ",
                   "gent-outside-h-pre":"Kosteus:",
                   "gent-outside-b-pre":"Paine:  ",
                   "gent-outside-l-pre":"Valo:   ",


                   "timestamp-pst":     "",
                   "gent-2.025-t-pst":  "",
                   "gent-2.025-h-pst":  "",
                   "gent-outside-t-pst":"°C",
                   "gent-outside-h-pst":"%",
                   "gent-outside-b-pst":"hPa",
                   "gent-outside-l-pst":"lx",
}




def fetch_api(api):
    try:
        response = urlopen(api).read().decode("utf-8")
        decoded = json.loads(response)
        return decoded
    except URLError as detail:
        print("Couldn't connect to ",lunchapi)
        print(detail)
    except Exception as detail:
        print(detail)

def main(conf, order):

    apidata = fetch_api(api)

    for item in order:
        if not item in apidata: continue #data doesnt include the thing
        
        pre = conf[item+"-pre"]
        data = str(apidata[item])
        pst = conf[item+"-pst"]
         
        print(pre,data,pst)

if __name__ == '__main__':

    sys.exit(main(conf, order))


