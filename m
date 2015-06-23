Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35699 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932415AbbFWQnS (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 23 Jun 2015 12:43:18 -0400
Date: Tue, 23 Jun 2015 09:43:14 -0700
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
	Arnd Bergmann <arnd@arndb.de>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
	Jon Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, rjw@rjwysocki.net
Subject: Re: [non-pretimeout,4/7] Watchdog: introduce ARM SBSA watchdog driver
Message-ID: <20150623164314.GB20017@roeck-us.net>
References: <1433958452-23721-5-git-send-email-fu.wei@linaro.org>
 <20150611162810.GA22711@roeck-us.net>
 <CADyBb7uGT9bTNiG7524wrd14xiFfgwoDNMq1_J2HDxiK-ogc8Q@mail.gmail.com>
 <20150623152131.GA9990@roeck-us.net>
 <CADyBb7seRmCFu3jhzUTJu7XemH=GjXRopx6EjfSzBypp95tn=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyBb7seRmCFu3jhzUTJu7XemH=GjXRopx6EjfSzBypp95tn=w@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jun 24, 2015 at 12:17:19AM +0800, Fu Wei wrote:
> Hi Guenter,
> 
> you always can provide help very quickly, thank you very much :-)
> 
> On 23 June 2015 at 23:21, Guenter Roeck <linux@roeck-us.net> wrote:
> > On Tue, Jun 23, 2015 at 09:26:35PM +0800, Fu Wei wrote:
> >> Hi Guenter,
> > [ ...]
> >
> >> >
> >> >> + *       When the first timeout occurs, WS0(SPI or LPI) is triggered,
> >> >> + *       the second timeout period(as long as the first timeout period) starts.
> >> >
> >> > no longer accurate if WOR is used for the second period.
> >> >
> >> >> + *       In WS0 interrupt routine, panic() will be called for collecting
> >> >> + *       crashdown info.
> >> >> + *       If system can not recover from WS0 interrupt routine, then second
> >> >> + *       timeout occurs, WS1(reset or higher level interrupt) is triggered.
> >> >> + *       The two timeout period can be set by WOR(32bit).
> >> >
> >> > The second timeout period is determined by ...
> >> >
> >> >> + *       WOR gives a maximum watch period of around 10s at the maximum
> >> >> + *       system counter frequency.
> >> >> + *       The System Counter shall run at maximum of 400MHz.
> >> >
> >> > "... at the maximum system counter frequency of 400 MHz.", and drop the
> >> > last sentence.
> >>
> >> For the second timeout period,  I have discussed with a kdump developers,
> >> (1)10s maybe not good enough for all the case of panic + kdump, so
> >> maybe we still need to use WCV in the second timeout period
> >> (2)in the second timeout period, maybe we need to programme WCV for
> >> two reason: a, trigger WS1 to reboot system ASAP; b, feed the watchdog
> >> without cleanning WS0 flag.
> >>
> >> WHY we want to feed the watchdog (keepalive) without cleanning WS0 flag??
> >> REASON:
> >> (1)if the system context is large, we may need to feed the dog until
> >> we get all the things backed up.
> >> (2)if system goes wrong,  WS0 triggered, then panic--> kdump. if we
> >> feed the dog by WRR or programming WOR, WS0 flag will be cleaned. Once
> >> system goes wrong again, then panic again.....
> >> So this system will be in a panic--kdump--panic--kdump loop, have not
> >> chance to reset.
> >>
> >> So if we are in the second timeout period, we may need to always programme WCV.
> >>
> > The crashdump kernel is supposed to reload the watchdog driver, which will ping
> > the watchdog. If it isn't able to do that in 10 seconds, something is wrong.
> 
> yes, 10s maybe not enough for all case.
> When I tested kdump on arm64, sometimes , it took 20s. So I am
> thinking : can we make the max value of pretimeout > 10s in this
> driver.
> 
It takes more than 10 seconds to load the crashdump kernel,
or it takes more than 10 seconds to complete the dump ?

> 
> >
> >> >> +
> >> >> +     status = readl_relaxed(gwdt->control_base + SBSA_GWDT_WCS);
> >> >> +     if (status & SBSA_GWDT_WCS_WS1) {
> >> >> +             dev_warn(dev, "System reset by WDT(WCV: %llx)\n",
> >> >> +                      sbsa_gwdt_get_wcv(wdd));
> >> >
> >> > WCV here only tells us how many clock cycles were executed since the
> >> > system started (or something like that). So I still don't understand
> >> > why it is valuable to print that number.
> >>
> >> this number provides the time of system reset, I thinks that may help
> >> admin to analyse the system failure.
> >>
> > It doesn't mean anything to anyone but you since it is not in a well defined
> > time scale.
> 
> maybe I should convert it to second?
> I think the original value is better?
> 

I think you should drop it.

Guenter
