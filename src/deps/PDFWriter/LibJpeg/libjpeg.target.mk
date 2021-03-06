# This file is generated by gyp; do not edit.

TOOLSET := target
TARGET := libjpeg
DEFS_Debug := \
	'-D_DARWIN_USE_64_BIT_INODE=1' \
	'-D_LARGEFILE_SOURCE' \
	'-D_FILE_OFFSET_BITS=64' \
	'-DDEBUG' \
	'-D_DEBUG'

# Flags passed to all source files.
CFLAGS_Debug := \
	-Os \
	-gdwarf-2 \
	-mmacosx-version-min=10.5 \
	-arch x86_64 \
	-Wall \
	-Wendif-labels \
	-W \
	-Wno-unused-parameter

# Flags passed to only C files.
CFLAGS_C_Debug := \
	-fno-strict-aliasing

# Flags passed to only C++ files.
CFLAGS_CC_Debug := \
	-fno-rtti \
	-fno-exceptions \
	-fno-threadsafe-statics \
	-fno-strict-aliasing

# Flags passed to only ObjC files.
CFLAGS_OBJC_Debug :=

# Flags passed to only ObjC++ files.
CFLAGS_OBJCC_Debug :=

INCS_Debug := \
	-I/Users/galkahana/.node-gyp/0.8.20/src \
	-I/Users/galkahana/.node-gyp/0.8.20/deps/uv/include \
	-I/Users/galkahana/.node-gyp/0.8.20/deps/v8/include

DEFS_Release := \
	'-D_DARWIN_USE_64_BIT_INODE=1' \
	'-D_LARGEFILE_SOURCE' \
	'-D_FILE_OFFSET_BITS=64'

# Flags passed to all source files.
CFLAGS_Release := \
	-Os \
	-gdwarf-2 \
	-mmacosx-version-min=10.5 \
	-arch x86_64 \
	-Wall \
	-Wendif-labels \
	-W \
	-Wno-unused-parameter

# Flags passed to only C files.
CFLAGS_C_Release := \
	-fno-strict-aliasing

# Flags passed to only C++ files.
CFLAGS_CC_Release := \
	-fno-rtti \
	-fno-exceptions \
	-fno-threadsafe-statics \
	-fno-strict-aliasing

# Flags passed to only ObjC files.
CFLAGS_OBJC_Release :=

# Flags passed to only ObjC++ files.
CFLAGS_OBJCC_Release :=

INCS_Release := \
	-I/Users/galkahana/.node-gyp/0.8.20/src \
	-I/Users/galkahana/.node-gyp/0.8.20/deps/uv/include \
	-I/Users/galkahana/.node-gyp/0.8.20/deps/v8/include

