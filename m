Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from b.ns.miles-group.at ([95.130.255.144]:1660 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750716AbaBCJNx (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 3 Feb 2014 04:13:53 -0500
Message-ID: <52EF5DCA.3060506@nod.at>
Date: Mon, 03 Feb 2014 10:13:46 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
To: Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog,dw: Add dependency on HAS_IOMEM
References: <1391172454-17959-1-git-send-email-richard@nod.at> <20140203085800.GC29278@spo001.leaseweb.com>
In-Reply-To: <20140203085800.GC29278@spo001.leaseweb.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Am 03.02.2014 09:58, schrieb Wim Van Sebroeck:
> Hi Richard,
> 
>> On archs like S390 or um this driver cannot build nor work.
>> Make it depend on HAS_IOMEM to bypass build failures.
>>
>> drivers/built-in.o: In function `dw_wdt_drv_probe':
>> drivers/watchdog/dw_wdt.c:302: undefined reference to `devm_ioremap_resource'
>>
>> Signed-off-by: Richard Weinberger <richard@nod.at>
> 
> Patch added to linux-watchdog-next.

-next in terms of 3.15 material?
Please push this as soon as possible to Linus such that the build works on said archs.

Thanks,
//richard
