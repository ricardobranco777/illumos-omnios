#
# CDDL HEADER START
#
# The contents of this file are subject to the terms of the
# Common Development and Distribution License (the "License").
# You may not use this file except in compliance with the License.
#
# You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
# or http://www.opensolaris.org/os/licensing.
# See the License for the specific language governing permissions
# and limitations under the License.
#
# When distributing Covered Code, include this CDDL HEADER in each
# file and include the License file at usr/src/OPENSOLARIS.LICENSE.
# If applicable, add the following below this CDDL HEADER, with the
# fields enclosed by brackets "[]" replaced with your own identifying
# information: Portions Copyright [yyyy] [name of copyright owner]
#
# CDDL HEADER END
#

#
# Copyright (c) 2004, 2010, Oracle and/or its affiliates. All rights reserved.
# Copyright 2019 Joyent, Inc.
# Copyright (c) 2013, OmniTI Computer Consulting, Inc. All rights reserved.
# Copyright 2013 Garrett D'Amore <garrett@damore.org>
# Copyright 2018 Nexenta Systems, Inc.
# Copyright 2019 OmniOS Community Edition (OmniOSce) Association.
#

LIBCDIR=	$(SRC)/lib/libc
LIB_PIC=	libc_pic.a
VERS=		.1
TARGET_ARCH=	i386

# include comm page definitions
include $(SRC)/lib/commpage/Makefile.shared.com
include $(SRC)/lib/commpage/Makefile.shared.targ

VALUES=		values-Xa.o

# objects are grouped by source directory

# local objects
STRETS=

CRTOBJS=			\
	cerror.o		\
	cerror64.o

DYNOBJS=			\
	_rtbootld.o

FPOBJS=				\
	_D_cplx_div.o		\
	_D_cplx_div_ix.o	\
	_D_cplx_div_rx.o	\
	_D_cplx_lr_div.o	\
	_D_cplx_lr_div_ix.o	\
	_D_cplx_lr_div_rx.o	\
	_D_cplx_mul.o		\
	_F_cplx_div.o		\
	_F_cplx_div_ix.o	\
	_F_cplx_div_rx.o	\
	_F_cplx_lr_div.o	\
	_F_cplx_lr_div_ix.o	\
	_F_cplx_lr_div_rx.o	\
	_F_cplx_mul.o		\
	_X_cplx_div.o		\
	_X_cplx_div_ix.o	\
	_X_cplx_div_rx.o	\
	_X_cplx_lr_div.o	\
	_X_cplx_lr_div_ix.o	\
	_X_cplx_lr_div_rx.o	\
	_X_cplx_mul.o		\
	fpgetmask.o		\
	fpgetround.o		\
	fpgetsticky.o		\
	fpsetmask.o		\
	fpsetround.o		\
	fpsetsticky.o		\
	fpstart.o		\
	ieee.o

FPASMOBJS=			\
	__xgetRD.o		\
	_base_il.o		\
	_xtoll.o		\
	_xtoull.o		\
	fpcw.o

ATOMICOBJS=			\
	atomic.o

CHACHAOBJS=			\
	chacha.o

XATTROBJS=			\
	xattr_common.o

COMOBJS=			\
	bcmp.o			\
	bcopy.o			\
	bsearch.o		\
	bzero.o			\
	explicit_bzero.o	\
	memmem.o		\
	qsort.o			\
	strtol.o		\
	strtoul.o		\
	strtoll.o		\
	strtoull.o

DTRACEOBJS=			\
	dtrace_data.o

SECFLAGSOBJS=			\
	secflags.o

GENOBJS=			\
	$(COMMPAGE_OBJS)	\
	_div64.o		\
	_divdi3.o		\
	_getsp.o		\
	_mul64.o		\
	abs.o			\
	alloca.o		\
	arc4random.o		\
	arc4random_uniform.o	\
	byteorder.o		\
	byteorder64.o		\
	cuexit.o		\
	ecvt.o			\
	endian.o		\
	errlst.o		\
	i386_data.o		\
	ladd.o			\
	ldivide.o		\
	lmul.o			\
	lock.o			\
	lshiftl.o		\
	lsign.o			\
	lsub.o			\
	makectxt.o		\
	memccpy.o		\
	memchr.o		\
	memcmp.o		\
	memcpy.o		\
	memset.o		\
	new_list.o		\
	setjmp.o		\
	siginfolst.o		\
	siglongjmp.o		\
	strcat.o		\
	strchr.o		\
	strcmp.o		\
	strcpy.o		\
	strlen.o		\
	strncat.o		\
	strncmp.o		\
	strncpy.o		\
	strnlen.o		\
	strrchr.o		\
	sync_instruction_memory.o

