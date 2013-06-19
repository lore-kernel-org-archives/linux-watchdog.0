Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:64956 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756610Ab3FSIPN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 19 Jun 2013 04:15:13 -0400
Received: by mail-oa0-f41.google.com with SMTP id n10so6194141oag.28
        for <linux-watchdog@vger.kernel.org>; Wed, 19 Jun 2013 01:15:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <319bb53672a5fa97b7aa603392b6a2fa@localhost>
References: <cover.1371535241.git.viresh.kumar@linaro.org>
	<22d22fe6eea294c5132e47b8901e094d60b0e99d.1371535242.git.viresh.kumar@linaro.org>
	<20130618154236.GA9022@roeck-us.net>
	<51C086A8.3070601@arm.com>
	<CAOesGMia0OZz5dcDooRHG9EAnaLimRL5_Gku2rm_fVDNxrxEEA@mail.gmail.com>
	<CAKohpom3S3NMhxbhbmyC6bceS51727CnWRWmWDGxwDcRJkHFyQ@mail.gmail.com>
	<319bb53672a5fa97b7aa603392b6a2fa@localhost>
Date: Wed, 19 Jun 2013 13:45:12 +0530
Message-ID: <CAKohpokUJKt4dcqYpKLNVn2_f7OeZgiftZB3M+aa3-83o_XDcg@mail.gmail.com>
Subject: Re: [PATCH V3 01/14] watchdog/mpcore_wdt: Mark it as BROKEN
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Olof Johansson <olof@lixom.net>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Stephen Warren <swarren@nvidia.com>, wim@iguana.be,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 19 June 2013 13:26, Marc Zyngier <marc.zyngier@arm.com> wrote:
> ARM11, A5 and A9 in their MP configurations only.
>
>> If no, then which ones are the real users of this driver/hardware?
>> If yes, Why isn't anybody using this?
>
> Because, as Russell mentioned, the piece of IP doesn't fit our watchdog
> model at all (per-CPU watchdog???), and most SoCs/boards have a separate
> watchdog anyway.

I believe we should use mpcore watchdogs. Atleast on the platforms I have
worked (SPEAr), they don't have an external watchdog.

But yes, this would require somebody, with a A5/9/ARM11 board, no
separate watchdog and a customer requirement, to work on it :)

I will get rid of it.

Thanks.
