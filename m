Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from e7.ny.us.ibm.com ([32.97.182.137]:52801 "EHLO e7.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757225Ab0ITTam (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 20 Sep 2010 15:30:42 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e7.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8KJFpwF027727
	for <linux-watchdog@vger.kernel.org>; Mon, 20 Sep 2010 15:15:51 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o8KJUfVU083208
	for <linux-watchdog@vger.kernel.org>; Mon, 20 Sep 2010 15:30:41 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id o8KJUem2012970
	for <linux-watchdog@vger.kernel.org>; Mon, 20 Sep 2010 15:30:41 -0400
Date: Mon, 20 Sep 2010 15:30:36 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Timur Tabi <timur@freescale.com>
Cc: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org,
	kumar.gala@freescale.com, linux-watchdog@vger.kernel.org,
	jwboyer@gmail.com
Subject: Re: [PATCH 1/2] [v2] powerpc: export ppc_proc_freq and ppc_tb_freq
 as GPL symbols
Message-ID: <20100920193035.GB3845@zod.rchland.ibm.com>
References: <1284999822-24753-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1284999822-24753-1-git-send-email-timur@freescale.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Sep 20, 2010 at 11:23:41AM -0500, Timur Tabi wrote:
>Export the global variable 'ppc_tb_freq', so that modules (like the Book-E
>watchdog driver) can use it.  To maintain consistency, ppc_proc_freq is changed
>to a GPL-only export.  This is okay, because any module that needs this symbol
>should be an actual Linux driver, which must be GPL-licensed.
>
>Signed-off-by: Timur Tabi <timur@freescale.com>

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

>---
>
>This export is necessary for the Book-E watchdog driver to be compiled as a
>module.
>
> arch/powerpc/kernel/time.c |    3 ++-
> 1 files changed, 2 insertions(+), 1 deletions(-)
>
>diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
>index 8533b3b..0c0c241 100644
>--- a/arch/powerpc/kernel/time.c
>+++ b/arch/powerpc/kernel/time.c
>@@ -161,8 +161,9 @@ extern struct timezone sys_tz;
> static long timezone_offset;
>
> unsigned long ppc_proc_freq;
>-EXPORT_SYMBOL(ppc_proc_freq);
>+EXPORT_SYMBOL_GPL(ppc_proc_freq);
> unsigned long ppc_tb_freq;
>+EXPORT_SYMBOL_GPL(ppc_tb_freq);
>
> static DEFINE_PER_CPU(u64, last_jiffy);
>
>-- 
>1.7.2.3
>
>
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@lists.ozlabs.org
>https://lists.ozlabs.org/listinfo/linuxppc-dev