# sysobjs that contain large-file interfaces
COMSYSOBJS64=			\
	fstatvfs64.o		\
	getdents64.o		\
	getrlimit64.o		\
	lseek64.o		\
	mmap64.o		\
	pread64.o		\
	preadv64.o		\
	pwrite64.o		\
	pwritev64.o		\
	setrlimit64.o		\
	statvfs64.o

SYSOBJS64=

COMSYSOBJS=			\
	__clock_timer.o		\
	__getloadavg.o		\
	__rusagesys.o		\
	__signotify.o		\
	__sigrt.o		\
	__time.o		\
	_lgrp_home_fast.o	\
	_lgrpsys.o		\
	_nfssys.o		\
	_portfs.o		\
	_pset.o			\
	_rpcsys.o		\
	_sigaction.o		\
	_so_accept.o		\
	_so_bind.o		\
	_so_connect.o		\
	_so_getpeername.o	\
	_so_getsockname.o	\
	_so_getsockopt.o	\
	_so_listen.o		\
	_so_recv.o		\
	_so_recvfrom.o		\
	_so_recvmsg.o		\
	_so_send.o		\
	_so_sendmsg.o		\
	_so_sendto.o		\
	_so_setsockopt.o	\
	_so_shutdown.o		\
	_so_socket.o		\
	_so_socketpair.o	\
	_sockconfig.o		\
	acct.o			\
	acl.o			\
	adjtime.o		\
	alarm.o			\
	brk.o			\
	chdir.o			\
	chroot.o		\
	cladm.o			\
	close.o			\
	execve.o		\
	exit.o			\
	facl.o			\
	fchdir.o		\
	fchroot.o		\
	fdsync.o		\
	fpathconf.o		\
	fstatfs.o		\
	fstatvfs.o		\
	getcpuid.o		\
	getdents.o		\
	getegid.o		\
	geteuid.o		\
	getgid.o		\
	getgroups.o		\
	gethrtime.o		\
	getitimer.o		\
	getmsg.o		\
	getpid.o		\
	getpmsg.o		\
	getppid.o		\
	getrandom.o		\
	getrlimit.o		\
	getuid.o		\
	gtty.o			\
	install_utrap.o		\
	ioctl.o			\
	kaio.o			\
	kill.o			\
	llseek.o		\
	lseek.o			\
	mmapobjsys.o		\
	memcntl.o		\
	mincore.o		\
	mmap.o			\
	modctl.o		\
	mount.o			\
	mprotect.o		\
	munmap.o		\
	nice.o			\
	ntp_adjtime.o		\
	ntp_gettime.o		\
	p_online.o		\
	pathconf.o		\
	pause.o			\
	pcsample.o		\
	pipe2.o			\
	pollsys.o		\
	pread.o			\
	preadv.o		\
	priocntlset.o		\
	processor_bind.o	\
	processor_info.o	\
	profil.o		\
	psecflagsset.o		\
	putmsg.o		\
	putpmsg.o		\
	pwrite.o		\
	pwritev.o		\
	read.o			\
	readv.o			\
	resolvepath.o		\
	seteguid.o		\
	setgid.o		\
	setgroups.o		\
	setitimer.o		\
	setreid.o		\
	setrlimit.o		\
	setuid.o		\
	sigaltstk.o		\
	sigprocmsk.o		\
	sigsendset.o		\
	sigsuspend.o		\
	statfs.o		\
	statvfs.o		\
	stty.o			\
	sync.o			\
	sysconfig.o		\
	sysfs.o			\
	sysinfo.o		\
	syslwp.o		\
	times.o			\
	ulimit.o		\
	umask.o			\
	umount2.o		\
	upanic.o		\
	utssys.o		\
	uucopy.o		\
	vhangup.o		\
	waitid.o		\
	write.o			\
	writev.o		\
	yield.o

SYSOBJS=			\
	__clock_gettime.o	\
	__clock_gettime_sys.o	\
	__getcontext.o		\
	__uadmin.o		\
	_lwp_mutex_unlock.o	\
	_stack_grow.o		\
	door.o			\
	forkx.o			\
	forkallx.o		\
	getcontext.o		\
	gettimeofday.o		\
	lwp_private.o		\
	nuname.o		\
	ptrace.o		\
	syscall.o		\
	sysi86.o		\
	tls_get_addr.o		\
	uadmin.o		\
	umount.o		\
	uname.o			\
	vforkx.o		\
	xstat.o

# objects under $(LIBCDIR)/port which contain transitional large file interfaces
PORTGEN64=			\
	_xftw64.o		\
	attropen64.o		\
	fts64.o			\
	ftw64.o			\
	mkstemp64.o		\
	nftw64.o		\
	tell64.o		\
	truncate64.o

