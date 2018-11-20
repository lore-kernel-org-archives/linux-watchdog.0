Return-Path: <arndbergmann@gmail.com>
Return-path: <arndbergmann@gmail.com>
MIME-Version: 1.0
References: <20181120172000.15102-1-eric@anholt.net> <1299453058.112996.1542736171394@email.ionos.de>
 <87o9aj77sk.fsf@anholt.net>
In-Reply-To: <87o9aj77sk.fsf@anholt.net>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 20 Nov 2018 22:39:28 +0100
Message-ID: <CAK8P3a0fusuKD_7Uy38jRfLFJTAFSO+HwO5XhwZQrEfsfths_g@mail.gmail.com>
Subject: Re: [PATCH 0/8] BCM2835 PM driver
To: Eric Anholt <eric@anholt.net>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Florian Fainelli <f.fainelli@gmail.com>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
	"moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

On Tue, Nov 20, 2018 at 10:34 PM Eric Anholt <eric@anholt.net> wrote:
> >> Eric Anholt <eric@anholt.net> hat am 20. November 2018 um 18:19 geschrieben:
> >>
> >>
> >> This series moves the BCM2835 WDT driver that controls a fraction of
> >> the PM block out to soc/ and adds most of the rest of its
> >> functionality.  My motivation has been to have V3D be functional
> >> without firmware calls, probably improve its interactivity (since
> >> we'll be able to power on/off without RPC to the firmware that may be
> >> busy with other tasks), and (in a patch not submitted in this series)
> >> extend its binding to use the reset controller instead of trying to
> >> reset by toggling its power domain.
> >>
> >> I've tested V3D with a few hours of running a V3D test, sleep(1) (to
> >> trigger PM domain off); running a GPU hang job (to trigger reset);
> >> sleep(1).  The non-hanging success-case job always passed, and dmesg
> >> had no complaints from bcm2835-pm.  The other power domains are not
> >> tested, but I've done my best.
> >>
> >> This series will probably also be of interest to the
> >> https://github.com/christinaa/rpi-open-firmware project for enabling USB.
> >>
> >
> > apologize to give you my feedback after you send out the series.
> >
> > I know you won't be happy about it, but i think we need a little more
> > complex but future proof solution for this power driver. According to
> > the register definition of the PM block, we have multiple functions
> > here (power domains, watchdog, pads/pinctrl, ...). Since this is
> > common for ARM SoCs there is a subsystem called mfd (multi function
> > device) [1] to abstract all resources of the IP block.
> >
> > This has the advantage that we don't need a monolithic driver which
> > takes care of all functions.
>
> I consider your "advantage" to be a disadvantage.  By forcing the split,
> you end up having more driver files to manage, more platform devices,
> and more error-prone code to get the resources from the parent down into
> the client.  It feels like writing software for the sake of writing
> software, rather than solving a concrete problem.
>
> My original series:
>
>  10 files changed, 951 insertions(+), 273 deletions(-)
>
> The MFD series:
>
>  12 files changed, 882 insertions(+), 25 deletions(-)

My preference in general is having less code in drivers/soc
and more in subsystems of people that understand their stuff.

Not every driver leans itself to being an MFD, but the more differnent
functions it has, the better it is to have it split up. This was the
original motivation of moving irqchip, clk, pinctrl, etc drivers out
of arch/arm/mach-* into their own subsystems.

       Arnd
