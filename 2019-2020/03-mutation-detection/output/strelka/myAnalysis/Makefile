# This makefile was automatically generated by configureStrelkaWorkflow.pl
#
# Please do not edit.

script_dir := /mnt/work1/software/strelka/1.0.14/libexec
call_script := $(script_dir)/callSomaticVariants.pl
filter_script := $(script_dir)/filterSomaticVariants.pl
finish_script := $(script_dir)/consolidateResults.pl

config_file := /mnt/work1/users/lupiengroup/People/hawleyj/MBP_Tech_Talk_Exercise/output/strelka/myAnalysis/config/run.config.ini

analysis_dir := /mnt/work1/users/lupiengroup/People/hawleyj/MBP_Tech_Talk_Exercise/output/strelka/myAnalysis
results_dir := $(analysis_dir)/results


complete_tag := task.complete

finish_task := $(analysis_dir)/$(complete_tag)

get_chrom_dir = $(analysis_dir)/chromosomes/$1
get_chrom_task = $(call get_chrom_dir,$1)/$(complete_tag)
get_bin_task = $(call get_chrom_dir,$1)/bins/$2/$(complete_tag)



all: $(finish_task)
	@$(print_success)


define print_success
echo;\
echo Analysis complete. Final somatic calls can be found in $(results_dir);\
echo
endef


# top level results target:
#
$(finish_task):
	$(finish_script) --config=$(config_file) && touch $@


# chromosome targets:
#
chrom_chr1_task := $(call get_chrom_task,chr1)
$(finish_task): $(chrom_chr1_task)
$(chrom_chr1_task):
	$(filter_script) --config=$(config_file) --chrom=chr1 && touch $@

chrom_chr11_task := $(call get_chrom_task,chr11)
$(finish_task): $(chrom_chr11_task)
$(chrom_chr11_task):
	$(filter_script) --config=$(config_file) --chrom=chr11 && touch $@

chrom_chr17_task := $(call get_chrom_task,chr17)
$(finish_task): $(chrom_chr17_task)
$(chrom_chr17_task):
	$(filter_script) --config=$(config_file) --chrom=chr17 && touch $@


# chromosome bin targets:
#
chrom_chr1_bin_0000_task := $(call get_bin_task,chr1,0000)
$(chrom_chr1_task): $(chrom_chr1_bin_0000_task)
$(chrom_chr1_bin_0000_task):
	$(call_script) --config=$(config_file) --chrom=chr1 --bin=0000 && touch $@

chrom_chr1_bin_0001_task := $(call get_bin_task,chr1,0001)
$(chrom_chr1_task): $(chrom_chr1_bin_0001_task)
$(chrom_chr1_bin_0001_task):
	$(call_script) --config=$(config_file) --chrom=chr1 --bin=0001 && touch $@

chrom_chr1_bin_0002_task := $(call get_bin_task,chr1,0002)
$(chrom_chr1_task): $(chrom_chr1_bin_0002_task)
$(chrom_chr1_bin_0002_task):
	$(call_script) --config=$(config_file) --chrom=chr1 --bin=0002 && touch $@

chrom_chr1_bin_0003_task := $(call get_bin_task,chr1,0003)
$(chrom_chr1_task): $(chrom_chr1_bin_0003_task)
$(chrom_chr1_bin_0003_task):
	$(call_script) --config=$(config_file) --chrom=chr1 --bin=0003 && touch $@

chrom_chr1_bin_0004_task := $(call get_bin_task,chr1,0004)
$(chrom_chr1_task): $(chrom_chr1_bin_0004_task)
$(chrom_chr1_bin_0004_task):
	$(call_script) --config=$(config_file) --chrom=chr1 --bin=0004 && touch $@

chrom_chr1_bin_0005_task := $(call get_bin_task,chr1,0005)
$(chrom_chr1_task): $(chrom_chr1_bin_0005_task)
$(chrom_chr1_bin_0005_task):
	$(call_script) --config=$(config_file) --chrom=chr1 --bin=0005 && touch $@

