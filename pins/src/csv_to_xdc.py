import csv

with open('bergen_pins.csv', newline='') as csvfile:
    pinreader = csv.reader(csvfile, delimiter=',')
    for row in pinreader:
        if row[0] == 'Pin Designator':
            header_found = True
            continue
            
        if header_found:
            pin_name = "PACKAGE_PIN " + row[0].rjust(4)
            
            if len(row[3]) > 1:
                io_standard = "IOSTANDARD " + row[3].rjust(9)
            else:
                io_standard = "                     "
            
            pin_spec = pin_name + "  " + io_standard
            line = "set_property -dict { " + pin_spec + " } [get_ports { " + row[1] + " }]; #" + row[2]
            
            print(line)
