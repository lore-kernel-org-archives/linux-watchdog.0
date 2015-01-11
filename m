Return-path: <maarten@treewalker.org>
From: Maarten ter Huurne <maarten@treewalker.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Ralf Baechle <ralf@linux-mips.org>, Wim Van Sebroeck <wim@iguana.be>, Paul Burton <paul.burton@imgtec.com>, Paul Cercueil <paul@crapouillou.net>, linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/3] MIPS: qi_lb60: Register watchdog device
Date: Sun, 11 Jan 2015 02:37:24 +0100
Message-ID: <2955853.HTsalEGzQa@hyperion>
In-Reply-To: <54B1D0E5.3010904@roeck-us.net>
References: <1420914550-18335-1-git-send-email-lars@metafoo.de> <1420914550-18335-2-git-send-email-lars@metafoo.de> <54B1D0E5.3010904@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-watchdog@vger.kernel.org>

On Saturday 10 January 2015 17:24:53 Guenter Roeck wrote:
> On 01/10/2015 10:29 AM, Lars-Peter Clausen wrote:
> > The next commit will move the restart code to the watchdog driver. So
> > for
> > restart to continue to work we need to register the watchdog device.
> > 
> > Also enable the watchdog driver in the default config.
> > 
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > ---
> > 
> >   arch/mips/configs/qi_lb60_defconfig |    2 ++
> >   arch/mips/jz4740/board-qi_lb60.c    |    1 +
> >   2 files changed, 3 insertions(+)
> > 
> > diff --git a/arch/mips/configs/qi_lb60_defconfig
> > b/arch/mips/configs/qi_lb60_defconfig index 2b96547..ce06a92 100644
> > --- a/arch/mips/configs/qi_lb60_defconfig
> > +++ b/arch/mips/configs/qi_lb60_defconfig
> > @@ -73,6 +73,8 @@ CONFIG_POWER_SUPPLY=y
> > 
> >   CONFIG_BATTERY_JZ4740=y
> >   CONFIG_CHARGER_GPIO=y
> >   # CONFIG_HWMON is not set
> > 
> > +CONFIG_WATCHDOG=y
> > +CONFIG_JZ4740_WDT=y
> 
> Shouldn't JZ4740_WDT be selected from MACH_JZ4740 ?
> 
> Guess it doesn't really matter if there is just one board, but if there
> is ever another board the reset handler would not automatically be
> enabled.

There is only one board in the mainline kernel, but Paul Cercueil and me did 
maintain a kernel for the Dingoo A320 for a while which is also JZ4740-
based. Also, a lot of the JZ4740 drivers can be used as-is or with small 
adaptations on later SoC generations. For example, we're using a slightly 
modified version of this watchdog driver on the JZ4770-based GCW Zero.

Bye,
		Maarten