# objects from source under $(LIBCDIR)/port
PORTFP=				\
	__flt_decim.o		\
	__flt_rounds.o		\
	__tbl_10_b.o		\
	__tbl_10_h.o		\
	__tbl_10_s.o		\
	__tbl_2_b.o		\
	__tbl_2_h.o		\
	__tbl_2_s.o		\
	__tbl_fdq.o		\
	__tbl_tens.o		\
	__x_power.o		\
	_base_sup.o		\
	aconvert.o		\
	decimal_bin.o		\
	double_decim.o		\
	econvert.o		\
	fconvert.o		\
	file_decim.o		\
	finite.o		\
	fp_data.o		\
	func_decim.o		\
	gconvert.o		\
	hex_bin.o		\
	ieee_globals.o		\
	pack_float.o		\
	sigfpe.o		\
	string_decim.o

PORTGEN=			\
	_env_data.o		\
	_xftw.o			\
	a64l.o			\
	abort.o			\
	addsev.o		\
	ascii_strcasecmp.o	\
	ascii_strncasecmp.o	\
	assert.o		\
	atexit.o		\
	atfork.o		\
	atof.o			\
	atoi.o			\
	atol.o			\
	atoll.o			\
	attrat.o		\
	attropen.o		\
	basename.o		\
	calloc.o		\
	catgets.o		\
	catopen.o		\
	cfgetispeed.o		\
	cfgetospeed.o		\
	cfree.o			\
	cfsetispeed.o		\
	cfsetospeed.o		\
	cftime.o		\
	clock.o			\
	closedir.o		\
	closefrom.o		\
	confstr.o		\
	crypt.o			\
	csetlen.o		\
	ctime.o			\
	ctime_r.o		\
	daemon.o		\
	deflt.o			\
	directio.o		\
	dirname.o		\
	div.o			\
	drand48.o		\
	dup.o			\
	env_data.o		\
	err.o			\
	errno.o			\
	euclen.o		\
	event_port.o		\
	execvp.o		\
	fattach.o		\
	fdetach.o		\
	fdopendir.o		\
	ffs.o			\
	flock.o			\
	fls.o			\
	fmtmsg.o		\
	freezero.o		\
	ftime.o			\
	ftok.o			\
	fts.o			\
	ftw.o			\
	gcvt.o			\
	get_nprocs.o		\
	getauxv.o		\
	getcwd.o		\
	getdate_err.o		\
	getdtblsize.o		\
	getentropy.o		\
	getenv.o		\
	getexecname.o		\
	getgrnam.o		\
	getgrnam_r.o		\
	gethostid.o		\
	gethostname.o		\
	gethz.o			\
	getisax.o		\
	getloadavg.o		\
	getlogin.o		\
	getmntent.o		\
	getnetgrent.o		\
	getopt.o		\
	getopt_long.o		\
	getpagesize.o		\
	getpw.o			\
	getpwnam.o		\
	getpwnam_r.o		\
	getrusage.o		\
	getspent.o		\
	getspent_r.o		\
	getsubopt.o		\
	gettxt.o		\
	getusershell.o		\
	getut.o			\
	getutx.o		\
	getvfsent.o		\
	getwd.o			\
	getwidth.o		\
	getxby_door.o		\
	gtxt.o			\
	hsearch.o		\
	iconv.o			\
	imaxabs.o		\
	imaxdiv.o		\
	index.o			\
	initgroups.o		\
	insque.o		\
	isaexec.o		\
	isastream.o		\
	isatty.o		\
	killpg.o		\
	klpdlib.o		\
	l64a.o			\
	lckpwdf.o		\
	lconstants.o		\
	lexp10.o		\
	lfind.o			\
	lfmt.o			\
	lfmt_log.o		\
	llabs.o			\
	lldiv.o			\
	llog10.o		\
	lltostr.o		\
	localtime.o		\
	lsearch.o		\
	madvise.o		\
	malloc.o		\
	memalign.o		\
	memrchr.o		\
	memset_s.o		\
	mkdev.o			\
	mkdtemp.o		\
	mkfifo.o		\
	mkstemp.o		\
	mktemp.o		\
	mlock.o			\
	mlockall.o		\
	mon.o			\
	msync.o			\
	munlock.o		\
	munlockall.o		\
	ndbm.o			\
	nftw.o			\
	nlspath_checks.o	\
	nsparse.o		\
	nss_common.o		\
	nss_dbdefs.o		\
	nss_deffinder.o		\
	opendir.o		\
	opt_data.o		\
	perror.o		\
	pfmt.o			\
	pfmt_data.o		\
	pfmt_print.o		\
	pipe.o			\
	plock.o			\
	poll.o			\
	posix_fadvise.o		\
	posix_fallocate.o	\
	posix_madvise.o		\
	posix_memalign.o	\
	priocntl.o		\
	priv_str_xlate.o	\
	privlib.o		\
	psecflags.o		\
	psiginfo.o		\
	psignal.o		\
	pt.o			\
	putpwent.o		\
	putspent.o		\
	raise.o			\
	rand.o			\
	random.o		\
	rctlops.o		\
	readdir.o		\
	readdir_r.o		\
	reallocarray.o		\
	reallocf.o		\
	recallocarray.o		\
	realpath.o		\
	reboot.o		\
	regexpr.o		\
	remove.o		\
	rewinddir.o		\
	rindex.o		\
	scandir.o		\
	seekdir.o		\
	select.o		\
	set_constraint_handler_s.o \
	setlabel.o		\
	setpriority.o		\
	settimeofday.o		\
	sh_locks.o		\
	sigflag.o		\
	siglist.o		\
	sigsend.o		\
	sigsetops.o		\
	ssignal.o		\
	ssp.o			\
	stack.o			\
	stpcpy.o		\
	stpncpy.o		\
	str2sig.o		\
	strcase_charmap.o	\
	strchrnul.o		\
	strcspn.o		\
	strdup.o		\
	strerror.o		\
	strlcat.o		\
	strlcpy.o		\
	strndup.o		\
	strpbrk.o		\
	strsep.o		\
	strsignal.o		\
	strspn.o		\
	strstr.o		\
	strtod.o		\
	strtoimax.o		\
	strtok.o		\
	strtok_r.o		\
	strtonum.o		\
	strtoumax.o		\
	swab.o			\
	swapctl.o		\
	sysconf.o		\
	syslog.o		\
	tcdrain.o		\
	tcflow.o		\
	tcflush.o		\
	tcgetattr.o		\
	tcgetpgrp.o		\
	tcgetsid.o		\
	tcsendbreak.o		\
	tcsetattr.o		\
	tcsetpgrp.o		\
	tell.o			\
	telldir.o		\
	tfind.o			\
	time_data.o		\
	time_gdata.o		\
	timespec_get.o		\
	tls_data.o		\
	truncate.o		\
	tsdalloc.o		\
	tsearch.o		\
	ttyname.o		\
	ttyslot.o		\
	ualarm.o		\
	ucred.o			\
	valloc.o		\
	vlfmt.o			\
	vpfmt.o			\
	waitpid.o		\
	walkstack.o		\
	wdata.o			\
	xgetwidth.o		\
	xpg4.o			\
	xpg6.o

