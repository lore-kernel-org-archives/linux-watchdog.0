Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:56473 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703Ab3I0PU0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 27 Sep 2013 11:20:26 -0400
Received: by mail-qa0-f46.google.com with SMTP id j7so567085qaq.19
        for <linux-watchdog@vger.kernel.org>; Fri, 27 Sep 2013 08:20:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2333262.vSzLePxk45@amdc1227>
References: <1379414623-26329-1-git-send-email-l.krishna@samsung.com>
	<9721965.AJ5fjDQ1RM@amdc1227>
	<CAL1wa8cDAui8AJXvmYPpPEWtUum-ZNpW2hQWjwKLpzXBFLv=eA@mail.gmail.com>
	<2333262.vSzLePxk45@amdc1227>
Date: Fri, 27 Sep 2013 08:20:25 -0700
Message-ID: <CAD=FV=WZBrJ5Qhky6VQqfu59LVQcKMTdLa+gJwnnFM85bEzzNQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] watchdog: s3c2410_wdt: parse watchdog dt node to read
 PMU registers adresses
From: Doug Anderson <dianders@chromium.org>
To: Tomasz Figa <t.figa@samsung.com>
Cc: Leela Krishna Amudala <l.krishna@samsung.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Kukjin Kim <kgene.kim@samsung.com>, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Ian Campbell <ian.campbell@citrix.com>, mark.rutland@arm.com,
	galak@codeaurora.org, pawel.moll@arm.com,
	Rob Herring <rob.herring@calxeda.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Tomasz

On Fri, Sep 27, 2013 at 4:25 AM, Tomasz Figa <t.figa@samsung.com> wrote:
>> >> Since we already have PMU "driver" in mach-exynos, which already has
>> >> suspend/resume syscore ops, what about placing such configuration there
>> >> instead?
>> >
>> > Any opinions on this?
>> >
>>
>> In PMU we have control registers for other IPs (like USB, MIPI etc.,)
>> also and I'm not sure where those registers are getting configured.
>> If we want to configure WDT register in PMU driver then we have to
>> consider configuring control regs for other IPs also and the DT node
>> has to have all these control bit numbers. So instead of that I feel
>> configuring it in WDT driver looks fine.
>
> I believe this depends on possible use cases, not the IP block itself.
> If this is just a low level initial (and SoC specific) initialization
> that doesn't require any co-operation with high level kernel/userspace
> APIs, then I think there is no need to entangle the driver for watchdog
> IP with SoC specific details outside the IP itself.
>
> [Adding more people on Cc for further discussion.]

So isn't the register in the PMU there to save power in the case that
the watchdog timer isn't being used?  How is the PMU "driver" to know
whether the watchdog is being used?  Better IMHO that the watchdog
driver knows to enable and disable itself as needed, right?

-Doug
