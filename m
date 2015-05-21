Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38593 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755806AbbEUPSw (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 21 May 2015 11:18:52 -0400
Date: Thu, 21 May 2015 08:18:47 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Fu Wei <fu.wei@linaro.org>
Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Wei Fu <tekkamanninja@gmail.com>,
	G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Timur Tabi <timur@codeaurora.org>,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, vgandhi@codeaurora.org,
	wim@iguana.be, Jon Masters <jcm@redhat.com>,
	Leo Duran <leo.duran@amd.com>, Jon Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog driver
Message-ID: <20150521151847.GA16668@roeck-us.net>
References: <=fu.wei@linaro.org>
 <1432197156-16947-1-git-send-email-fu.wei@linaro.org>
 <1432197156-16947-7-git-send-email-fu.wei@linaro.org>
 <555DB4C4.5090606@roeck-us.net>
 <CADyBb7vbcHG69cpnx6sUwaT7abS7w3Er62+50D6PUrGHVnG9vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyBb7vbcHG69cpnx6sUwaT7abS7w3Er62+50D6PUrGHVnG9vQ@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, May 21, 2015 at 07:08:34PM +0800, Fu Wei wrote:
> Hi Guenter,
> 
> Thanks for review :-)
> 
> On 21 May 2015 at 18:34, Guenter Roeck <linux@roeck-us.net> wrote:
> > On 05/21/2015 01:32 AM, fu.wei@linaro.org wrote:
> >>
> >> From: Fu Wei <fu.wei@linaro.org>
> >>
> >> This driver bases on linux kernel watchdog framework, and
> >> use "pretimeout" in the framework. It supports getting timeout and
> >> pretimeout from parameter and FDT at the driver init stage.
> >> In first timeout(WS0), the interrupt routine run panic to save
> >> system context.
> >>
> >> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> >> ---
> >>   drivers/watchdog/Kconfig     |  12 ++
> >>   drivers/watchdog/Makefile    |   1 +
> >>   drivers/watchdog/sbsa_gwdt.c | 476
> >> +++++++++++++++++++++++++++++++++++++++++++
> >>   3 files changed, 489 insertions(+)
> >>   create mode 100644 drivers/watchdog/sbsa_gwdt.c
> >>
> >> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> >> index e5e7c55..25a0df1 100644
> >> --- a/drivers/watchdog/Kconfig
> >> +++ b/drivers/watchdog/Kconfig
> >> @@ -152,6 +152,18 @@ config ARM_SP805_WATCHDOG
> >>           ARM Primecell SP805 Watchdog timer. This will reboot your system
> >> when
> >>           the timeout is reached.
> >>
> >> +config ARM_SBSA_WATCHDOG
> >> +       tristate "ARM SBSA Generic Watchdog"
> >> +       depends on ARM || ARM64 || COMPILE_TEST
> >> +       depends on ARM_ARCH_TIMER
> >> +       select WATCHDOG_CORE
> >> +       help
> >> +         ARM SBSA Generic Watchdog timer. This has two Watchdog Signals
> >> +         (WS0/WS1), will trigger a warning interrupt(do panic) at the
> >> first
> >> +         timeout(WS0); will reboot your system when the second
> >> timeout(WS1)
> >> +         is reached.
> >
> >
> > I think it would be better to keep the WS0/WS1 out of the help text.
> > It is an implementation detail, and no user will be able to make sense of
> > it.
> 
> I don't mind to delete it , but those are in SBSA spec, is that an
> implementation detail ?
> 
I think so.

Ask yourself - assuming you are not involved in the development of this driver,
and you read this help text. Is the help text going to help you to know about
WS0 and WS1 ? Why not just something like the following, if you want to be
verbose ?

	ARM SBSA Generic Watchdog. This watchdog has two Watchdog timeouts.
	The first timeout will trigger a panic; the second timeout will trigger
	a system reset.

Anyway, not worth arguing about.

> >> +
> >> +       /*
> >> +        * Try to determine the frequency from the arch_timer interface
> >> +        */
> >> +       clk = arch_timer_get_rate();
> >
> >
> > arch_timer_get_rate() does not seem to be exported. Did you try to build
> > the driver as module ?
> 
> yes, I have built it as a ko module, that is why I made a patch to
> export this interface in the first patch of this patchset
> 
>  but I will confirm it again :-)
> 
Guess I'll give it a try myself. I don't really understand how this
can work unless arch_timer_get_rate() is exported in your tree.

Guenter