PORTINET=			\
	inet_lnaof.o		\
	inet_makeaddr.o		\
	inet_network.o		\
	inet_ntoa.o		\
	inet_ntop.o		\
	inet_pton.o

PORTPRINT_W=			\
	doprnt_w.o

PORTPRINT=			\
	asprintf.o		\
	doprnt.o		\
	fprintf.o		\
	printf.o		\
	snprintf.o		\
	sprintf.o		\
	vfprintf.o		\
	vprintf.o		\
	vsnprintf.o		\
	vsprintf.o		\
	vwprintf.o		\
	wprintf.o

# c89 variants to support 32-bit size of c89 u/intmax_t (32-bit libc only)
PORTPRINT_C89=			\
	vfprintf_c89.o		\
	vprintf_c89.o		\
	vsnprintf_c89.o		\
	vsprintf_c89.o		\
	vwprintf_c89.o

PORTSTDIO_C89=			\
	vscanf_c89.o		\
	vwscanf_c89.o		\

# portable stdio objects that contain large file interfaces.
# Note: fopen64 is a special case, as we build it small.
PORTSTDIO64=			\
	fopen64.o		\
	fpos64.o

PORTSTDIO_W=			\
	doscan_w.o

PORTSTDIO=			\
	__extensions.o		\
	_endopen.o		\
	_filbuf.o		\
	_findbuf.o		\
	_flsbuf.o		\
	_stdio_flags.o		\
	_wrtchk.o		\
	clearerr.o		\
	ctermid.o		\
	ctermid_r.o		\
	cuserid.o		\
	data.o			\
	doscan.o		\
	fdopen.o		\
	feof.o			\
	ferror.o		\
	fgetc.o			\
	fgets.o			\
	fileno.o		\
	flockf.o		\
	flush.o			\
	fmemopen.o		\
	fopen.o			\
	fpos.o			\
	fputc.o			\
	fputs.o			\
	fread.o			\
	fseek.o			\
	fseeko.o		\
	ftell.o			\
	ftello.o		\
	fwrite.o		\
	getc.o			\
	getchar.o		\
	getline.o		\
	getpass.o		\
	gets.o			\
	getw.o			\
	mse.o			\
	open_memstream.o	\
	open_wmemstream.o	\
	popen.o			\
	putc.o			\
	putchar.o		\
	puts.o			\
	putw.o			\
	rewind.o		\
	scanf.o			\
	setbuf.o		\
	setbuffer.o		\
	setvbuf.o		\
	system.o		\
	tempnam.o		\
	tmpfile.o		\
	tmpnam_r.o		\
	ungetc.o		\
	vscanf.o		\
	vwscanf.o		\
	wscanf.o

