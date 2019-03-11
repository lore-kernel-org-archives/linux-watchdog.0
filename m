Return-Path: <SRS0=+zyj=RO=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147AEC43381
	for <linux-watchdog@archiver.kernel.org>; Mon, 11 Mar 2019 23:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62BB214AF
	for <linux-watchdog@archiver.kernel.org>; Mon, 11 Mar 2019 23:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbfCKXxz (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 11 Mar 2019 19:53:55 -0400
Received: from mleia.com ([178.79.152.223]:49462 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbfCKXxz (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 11 Mar 2019 19:53:55 -0400
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 5BE3A457DE4;
        Mon, 11 Mar 2019 23:53:53 +0000 (GMT)
Subject: Re: watchdog: Missing Kconfig dependency for
 CONFIG_WATCHDOG_PRETIMEOUT_GOV and CONFIG_WATCHDOG_CORE
To:     "Kuo, Hsuan-Chi" <hckuo2@illinois.edu>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
References: <00e44870397dd49a9c9989d6c22eabe650f5b9ca.camel@illinois.edu>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <3d9b307e-74a3-7f6d-9a50-946b3319a5bc@mleia.com>
Date:   Tue, 12 Mar 2019 01:53:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <00e44870397dd49a9c9989d6c22eabe650f5b9ca.camel@illinois.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20190311_235353_398047_B2DF2F75 
X-CRM114-Status: GOOD (  12.20  )
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Hi,

On 03/11/2019 11:45 PM, Kuo, Hsuan-Chi wrote:
> Hi,
> 
> I compiled my kernel with CONFIG_WATCHDOG_PRETIMEOUT_GOV=y and
> CONFIG_WATCHDOG_CORE=n and encountered compilation errors. I later
> found in the Makefile that it's because CONFIG_WATCHDOG_CORE is not
> enabled hence watchdog.o is not compiled, however, the Kconfig misses
> this dependency. I sent this email to confirm if this is a bug and
> hopfully someone can fix it.
> 
> Snippet for the Makefile
> ```
> # Makefile for the WatchDog device drivers.
> #
> 
> # The WatchDog Timer Driver Core.
> obj-$(CONFIG_WATCHDOG_CORE)    += watchdog.o
> 
> watchdog-objs    += watchdog_core.o watchdog_dev.o
> 
> watchdog-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV)    += watchdog_pretimeout.o
> 
> obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP)    += pretimeout_noop.o
> obj-$(CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC)    += pretimeout_panic.o
> ```
> 
> Snippet for the Kconfig
> ```
> config WATCHDOG_PRETIMEOUT_GOV
> 	bool "Enable watchdog pretimeout governors"
> 	help
> 	  The option allows to select watchdog pretimeout governors.
> ```
> 
> Compilation errors
> ```
> ld: drivers/watchdog/pretimeout_noop.o: in function
> `watchdog_gov_noop_unregister':
> pretimeout_noop.c:(.exit.text+0x8): undefined reference to
> `watchdog_unregister_governor'
> ld: drivers/watchdog/pretimeout_noop.o: in function
> `watchdog_gov_noop_register':
> pretimeout_noop.c:(.init.text+0xd): undefined reference to
> `watchdog_register_governor'
> ld: drivers/watchdog/pretimeout_panic.o: in function
> `watchdog_gov_panic_unregister':
> pretimeout_panic.c:(.exit.text+0x8): undefined reference to
> `watchdog_unregister_governor'
> ld: drivers/watchdog/pretimeout_panic.o: in function
> `watchdog_gov_panic_register':
> pretimeout_panic.c:(.init.text+0xd): undefined reference to
> `watchdog_register_governor'
> ```
> 
> Thank you!
> 

this is a valid bug report, thank you for the finding!

I'll send a fix shortly.

--
Best wishes,
Vladimir
