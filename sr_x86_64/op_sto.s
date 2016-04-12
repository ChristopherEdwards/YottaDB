#################################################################
#								#
# Copyright (c) 2007-2015 Fidelity National Information 	#
# Services, Inc. and/or its subsidiaries. All rights reserved.	#
#								#
#	This source code contains the intellectual property	#
#	of its copyright holder(s), and is made available	#
#	under a license.  If you do not know the terms of	#
#	the license, please stop and do not read further.	#
#								#
#################################################################

	.include "g_msf.si"
	.include "linkage.si"
	.include "mval_def.si"
	.include "debug.si"

	.data
	.extern	_literal_null
	.extern	_undef_inhibit

	.text
	.extern	_underr

ENTRY	_op_sto
	subq	$8, %rsp					# Bump stack for 16 byte alignment
	CHKSTKALIGN						# Verify stack alignment
	mv_if_notdefined %r10, notdef
nowdef:
	movl	$mval_byte_len, %ecx
	movq	%r10, %rsi
	movq	%rax, %rdi
	REP
	movsb
	andw	$~mval_m_aliascont, mval_w_mvtype(%rax)	# Don't propagate alias container flag
done:
	addq	$8, %rsp					# Remove stack alignment bump
	ret
notdef:
	cmpb	$0, _undef_inhibit(%rip)
	je	clab
	leaq	_literal_null(%rip), %r10
	jmp	nowdef
clab:
	movq	%r10, %rdi
	movb    $0, %al             			# Variable length argument
	call	_underr
	jmp	done