PORTI18N=			\
	getwchar.o		\
	putwchar.o		\
	putws.o			\
	strtows.o		\
	wcsnlen.o		\
	wcsstr.o		\
	wcstoimax.o		\
	wcstol.o		\
	wcstoul.o		\
	wcswcs.o		\
	wmemchr.o		\
	wmemcmp.o		\
	wmemcpy.o		\
	wmemmove.o		\
	wmemset.o		\
	wscat.o			\
	wschr.o			\
	wscmp.o			\
	wscpy.o			\
	wscspn.o		\
	wsdup.o			\
	wslen.o			\
	wsncat.o		\
	wsncmp.o		\
	wsncpy.o		\
	wspbrk.o		\
	wsprintf.o		\
	wsrchr.o		\
	wsscanf.o		\
	wsspn.o			\
	wstod.o			\
	wstok.o			\
	wstol.o			\
	wstoll.o		\
	wsxfrm.o		\
	gettext.o		\
	gettext_gnu.o		\
	gettext_real.o		\
	gettext_util.o		\
	plural_parser.o		\
	wdresolve.o		\
	_ctype.o		\
	isascii.o		\
	toascii.o

PORTI18N_COND=			\
	wcstol_longlong.o	\
	wcstoul_longlong.o

PORTLOCALE=			\
	big5.o			\
	btowc.o			\
	c16rtomb.o		\
	c32rtomb.o		\
	collate.o		\
	collcmp.o		\
	euc.o			\
	fnmatch.o		\
	fgetwc.o		\
	fgetws.o		\
	fix_grouping.o		\
	fputwc.o		\
	fputws.o		\
	fwide.o			\
	gb18030.o		\
	gb2312.o		\
	gbk.o			\
	getdate.o		\
	isdigit.o		\
	iswctype.o		\
	ldpart.o		\
	lmessages.o		\
	lnumeric.o		\
	lmonetary.o		\
	localeconv.o		\
	localeimpl.o		\
	mbftowc.o		\
	mblen.o			\
	mbrlen.o		\
	mbrtoc16.o		\
	mbrtoc32.o		\
	mbrtowc.o		\
	mbsinit.o		\
	mbsnrtowcs.o		\
	mbsrtowcs.o		\
	mbstowcs.o		\
	mbtowc.o		\
	mskanji.o		\
	nextwctype.o		\
	nl_langinfo.o		\
	none.o			\
	rune.o			\
	runetype.o		\
	setlocale.o		\
	setrunelocale.o		\
	strcasecmp.o		\
	strcasestr.o		\
	strcoll.o		\
	strfmon.o		\
	strftime.o		\
	strncasecmp.o		\
	strptime.o		\
	strxfrm.o		\
	table.o			\
	timelocal.o		\
	tolower.o		\
	towlower.o		\
	ungetwc.o		\
	utf8.o			\
	wcrtomb.o		\
	wcscasecmp.o		\
	wcscoll.o		\
	wcsftime.o		\
	wcsnrtombs.o		\
	wcsrtombs.o		\
	wcswidth.o		\
	wcstombs.o		\
	wcsxfrm.o		\
	wctob.o			\
	wctomb.o		\
	wctrans.o		\
	wctype.o		\
	wcwidth.o		\
	wscol.o

AIOOBJS=			\
	aio.o			\
	aio_alloc.o		\
	posix_aio.o

RTOBJS=				\
	clock_timer.o		\
	mqueue.o		\
	pos4obj.o		\
	sched.o			\
	sem.o			\
	shm.o			\
	sigev_thread.o

TPOOLOBJS=			\
	thread_pool.o

THREADSOBJS=			\
	alloc.o			\
	assfail.o		\
	cancel.o		\
	c11_thr.o		\
	door_calls.o		\
	tmem.o			\
	pthr_attr.o		\
	pthr_barrier.o		\
	pthr_cond.o		\
	pthr_mutex.o		\
	pthr_rwlock.o		\
	pthread.o		\
	rwlock.o		\
	scalls.o		\
	sema.o			\
	sigaction.o		\
	spawn.o			\
	synch.o			\
	tdb_agent.o		\
	thr.o			\
	thread_interface.o	\
	tls.o			\
	tsd.o

THREADSMACHOBJS=		\
	machdep.o

THREADSASMOBJS=			\
	asm_subr.o

