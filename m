Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from db3ehsobe005.messaging.microsoft.com ([213.199.154.143]:38382
	"EHLO DB3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752000Ab0LCShn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 3 Dec 2010 13:37:43 -0500
Received: from mail34-db3 (localhost.localdomain [127.0.0.1])	by
 mail34-db3-R.bigfish.com (Postfix) with ESMTP id BDCDE3C8191	for
 <linux-watchdog@vger.kernel.org>; Fri,  3 Dec 2010 18:22:38 +0000 (UTC)
Received: from DB3EHSMHS001.bigfish.com (unknown [10.3.81.240])	by
 mail34-db3.bigfish.com (Postfix) with ESMTP id E83081B48051	for
 <linux-watchdog@vger.kernel.org>; Fri,  3 Dec 2010 18:22:37 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
 [10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
 oB3IMVgB010791	for <linux-watchdog@vger.kernel.org>; Fri, 3 Dec 2010 11:22:31
 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
 [10.64.32.16])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
 oB3IMVjG019314	for <linux-watchdog@vger.kernel.org>; Fri, 3 Dec 2010 12:22:31
 -0600 (CST)
Message-ID: <4CF93566.1050601@freescale.com>
Date: Fri, 3 Dec 2010 12:22:30 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
CC: <linux-watchdog@vger.kernel.org>, <kumar.gala@freescale.com>,
	<linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] watchdog: add CONFIG_WATCHDOG_NOWAYOUT support to PowerPC
 Book-E watchdog driver
References: <1291395103-12394-1-git-send-email-timur@freescale.com> <20101203180751.GA1903@zod.rchland.ibm.com>
In-Reply-To: <20101203180751.GA1903@zod.rchland.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Josh Boyer wrote:
> I'm confused why you can't use booke_wdt_enabled for the purposes of the
> device having been opened.  It seems the use of the wdt_is_active
> basically duplicates this functionalit (and oddly with the bit
> manipulation instead of just atomic_inc/dec).

Because the watchdog can be enabled even when the driver is not open.
booke_wdt_enabled is also initialized in setup_32.c.  So booke_wdt_enabled
represents the watchdog hardwre, whereas wdt_is_active represents the open
condition of /dev/watchdog.

However, now that I think about it, maybe that just causes confusion.  If the
watchdog is already running because of a command-line parameter, should we
prevent /dev/watchdog from ever being opened?  If you're okay with that, then I
can combine the two variables.

> If you were to keep this variable instead of just using
> booke_wdt_enabled, wouldn't it be more correct to have the clear_bit
> only done inside the #ifndef?  The timer is very much still active if
> NOWAYOUT is set...

In this case, yes.

-- 
Timur Tabi
Linux kernel developer at Freescale

