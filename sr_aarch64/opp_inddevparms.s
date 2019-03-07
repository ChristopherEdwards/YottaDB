#################################################################
#								#
# Copyright (c) 2018 YottaDB LLC and/or its subsidiaries.	#
# All rights reserved.						#
#								#
# Copyright (c) 2018 Stephen L Johnson. All rights reserved.	#
#								#
#	This source code contains the intellectual property	#
#	of its copyright holder(s), and is made available	#
#	under a license.  If you do not know the terms of	#
#	the license, please stop and do not read further.	#
#								#
#################################################################

/* opp_inddevparms.s */

/*
 * void	op_inddevparms(mval *devpsrc, int4 ok_iop_parms,  mval *devpiopl)
 */

	.include "linkage.si"
	.include "g_msf.si"
#	include "debug.si"

	.data
	.extern frame_pointer

	.text
	.extern	op_inddevparms

ENTRY opp_inddevparms
	putframe
	CHKSTKALIGN					/* Verify stack alignment */
	bl	op_inddevparms
	getframe
	ret
