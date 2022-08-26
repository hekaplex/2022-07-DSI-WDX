import random
import psutil
from multiprocessing import Pool, cpu_count
from math import sqrt
from timeit import default_timer as timer


def pi_part(n):
    #print segment range part_count
    print("Assigning Core {0}, range {1}".format(*n))
    p = psutil.Process()
    worker = n[0]
    calc_range = n[1]
    p.cpu_affinity([worker])
    print(f"Child #{worker}: Set my affinity to {worker}, affinity now {p.cpu_affinity()}", flush=True)
    print(f"Child #{worker}: Starting CPU intensive task now on {p.cpu_affinity()}...", flush=True)
    count = 0
    for i in range(int(calc_range)):
        x, y = random.random(), random.random()
        r = sqrt(pow(x, 2) + pow(y, 2))
        if r < 1:
            count += 1
    return count
    print(f"Child #{worker}: Finished CPU intensive task on {p.cpu_affinity()}", flush=True)

def main():

    start = timer()
    np = cpu_count()
    print(f'You have {np} cores')
    n = 1_000_000_000
    part_count = [[i, n/np] for i in range(np)]

    with Pool(processes=np) as pool:

        count = pool.map(pi_part, part_count)
        pi_est = sum(count) / (n * 1.0) * 4
        end = timer()
        print(f'elapsed time: {end - start}')
        print(f'π estimate: {pi_est}')

if __name__=='__main__':
    main()