new_project \
         -name {SF2} \
         -location {C:\Users\Nathan\Desktop\UADL\Internship\Acromax\NAND-Flash-Controller\Project\designer\SF2\SF2_fp} \
         -mode {chain} \
         -connect_programmers {FALSE}
add_actel_device \
         -device {M2S010} \
         -name {M2S010}
enable_device \
         -name {M2S010} \
         -enable {TRUE}
save_project
close_project
