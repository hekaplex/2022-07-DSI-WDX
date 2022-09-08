import argparse
import datetime
# help (-h from cmd line) flag provides flag help
# store_true actions stores argument as True

parser = argparse.ArgumentParser()
#optional parameter   
# store_true actions stores argument as True
parser.add_argument('-o', '--output', action='store_true', 
    help="shows output")
#required parameter metavar is for help
parser.add_argument('-b', type=int, required=True, help="defines the base value", metavar="base")
#optional parameters
parser.add_argument('-e', type=int, default=2, help="defines the exponent value", metavar="exponent")
#optional with default and choice
parser.add_argument('--now', dest='format', choices=['std', 'iso', 'unix', 'tz'], default='iso',
                    help="shows datetime in given format")

args = parser.parse_args()
fmt = args.format
print(type(args))
if fmt == 'std':
    print(datetime.date.today())
elif fmt == 'iso':
    print(datetime.datetime.now().isoformat())
elif fmt == 'unix':
    print(time.time())
elif fmt == 'tz':
    print(datetime.datetime.now(datetime.timezone.utc))
val = 1

base = args.b
exp = args.e

for i in range(exp):
    val *= base

print(val)


if args.output:
    print("This is some output")

