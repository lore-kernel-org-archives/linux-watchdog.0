Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]:18195
	"EHLO VA3EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751195Ab0LCTKK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 3 Dec 2010 14:10:10 -0500
Received: from mail46-va3 (localhost.localdomain [127.0.0.1])	by
 mail46-va3-R.bigfish.com (Postfix) with ESMTP id 786271605BF	for
 <linux-watchdog@vger.kernel.org>; Fri,  3 Dec 2010 19:10:08 +0000 (UTC)
Received: from VA3EHSMHS036.bigfish.com (unknown [10.7.14.239])	by
 mail46-va3.bigfish.com (Postfix) with ESMTP id 31ACF15D804E	for
 <linux-watchdog@vger.kernel.org>; Fri,  3 Dec 2010 19:10:08 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id oB3JC6aY000672	for
 <linux-watchdog@vger.kernel.org>; Fri, 3 Dec 2010 12:12:06 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
 [10.64.32.16])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
 oB3JQuTF023507	for <linux-watchdog@vger.kernel.org>; Fri, 3 Dec 2010 13:26:56
 -0600 (CST)
Message-ID: <4CF9408A.4030506@freescale.com>
Date: Fri, 3 Dec 2010 13:10:02 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
CC: <linux-watchdog@vger.kernel.org>, <kumar.gala@freescale.com>,
	<linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] watchdog: add CONFIG_WATCHDOG_NOWAYOUT support to PowerPC
 Book-E watchdog driver
References: <1291395103-12394-1-git-send-email-timur@freescale.com> <20101203180751.GA1903@zod.rchland.ibm.com> <4CF93566.1050601@freescale.com> <20101203190556.GB1903@zod.rchland.ibm.com>
In-Reply-To: <20101203190556.GB1903@zod.rchland.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Josh Boyer wrote:
> No, you definitely want to allow something to open it.  If it's running
> and nothing opens the device and calls write, then you have no way of
> preventing the watchdog from just resetting your board every time.

Now it's my turn to go Doh!  Of course you have to be able to open the driver in
order to ping the timer.

> I had a driver for a different mechanism that would do the equivalent of
> booke_wdt_ping internally to the kernel until somthing opened the
> device.  That way you could have the watchdog active during bootup and
> allow userspace to takeover control when it was ready.  Then NOWAYOUT
> dictated what happened if the userspace process exited or died (or
> otherwise closed the device).  I'm not sure we want to do that for this
> hardware, but it does illustrate the main use of a watchdog on a number
> of boards.
> 
> I guess I don't really care either way if multiple processes have the
> device open, as long as none of them can "disable" the watchdog if
> NOWAYOUT is set.

Well, this patch takes care of that problem.

So just to be clear, do you still have any issues with my patch?

-- 
Timur Tabi
Linux kernel developer at Freescale

