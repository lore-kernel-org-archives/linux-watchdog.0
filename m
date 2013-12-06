Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176]:40588 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412Ab3LFXBY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 6 Dec 2013 18:01:24 -0500
Received: by mail-vc0-f176.google.com with SMTP id lf12so1396956vcb.21
        for <linux-watchdog@vger.kernel.org>; Fri, 06 Dec 2013 15:01:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131206194709.GA14464@roeck-us.net>
References: <1386308868-30264-1-git-send-email-l.krishna@samsung.com>
	<1386308868-30264-2-git-send-email-l.krishna@samsung.com>
	<20131206194709.GA14464@roeck-us.net>
Date: Fri, 6 Dec 2013 15:01:23 -0800
Message-ID: <CAD=FV=VdcN8rswMABcCZhkhgPjcpngGr+GRS2rsxFaRHwrTuwQ@mail.gmail.com>
Subject: Re: [PATCH V12 1/3] ARM: dts: Add pmu sysreg node to exynos5250 and
 exynos5420 dtsi files
From: Doug Anderson <dianders@chromium.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Leela Krishna Amudala <l.krishna@samsung.com>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Tomasz Figa <t.figa@samsung.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"cpgs ." <cpgs@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Guenter,

On Fri, Dec 6, 2013 at 11:47 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Fri, Dec 06, 2013 at 11:17:46AM +0530, Leela Krishna Amudala wrote:
>> This patch adds pmusysreg node to exynos5250 and exynos5420 dtsi files to
>> handle PMU register accesses in a centralized way using syscon driver
>>
>> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
>> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
>> Reviewed-by: Doug Anderson <dianders@chromium.org>
>> Tested-by: Doug Anderson <dianders@chromium.org>
>
> Acked-by: Guenter Roeck <linux@roeck-us.net>

I'm curious of your opinion of Sylwester's requests, since your Ack
came in after his requests.  Would you like to see a respin of this,
or do you think it's gone through enough spinning and are thinking it
would go in as-is?

-Doug
