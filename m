Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:4071 "EHLO
	TX2EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753878Ab0ITTxO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 20 Sep 2010 15:53:14 -0400
Received: from mail117-tx2 (localhost.localdomain [127.0.0.1])	by
 mail117-tx2-R.bigfish.com (Postfix) with ESMTP id 811F012403AD	for
 <linux-watchdog@vger.kernel.org>; Mon, 20 Sep 2010 19:53:13 +0000 (UTC)
Received: from TX2EHSMHS032.bigfish.com (unknown [10.9.14.242])	by
 mail117-tx2.bigfish.com (Postfix) with ESMTP id 3FA0B12E8051	for
 <linux-watchdog@vger.kernel.org>; Mon, 20 Sep 2010 19:53:13 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id o8KJr9N6004242	for
 <linux-watchdog@vger.kernel.org>; Mon, 20 Sep 2010 12:53:09 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
 [10.64.32.16])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
 o8KK7WcO014248	for <linux-watchdog@vger.kernel.org>; Mon, 20 Sep 2010
 15:07:32 -0500 (CDT)
Message-ID: <4C97BBA4.9090401@freescale.com>
Date: Mon, 20 Sep 2010 14:53:08 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
CC: Josh Boyer <jwboyer@gmail.com>, kumar.gala@freescale.com,
	linux-watchdog@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/2] powerpc/watchdog: allow the e500 watchdog driver
 to be compiled as a module
References: <1284764008-19469-1-git-send-email-timur@freescale.com> <1284764008-19469-2-git-send-email-timur@freescale.com> <AANLkTi=Ks7hkDq1g1SyHLf4Lf8tsew-KnvKOgyQxjcWQ@mail.gmail.com> <AANLkTimp-0zdw-fAaX8qCwHW0NMn--6RK0_USDGOSe47@mail.gmail.com> <20100920193016.GA3845@zod.rchland.ibm.com>
In-Reply-To: <20100920193016.GA3845@zod.rchland.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Josh Boyer wrote:
> I guess I don't see what you mean.  It talks about e500 but it doesn't
> say "Book-E" anywhere in that comment.  (Though I'm pretty sure that
> comment does apply to 4xx.)

That was my point.  The comment says e500, but the code is also intended for
4xx.

-- 
Timur Tabi
Linux kernel developer at Freescale