UNICODEOBJS=			\
	u8_textprep.o		\
	uconv.o

UNWINDMACHOBJS=			\
	unwind.o

UNWINDASMOBJS=			\
	unwind_frame.o

# objects that implement the transitional large file API
PORTSYS64=			\
	lockf64.o		\
	stat64.o

PORTSYS=			\
	_autofssys.o		\
	access.o		\
	acctctl.o		\
	bsd_signal.o		\
	chmod.o			\
	chown.o			\
	corectl.o		\
	epoll.o			\
	eventfd.o		\
	exacctsys.o		\
	execl.o			\
	execle.o		\
	execv.o			\
	fcntl.o			\
	getpagesizes.o		\
	getpeerucred.o		\
	inotify.o		\
	inst_sync.o		\
	issetugid.o		\
	label.o			\
	link.o			\
	lockf.o			\
	lwp.o			\
	lwp_cond.o		\
	lwp_rwlock.o		\
	lwp_sigmask.o		\
	meminfosys.o		\
	mkdir.o			\
	mknod.o			\
	msgsys.o		\
	nfssys.o		\
	open.o			\
	pgrpsys.o		\
	posix_sigwait.o		\
	ppriv.o			\
	psetsys.o		\
	rctlsys.o		\
	readlink.o		\
	rename.o		\
	sbrk.o			\
	semsys.o		\
	set_errno.o		\
	sharefs.o		\
	shmsys.o		\
	sidsys.o		\
	siginterrupt.o		\
	signal.o		\
	signalfd.o		\
	sigpending.o		\
	sigstack.o		\
	stat.o			\
	symlink.o		\
	tasksys.o		\
	time.o			\
	time_util.o		\
	timerfd.o		\
	ucontext.o		\
	unlink.o		\
	ustat.o			\
	utimesys.o		\
	zone.o

PORTREGEX=			\
	glob.o			\
	regcmp.o		\
	regcomp.o		\
	regerror.o		\
	regex.o			\
	regexec.o		\
	regfree.o		\
	wordexp.o

PORTREGEX64=			\
	glob64.o

MOSTOBJS=			\
	$(STRETS)		\
	$(CRTOBJS)		\
	$(DYNOBJS)		\
	$(FPOBJS)		\
	$(FPASMOBJS)		\
	$(ATOMICOBJS)		\
	$(CHACHAOBJS)		\
	$(XATTROBJS)		\
	$(COMOBJS)		\
	$(DTRACEOBJS)		\
	$(GENOBJS)		\
	$(PORTFP)		\
	$(PORTGEN)		\
	$(PORTGEN64)		\
	$(PORTI18N)		\
	$(PORTI18N_COND)	\
	$(PORTINET)		\
	$(PORTLOCALE)		\
	$(PORTPRINT)		\
	$(PORTPRINT_C89)	\
	$(PORTPRINT_W)		\
	$(PORTREGEX)		\
	$(PORTREGEX64)		\
	$(PORTSTDIO)		\
	$(PORTSTDIO64)		\
	$(PORTSTDIO_C89)	\
	$(PORTSTDIO_W)		\
	$(PORTSYS)		\
	$(PORTSYS64)		\
	$(AIOOBJS)		\
	$(RTOBJS)		\
	$(SECFLAGSOBJS)		\
	$(TPOOLOBJS)		\
	$(THREADSOBJS)		\
	$(THREADSMACHOBJS)	\
	$(THREADSASMOBJS)	\
	$(UNICODEOBJS)		\
	$(UNWINDMACHOBJS)	\
	$(UNWINDASMOBJS)	\
	$(COMSYSOBJS)		\
	$(SYSOBJS)		\
	$(COMSYSOBJS64)		\
	$(SYSOBJS64)		\
	$(VALUES)

TRACEOBJS=			\
	plockstat.o

# NOTE:	libc.so.1 must be linked with the minimal crti.o and crtn.o
# modules whose source is provided in the $(SRC)/lib/crt directory.
# This must be done because otherwise the Sun C compiler would insert
# its own versions of these modules and those versions contain code
# to call out to C++ initialization functions.  Such C++ initialization
# functions can call back into libc before thread initialization is
# complete and this leads to segmentation violations and other problems.
# Since libc contains no C++ code, linking with the minimal crti.o and
# crtn.o modules is safe and avoids the problems described above.
OBJECTS= $(CRTI) $(MOSTOBJS) $(CRTN)
CRTSRCS= ../../crt/i386

LDPASS_OFF=	$(POUND_SIGN)

# include common library definitions
include ../../Makefile.lib

# we need to override the default SONAME here because we might
# be building a variant object (still libc.so.1, but different filename)
SONAME = libc.so.1

CFLAGS += $(CCVERBOSE) $(CTF_FLAGS)

