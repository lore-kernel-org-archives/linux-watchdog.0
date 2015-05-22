Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:59135 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757750AbbEVPYL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 22 May 2015 11:24:11 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linaro-acpi@lists.linaro.org
Cc: Hanjun Guo <hanjun.guo@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>, corbet@lwn.net,
	devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
	jcm@redhat.com, timur@codeaurora.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, wim@iguana.be,
	tekkamanninja@gmail.com, vgandhi@codeaurora.org
Subject: Re: [Linaro-acpi] [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog driver
Date: Fri, 22 May 2015 17:24:01 +0200
Message-ID: <10437443.BChumWu5Uk@wuerfel>
In-Reply-To: <555F48BD.4010605@linaro.org>
References: <=fu.wei@linaro.org> <20150522150145.GA2930@roeck-us.net> <555F48BD.4010605@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="utf-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Friday 22 May 2015 23:18:21 Hanjun Guo wrote:
> On 2015年05月22日 23:01, Guenter Roeck wrote:
> > On Fri, May 22, 2015 at 04:55:04PM +0200, Arnd Bergmann wrote:
> >> On Friday 22 May 2015 22:50:30 Hanjun Guo wrote:
> >>>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> >>>> index e5e7c55..25a0df1 100644
> >>>> --- a/drivers/watchdog/Kconfig
> >>>> +++ b/drivers/watchdog/Kconfig
> >>>> @@ -152,6 +152,18 @@ config ARM_SP805_WATCHDOG
> >>>>          ARM Primecell SP805 Watchdog timer. This will reboot your system when
> >>>>          the timeout is reached.
> >>>>
> >>>> +config ARM_SBSA_WATCHDOG
> >>>> +     tristate "ARM SBSA Generic Watchdog"
> >>>> +     depends on ARM || ARM64 || COMPILE_TEST
> >>>
> >>> SBSA is for ARMv8-A based (64-bit) servers, no need to depends on ARM,
> >>> and why we depends on COMPILE_TEST?
> >>>
> >>
> >> I think it's a reasonable assumption that someone will sooner or later
> >> put that hardware into an ARM32 machine, or run a 32-bit kernel on
> >> a chip that has it.
> >>
> >> While SBSA requires this watchdog device, nothing prevents SoC
> >> manufacturers from using the same design in something that is not
> >> a server.
> 
>  From this point of view, I agree that SBSA watchdog design may used
> in other ARM SoCs in the future, but how about add it back when this
> kind of hardware showing up?

If it builds on ARM32, I'd rather leave the option in, it doesn't hurt.

> > Tricky, though. Since teh driver uses arm specific clock functions,
> > I don't think this can compile on a non-arm machine.
> 
> Since it depends on ARM64/ARM, we can temporary release from that now 

We have to drop the '|| COMPILE_TEST' though as a result, or fix the
driver to look up the clock in DT and call 'clk_get_rate'.

That will break the ACPI case, but ACPI could use platform_data to
pass the clock rate into the driver, to make it independent of
low-level APIs.

	Arnd