chrom_chr1_bin_0006_task := $(call get_bin_task,chr1,0006)
$(chrom_chr1_task): $(chrom_chr1_bin_0006_task)
$(chrom_chr1_bin_0006_task):
	$(call_script) --config=$(config_file) --chrom=chr1 --bin=0006 && touch $@

chrom_chr1_bin_0007_task := $(call get_bin_task,chr1,0007)
$(chrom_chr1_task): $(chrom_chr1_bin_0007_task)
$(chrom_chr1_bin_0007_task):
	$(call_script) --config=$(config_file) --chrom=chr1 --bin=0007 && touch $@

chrom_chr1_bin_0008_task := $(call get_bin_task,chr1,0008)
$(chrom_chr1_task): $(chrom_chr1_bin_0008_task)
$(chrom_chr1_bin_0008_task):
	$(call_script) --config=$(config_file) --chrom=chr1 --bin=0008 && touch $@

chrom_chr1_bin_0009_task := $(call get_bin_task,chr1,0009)
$(chrom_chr1_task): $(chrom_chr1_bin_0009_task)
$(chrom_chr1_bin_0009_task):
	$(call_script) --config=$(config_file) --chrom=chr1 --bin=0009 && touch $@

chrom_chr11_bin_0000_task := $(call get_bin_task,chr11,0000)
$(chrom_chr11_task): $(chrom_chr11_bin_0000_task)
$(chrom_chr11_bin_0000_task):
	$(call_script) --config=$(config_file) --chrom=chr11 --bin=0000 && touch $@

chrom_chr11_bin_0001_task := $(call get_bin_task,chr11,0001)
$(chrom_chr11_task): $(chrom_chr11_bin_0001_task)
$(chrom_chr11_bin_0001_task):
	$(call_script) --config=$(config_file) --chrom=chr11 --bin=0001 && touch $@

chrom_chr11_bin_0002_task := $(call get_bin_task,chr11,0002)
$(chrom_chr11_task): $(chrom_chr11_bin_0002_task)
$(chrom_chr11_bin_0002_task):
	$(call_script) --config=$(config_file) --chrom=chr11 --bin=0002 && touch $@

chrom_chr11_bin_0003_task := $(call get_bin_task,chr11,0003)
$(chrom_chr11_task): $(chrom_chr11_bin_0003_task)
$(chrom_chr11_bin_0003_task):
	$(call_script) --config=$(config_file) --chrom=chr11 --bin=0003 && touch $@

chrom_chr11_bin_0004_task := $(call get_bin_task,chr11,0004)
$(chrom_chr11_task): $(chrom_chr11_bin_0004_task)
$(chrom_chr11_bin_0004_task):
	$(call_script) --config=$(config_file) --chrom=chr11 --bin=0004 && touch $@

chrom_chr11_bin_0005_task := $(call get_bin_task,chr11,0005)
$(chrom_chr11_task): $(chrom_chr11_bin_0005_task)
$(chrom_chr11_bin_0005_task):
	$(call_script) --config=$(config_file) --chrom=chr11 --bin=0005 && touch $@

chrom_chr17_bin_0000_task := $(call get_bin_task,chr17,0000)
$(chrom_chr17_task): $(chrom_chr17_bin_0000_task)
$(chrom_chr17_bin_0000_task):
	$(call_script) --config=$(config_file) --chrom=chr17 --bin=0000 && touch $@

chrom_chr17_bin_0001_task := $(call get_bin_task,chr17,0001)
$(chrom_chr17_task): $(chrom_chr17_bin_0001_task)
$(chrom_chr17_bin_0001_task):
	$(call_script) --config=$(config_file) --chrom=chr17 --bin=0001 && touch $@

chrom_chr17_bin_0002_task := $(call get_bin_task,chr17,0002)
$(chrom_chr17_task): $(chrom_chr17_bin_0002_task)
$(chrom_chr17_bin_0002_task):
	$(call_script) --config=$(config_file) --chrom=chr17 --bin=0002 && touch $@

chrom_chr17_bin_0003_task := $(call get_bin_task,chr17,0003)
$(chrom_chr17_task): $(chrom_chr17_bin_0003_task)
$(chrom_chr17_bin_0003_task):
	$(call_script) --config=$(config_file) --chrom=chr17 --bin=0003 && touch $@

