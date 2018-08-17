import subprocess

command = '/usr/local/bin/Rscript'
VERA ='/CompSci/VERA_simulation.R'
#args = '~/CSC3003S/CompSci/args.txt'

args =['penninsula', 's34_e018_1arc_v3.tif', 's35_e018_1arc_v3.tif']
cmd =['Rscript --vanilla VERA_simulation.R']

#x = subprocess.Popen(['Rscript --vanilla --args %s %s %s < VERA_simulation.R' % ('penninsula', 's34_e018_1arc_v3.tif', 's35_e018_1arc_v3.tif')], shell=True)
#x.wait()

y = subprocess.Popen(command+' VERA_simulation.R penninsula s34_e018_1arc_v3.tif s35_e018_1arc_v3.tif', shell=True)
output = y.stdout.read()