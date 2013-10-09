Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qe0-f54.google.com ([209.85.128.54]:61845 "EHLO
	mail-qe0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347Ab3JIGYc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 9 Oct 2013 02:24:32 -0400
Received: by mail-qe0-f54.google.com with SMTP id 1so250715qec.27
        for <linux-watchdog@vger.kernel.org>; Tue, 08 Oct 2013 23:24:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20131002175937.GA4811@roeck-us.net>
References: <20131002175937.GA4811@roeck-us.net>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 9 Oct 2013 14:24:11 +0800
Message-ID: <CAGsJ_4zBTdwwwne=CAKEpGb_9EVjEB15dDOMhfzSv4zOz-X+sA@mail.gmail.com>
Subject: Re: New watchdog and watchdog-next branches to augment the existing ones
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Rob Landley <rob@landley.net>,
	Russell King <linux@arm.linux.org.uk>,
	Wim Van Sebroeck <wim@iguana.be>,
	Johannes Thumshirn <johannes.thumshirn@men.de>,
	Dinh Nguyen <dinguyen@altera.com>,
	Pavel Machek <pavel@denx.de>, Jamie Iles <jamie@jamieiles.com>,
	Jonas Jensen <jonas.jensen@gmail.com>,
	John Crispin <blogic@openwrt.org>,
	Xianglong Du <Xianglong.Du@csr.com>,
	Barry Song <Baohua.Song@csr.com>,
	Tony Lindgren <tony@atomide.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Felipe Balbi <balbi@ti.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

2013/10/3 Guenter Roeck <linux@roeck-us.net>:
> Hi all,
>
> to support Wim in his efforts to maintain the watchdog subsystem,
> I created two new branches in my repository at kernel.org
>         git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git

it is fine to see that.

>
> The two branches are
>         watchdog        for watchdog patches I believe should be applied
>                         to the current upstream kernel
>         watchdog-next   for patches I believe are ready to be pushed upstream
>                         in the next commit window.
>
> Both branches may and will be rebased from time to time as I see fit. watchdog
> will in general be based on a recent upstream tag, and watchdog-next will be
> based on watchdog. As of today, the watchdog branch is based on v3.12-rc3.
>
> The new branches are not supposed to replace Wim's repository, but to augment it.
> It enables me to run my own automated build tests (see
> http://server.roeck-us.net:8010/builders for current build results), and it will
> hopefully trigger builds by Fengguang's build robots with the various patches
> applied.
>
> I also set up patchwork to track the watchdog mailing lists at
> http://server.roeck-us.net/project/linux-watchdog/list/. This is mostly for
> myself to ensure that patches don't get lost, but it is accessible for others
> as well.
>
> I hope this will help Wim in deciding if and when to push patches upstream; at
> the very least it will provide additional test coverage. Note that I don't plan
> to add the watchdog-next branch to linux-next, as the decision if and when
> to push patches upstream is up to Wim to make.
>
> Thanks,
> Guenter
>
> ---


-barry