# This is necessary to avoid problems with calling _ex_unwind().
# We probably don't want any inlining anyway.
XINLINE = -xinline=
CFLAGS += $(XINLINE)

CERRWARN += -_gcc=-Wno-parentheses
CERRWARN += -_gcc=-Wno-switch
CERRWARN += $(CNOWARN_UNINIT)
CERRWARN += -_gcc=-Wno-unused-value
CERRWARN += -_gcc=-Wno-unused-label
CERRWARN += -_gcc=-Wno-unused-variable
CERRWARN += -_gcc=-Wno-type-limits
CERRWARN += -_gcc=-Wno-char-subscripts
CERRWARN += -_gcc=-Wno-clobbered
CERRWARN += -_gcc=-Wno-unused-function
CERRWARN += -_gcc=-Wno-address

$(RELEASE_BUILD)CERRWARN += -_gcc=-Wno-unused

# not linted
SMATCH=off

# Setting THREAD_DEBUG = -DTHREAD_DEBUG (make THREAD_DEBUG=-DTHREAD_DEBUG ...)
# enables ASSERT() checking in the threads portion of the library.
# This is automatically enabled for DEBUG builds, not for non-debug builds.
THREAD_DEBUG =
$(NOT_RELEASE_BUILD)THREAD_DEBUG = -DTHREAD_DEBUG

# Make string literals read-only to save memory.
CFLAGS += $(XSTRCONST)

ALTPICS= $(TRACEOBJS:%=pics/%)

$(DYNLIB) := BUILD.SO = $(LD) -o $@ $(GSHARED) $(DYNFLAGS) $(PICS) $(ALTPICS) \
		$(EXTPICS) $(LDLIBS)

MAPFILES =	$(LIBCDIR)/port/mapfile-vers

#
# EXTN_CPPFLAGS and EXTN_CFLAGS set in enclosing Makefile
#
CFLAGS +=	$(EXTN_CFLAGS)
CPPFLAGS=	-D_REENTRANT -Di386 $(EXTN_CPPFLAGS) $(THREAD_DEBUG) \
		-I$(LIBCBASE)/inc -I$(LIBCDIR)/inc $(CPPFLAGS.master)
ASFLAGS=	$(AS_PICFLAGS) -P -D__STDC__ -D_ASM $(CPPFLAGS) $(i386_AS_XARCH)

# As a favor to the dtrace syscall provider, libc still calls the
# old syscall traps that have been obsoleted by the *at() interfaces.
# Delete this to compile libc using only the new *at() system call traps
CPPFLAGS += -D_RETAIN_OLD_SYSCALLS

# Inform the run-time linker about libc specialized initialization
RTLDINFO =	-z rtldinfo=tls_rtldinfo
DYNFLAGS +=	$(RTLDINFO)

# Force libc's internal references to be resolved immediately upon loading
# in order to avoid critical region problems.  Since almost all libc symbols
# are marked 'protected' in the mapfiles, this is a minimal set (15 to 20).
DYNFLAGS +=	-znow

DYNFLAGS +=	-e __rtboot
DYNFLAGS +=	$(EXTN_DYNFLAGS)

# Inform the kernel about the initial DTrace area (in case
# libc is being used as the interpreter / runtime linker).
DTRACE_DATA =	-zdtrace=dtrace_data
DYNFLAGS +=	$(DTRACE_DATA)

# DTrace needs an executable data segment.
MAPFILE.NED=

BUILD.s=	$(AS) $(ASFLAGS) $< -o $@

# Override this top level flag so the compiler builds in its native
# C99 mode.  This has been enabled to support the complex arithmetic
# added to libc.
CSTD=	$(CSTD_GNU99)

# libc method of building an archive
# The "$(GREP) -v ' L '" part is necessary only until
# lorder is fixed to ignore thread-local variables.
BUILD.AR= $(RM) $@ ; \
	$(AR) q $@ `$(LORDER) $(MOSTOBJS:%=$(DIR)/%) | $(GREP) -v ' L ' | $(TSORT)`

# extra files for the clean target
CLEANFILES +=			\
	$(LIBCDIR)/port/gen/errlst.c	\
	$(LIBCDIR)/port/gen/new_list.c	\
	assym.h			\
	genassym		\
	crt/_rtld.s		\
	crt/_rtbootld.s		\
	pics/_rtbootld.o	\
	pics/crti.o		\
	pics/crtn.o		\
	$(ALTPICS)

CLOBBERFILES +=	$(LIB_PIC)

# conditional assignments
$(DYNLIB) := CRTI = crti.o
$(DYNLIB) := CRTN = crtn.o

# pics/mul64.o := CFLAGS += $(LIBCBASE)/crt/mul64.il

# large-file-aware components that should be built large

