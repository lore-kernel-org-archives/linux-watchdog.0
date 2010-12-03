Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from am1ehsobe003.messaging.microsoft.com ([213.199.154.206]:18599
	"EHLO AM1EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752606Ab0LCTnp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 3 Dec 2010 14:43:45 -0500
Received: from mail74-am1 (localhost.localdomain [127.0.0.1])	by
 mail74-am1-R.bigfish.com (Postfix) with ESMTP id 0A4361298776	for
 <linux-watchdog@vger.kernel.org>; Fri,  3 Dec 2010 19:43:44 +0000 (UTC)
Received: from AM1EHSMHS004.bigfish.com (unknown [10.3.201.243])	by
 mail74-am1.bigfish.com (Postfix) with ESMTP id B5CBA25804C	for
 <linux-watchdog@vger.kernel.org>; Fri,  3 Dec 2010 19:43:43 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP id oB3Jhcfb008515	for
 <linux-watchdog@vger.kernel.org>; Fri, 3 Dec 2010 12:43:38 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
 [10.64.32.16])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
 oB3K1ghl005986	for <linux-watchdog@vger.kernel.org>; Fri, 3 Dec 2010 14:01:42
 -0600 (CST)
Message-ID: <4CF94869.4020705@freescale.com>
Date: Fri, 3 Dec 2010 13:43:37 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
CC: <linux-watchdog@vger.kernel.org>, <kumar.gala@freescale.com>,
	<linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] watchdog: add CONFIG_WATCHDOG_NOWAYOUT support to PowerPC
 Book-E watchdog driver
References: <1291395103-12394-1-git-send-email-timur@freescale.com> <20101203180751.GA1903@zod.rchland.ibm.com> <4CF93566.1050601@freescale.com> <20101203190556.GB1903@zod.rchland.ibm.com> <4CF9408A.4030506@freescale.com> <20101203193900.GC1903@zod.rchland.ibm.com>
In-Reply-To: <20101203193900.GC1903@zod.rchland.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Josh Boyer wrote:
> Just the moving of the clear_bit inside the #ifndef
> CONFIG_WATCHDOG_NOWAYOUT.

If I move the clear_bit() call inside the #ifndef, then when
CONFIG_WATCHDOG_NOWAYOUT is defined, after a process closes /dev/watchdog, no
process will ever be able to open it again.  Are you saying that once
wd_keepalive exits, you don't want anyone to be able to open /dev/watchdog and
ping the timer again?

-- 
Timur Tabi
Linux kernel developer at Freescale