OBJS := \
	$(obj).target/$(TARGET)/../LibJpeg/jaricom.o \
	$(obj).target/$(TARGET)/../LibJpeg/jcapimin.o \
	$(obj).target/$(TARGET)/../LibJpeg/jcapistd.o \
	$(obj).target/$(TARGET)/../LibJpeg/jcarith.o \
	$(obj).target/$(TARGET)/../LibJpeg/jccoefct.o \
	$(obj).target/$(TARGET)/../LibJpeg/jccolor.o \
	$(obj).target/$(TARGET)/../LibJpeg/jcdctmgr.o \
	$(obj).target/$(TARGET)/../LibJpeg/jchuff.o \
	$(obj).target/$(TARGET)/../LibJpeg/jcinit.o \
	$(obj).target/$(TARGET)/../LibJpeg/jcmainct.o \
	$(obj).target/$(TARGET)/../LibJpeg/jcmarker.o \
	$(obj).target/$(TARGET)/../LibJpeg/jcmaster.o \
	$(obj).target/$(TARGET)/../LibJpeg/jcomapi.o \
	$(obj).target/$(TARGET)/../LibJpeg/jcparam.o \
	$(obj).target/$(TARGET)/../LibJpeg/jcprepct.o \
	$(obj).target/$(TARGET)/../LibJpeg/jcsample.o \
	$(obj).target/$(TARGET)/../LibJpeg/jctrans.o \
	$(obj).target/$(TARGET)/../LibJpeg/jdapimin.o \
	$(obj).target/$(TARGET)/../LibJpeg/jdapistd.o \
	$(obj).target/$(TARGET)/../LibJpeg/jdarith.o \
	$(obj).target/$(TARGET)/../LibJpeg/jdatadst.o \
	$(obj).target/$(TARGET)/../LibJpeg/jdatasrc.o \
	$(obj).target/$(TARGET)/../LibJpeg/jdcoefct.o \
	$(obj).target/$(TARGET)/../LibJpeg/jdcolor.o \
	$(obj).target/$(TARGET)/../LibJpeg/jddctmgr.o \
	$(obj).target/$(TARGET)/../LibJpeg/jdhuff.o \
	$(obj).target/$(TARGET)/../LibJpeg/jdinput.o \
	$(obj).target/$(TARGET)/../LibJpeg/jdmainct.o \
	$(obj).target/$(TARGET)/../LibJpeg/jdmarker.o \
	$(obj).target/$(TARGET)/../LibJpeg/jdmaster.o \
	$(obj).target/$(TARGET)/../LibJpeg/jdmerge.o \
	$(obj).target/$(TARGET)/../LibJpeg/jdpostct.o \
	$(obj).target/$(TARGET)/../LibJpeg/jdsample.o \
	$(obj).target/$(TARGET)/../LibJpeg/jdtrans.o \
	$(obj).target/$(TARGET)/../LibJpeg/jerror.o \
	$(obj).target/$(TARGET)/../LibJpeg/jfdctflt.o \
	$(obj).target/$(TARGET)/../LibJpeg/jfdctfst.o \
	$(obj).target/$(TARGET)/../LibJpeg/jfdctint.o \
	$(obj).target/$(TARGET)/../LibJpeg/jidctflt.o \
	$(obj).target/$(TARGET)/../LibJpeg/jidctfst.o \
	$(obj).target/$(TARGET)/../LibJpeg/jidctint.o \
	$(obj).target/$(TARGET)/../LibJpeg/jmemmgr.o \
	$(obj).target/$(TARGET)/../LibJpeg/jmemnobs.o \
	$(obj).target/$(TARGET)/../LibJpeg/jquant1.o \
	$(obj).target/$(TARGET)/../LibJpeg/jquant2.o \
	$(obj).target/$(TARGET)/../LibJpeg/jutils.o

# Add to the list of files we specially track dependencies for.
all_deps += $(OBJS)

# CFLAGS et al overrides must be target-local.
# See "Target-specific Variable Values" in the GNU Make manual.
$(OBJS): TOOLSET := $(TOOLSET)
$(OBJS): GYP_CFLAGS := $(DEFS_$(BUILDTYPE)) $(INCS_$(BUILDTYPE))  $(CFLAGS_$(BUILDTYPE)) $(CFLAGS_C_$(BUILDTYPE))
$(OBJS): GYP_CXXFLAGS := $(DEFS_$(BUILDTYPE)) $(INCS_$(BUILDTYPE))  $(CFLAGS_$(BUILDTYPE)) $(CFLAGS_CC_$(BUILDTYPE))
$(OBJS): GYP_OBJCFLAGS := $(DEFS_$(BUILDTYPE)) $(INCS_$(BUILDTYPE))  $(CFLAGS_$(BUILDTYPE)) $(CFLAGS_C_$(BUILDTYPE)) $(CFLAGS_OBJC_$(BUILDTYPE))
$(OBJS): GYP_OBJCXXFLAGS := $(DEFS_$(BUILDTYPE)) $(INCS_$(BUILDTYPE))  $(CFLAGS_$(BUILDTYPE)) $(CFLAGS_CC_$(BUILDTYPE)) $(CFLAGS_OBJCC_$(BUILDTYPE))

# Suffix rules, putting all outputs into $(obj).

$(obj).$(TOOLSET)/$(TARGET)/%.o: $(srcdir)/%.c FORCE_DO_CMD
	@$(call do_cmd,cc,1)

# Try building from generated source, too.

$(obj).$(TOOLSET)/$(TARGET)/%.o: $(obj).$(TOOLSET)/%.c FORCE_DO_CMD
	@$(call do_cmd,cc,1)

$(obj).$(TOOLSET)/$(TARGET)/%.o: $(obj)/%.c FORCE_DO_CMD
	@$(call do_cmd,cc,1)

# End of this set of suffix rules
### Rules for final target.
