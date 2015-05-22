Return-path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com, linaro-acpi@lists.linaro.org, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, tekkamanninja@gmail.com, graeme.gregory@linaro.org, al.stone@linaro.org, timur@codeaurora.org, ashwin.chaugule@linaro.org, linux@roeck-us.net, vgandhi@codeaurora.org, wim@iguana.be, jcm@redhat.com, leo.duran@amd.com, corbet@lwn.net, mark.rutland@arm.com
Subject: Re: [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog driver
Date: Fri, 22 May 2015 16:55:04 +0200
Message-ID: <4095167.UOriXdSu53@wuerfel>
In-Reply-To: <555F4236.7040206@linaro.org>
References: <=fu.wei@linaro.org> <1432197156-16947-7-git-send-email-fu.wei@linaro.org> <555F4236.7040206@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-watchdog@vger.kernel.org>

On Friday 22 May 2015 22:50:30 Hanjun Guo wrote:
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index e5e7c55..25a0df1 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -152,6 +152,18 @@ config ARM_SP805_WATCHDOG
> >         ARM Primecell SP805 Watchdog timer. This will reboot your system when
> >         the timeout is reached.
> >
> > +config ARM_SBSA_WATCHDOG
> > +     tristate "ARM SBSA Generic Watchdog"
> > +     depends on ARM || ARM64 || COMPILE_TEST
> 
> SBSA is for ARMv8-A based (64-bit) servers, no need to depends on ARM,
> and why we depends on COMPILE_TEST?
> 

I think it's a reasonable assumption that someone will sooner or later
put that hardware into an ARM32 machine, or run a 32-bit kernel on
a chip that has it.

While SBSA requires this watchdog device, nothing prevents SoC
manufacturers from using the same design in something that is not
a server.

	Arnd
