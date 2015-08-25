Return-path: <justinpopo6@gmail.com>
Date: Tue, 25 Aug 2015 10:55:40 -0700
From: Justin Chen <justinpopo6@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, feedback-list@broadcom.com,
	devicetree@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, wim@iguana.be, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/2] watchdog: bcm7038: add device tree binding
 documentation
Message-ID: <20150825175538.GA16266@Justins-MacBook-Pro.local>
References: <1440092486-16905-1-git-send-email-justinpopo6@gmail.com>
 <1440092486-16905-2-git-send-email-justinpopo6@gmail.com>
 <55DA9045.2060107@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55DA9045.2060107@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Sun, Aug 23, 2015 at 08:32:21PM -0700, Guenter Roeck wrote:
> Hi Justin,
> 
> On 08/20/2015 10:41 AM, Justin Chen wrote:
> >Add device tree binding docmentation for the watchdog hardware block
> >on bcm7038 and newer SoCs.
> >
> >Signed-off-by: Justin Chen <justinpopo6@gmail.com>
> >---
> >  .../devicetree/bindings/watchdog/brcm,bcm7038-wdt.txt | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.txt
> >
> >diff --git a/Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.txt b/Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.txt
> >new file mode 100644
> >index 0000000..adb8260
> >--- /dev/null
> >+++ b/Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.txt
> >@@ -0,0 +1,19 @@
> >+BCM7038 Watchdog timer
> >+
> >+Required properties:
> >+
> >+- compatible : should be "brcm,bcm7038-wdt"
> >+- reg : Specifies base physical address and size of the registers.
> >+
> >+Optional properties:
> >+
> >+- clocks: the clock running the watchdog
> >+- clock-frequency: the rate of the clock
> 
> Is 'clock-frequency' really needed (and useful), or would it make more sense
> to expect the user to configure a fixed clock if nothing else is available ?
> How do other drivers handle this ?
> 
> Thanks,
> Guenter
> 
> >+
> >+Example:
> >+
> >+watchdog {
> >+	compatible = "brcm,bcm7038-wdt";
> >+	clocks = <&upg_fixed>;
> >+	reg = <0xf040a7e8 0x16>;
> >+};
> >
>

Hello Guenter,

> Is 'clock-frequency' really needed (and useful), or would it make more sense
> to expect the user to configure a fixed clock if nothing else is available ?
> How do other drivers handle this ?

The reason for 'clock-frequency' was for a case where our device tree did not
have clocks. Creating a new fixed clock for a single device seems unnecessary
compared to a 'clock-frequency' property. Their is a use for 'clock-frequency',
but it is not really necessary. However, this is my first linux patch, so I do 
not fully trust my judgement on this...

Looking at other drivers, none of them have both clock and clock-frequency.

Thank you for your time on reviewing the patch Guenter. Much appreciated!

Thanks,
Justin Chen