$(COMSYSOBJS64:%=pics/%) := \
	CPPFLAGS += -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64

$(SYSOBJS64:%=pics/%) := \
	CPPFLAGS += -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64

$(PORTGEN64:%=pics/%) := \
	CPPFLAGS += -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64

$(PORTREGEX64:%=pics/%) := \
	CPPFLAGS += -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64

$(PORTSTDIO64:%=pics/%) := \
	CPPFLAGS += -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64

$(PORTSYS64:%=pics/%) := \
	CPPFLAGS += -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64

$(PORTSTDIO_W:%=pics/%) := \
	CPPFLAGS += -D_WIDE

$(PORTPRINT_W:%=pics/%) := \
	CPPFLAGS += -D_WIDE

$(PORTPRINT_C89:%=pics/%) := \
	CPPFLAGS += -D_C89_INTMAX32

$(PORTSTDIO_C89:%=pics/%) := \
	CPPFLAGS += -D_C89_INTMAX32

$(PORTI18N_COND:%=pics/%) := \
	CPPFLAGS += -D_WCS_LONGLONG

pics/arc4random.o :=	CPPFLAGS += -I$(SRC)/common/crypto/chacha

pics/__clock_gettime.o := CPPFLAGS += $(COMMPAGE_CPPFLAGS)
pics/gettimeofday.o := CPPFLAGS += $(COMMPAGE_CPPFLAGS)

#
# Disable the stack protector due to issues with bootstrapping rtld. See
# cmd/sgs/rtld/Makefile.com for more information.
#
STACKPROTECT = none

.KEEP_STATE:

all: $(LIBS) $(LIB_PIC)

# include common libc targets
include $(LIBCDIR)/Makefile.targ

# We need to strip out all CTF and DOF data from the static library
$(LIB_PIC) := DIR = pics
$(LIB_PIC): pics $$(PICS)
	$(BUILD.AR)
	$(MCS) -d -n .SUNW_ctf $@ > /dev/null 2>&1
	$(MCS) -d -n .SUNW_dof $@ > /dev/null 2>&1
	$(AR) -ts $@ > /dev/null
	$(POST_PROCESS_A)

$(LIBCBASE)/crt/_rtbootld.s: $(LIBCBASE)/crt/_rtboot.s $(LIBCBASE)/crt/_rtld.c
	$(CC) $($(MACH)_XARCH) $(CPPFLAGS) -_smatch=off $(CTF_FLAGS) -O -S \
	    $(C_PICFLAGS) $(LIBCBASE)/crt/_rtld.c -o $(LIBCBASE)/crt/_rtld.s
	$(CAT) $(LIBCBASE)/crt/_rtboot.s $(LIBCBASE)/crt/_rtld.s > $@
	$(RM) $(LIBCBASE)/crt/_rtld.s

# partially built from C source
pics/_rtbootld.o: $(LIBCBASE)/crt/_rtbootld.s
	$(AS) $(ASFLAGS) $(LIBCBASE)/crt/_rtbootld.s -o $@
	$(CTFCONVERT_O)

ASSYMDEP_OBJS=			\
	_lwp_mutex_unlock.o	\
	_stack_grow.o		\
	getcontext.o		\
	setjmp.o		\
	tls_get_addr.o		\
	vforkx.o

$(ASSYMDEP_OBJS:%=pics/%)	:=	CPPFLAGS += -I.

$(ASSYMDEP_OBJS:%=pics/%): assym.h

# assym.h build rules

GENASSYM_C = $(LIBCDIR)/$(MACH)/genassym.c
LDFLAGS.native = $(LDASSERTS) $(BDIRECT)

genassym := NATIVE_LIBS += libc.so

genassym: $(GENASSYM_C)
	$(NATIVECC) $(NATIVE_CFLAGS) -I$(LIBCBASE)/inc -I$(LIBCDIR)/inc	\
		-D__EXTENSIONS__ $(CPPFLAGS.native) $(LDFLAGS.native) \
		-o $@ $(GENASSYM_C)

OFFSETS = $(LIBCDIR)/$(MACH)/offsets.in

assym.h: $(OFFSETS) genassym
	$(OFFSETS_CREATE) <$(OFFSETS) >$@
	./genassym >>$@

# derived C source and related explicit dependencies
$(LIBCDIR)/port/gen/errlst.c + \
$(LIBCDIR)/port/gen/new_list.c: $(LIBCDIR)/port/gen/errlist $(LIBCDIR)/port/gen/errlist.awk
	cd $(LIBCDIR)/port/gen; pwd; $(AWK) -f errlist.awk < errlist

pics/errlst.o: $(LIBCDIR)/port/gen/errlst.c

pics/new_list.o: $(LIBCDIR)/port/gen/new_list.c
