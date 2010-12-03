Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from e38.co.us.ibm.com ([32.97.110.159]:59917 "EHLO
	e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146Ab0LCTvP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 3 Dec 2010 14:51:15 -0500
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com [9.17.195.107])
	by e38.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id oB3Kgng7009836
	for <linux-watchdog@vger.kernel.org>; Fri, 3 Dec 2010 13:42:49 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id oB3JpDrZ157446
	for <linux-watchdog@vger.kernel.org>; Fri, 3 Dec 2010 12:51:13 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id oB3JpBDu032287
	for <linux-watchdog@vger.kernel.org>; Fri, 3 Dec 2010 12:51:13 -0700
Date: Fri, 3 Dec 2010 14:50:23 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Timur Tabi <timur@freescale.com>
Cc: linux-watchdog@vger.kernel.org, kumar.gala@freescale.com,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] watchdog: add CONFIG_WATCHDOG_NOWAYOUT support to
 PowerPC Book-E watchdog driver
Message-ID: <20101203195023.GD1903@zod.rchland.ibm.com>
References: <1291395103-12394-1-git-send-email-timur@freescale.com>
 <20101203180751.GA1903@zod.rchland.ibm.com>
 <4CF93566.1050601@freescale.com>
 <20101203190556.GB1903@zod.rchland.ibm.com>
 <4CF9408A.4030506@freescale.com>
 <20101203193900.GC1903@zod.rchland.ibm.com>
 <4CF94869.4020705@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4CF94869.4020705@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Dec 03, 2010 at 01:43:37PM -0600, Timur Tabi wrote:
>Josh Boyer wrote:
>> Just the moving of the clear_bit inside the #ifndef
>> CONFIG_WATCHDOG_NOWAYOUT.
>
>If I move the clear_bit() call inside the #ifndef, then when
>CONFIG_WATCHDOG_NOWAYOUT is defined, after a process closes /dev/watchdog, no
>process will ever be able to open it again.  Are you saying that once
>wd_keepalive exits, you don't want anyone to be able to open /dev/watchdog and
>ping the timer again?

Oh, good point.  No, I don't think we want that.  So in that case:

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

and sorry for the hassle.

josh
