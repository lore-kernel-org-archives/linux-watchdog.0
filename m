Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:54003 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbeLIMOx (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 9 Dec 2018 07:14:53 -0500
Date: Sun, 9 Dec 2018 13:14:01 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org
Cc: linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Message-ID: <53380420.68255.1544357641824@email.ionos.de>
In-Reply-To: <20181130202743.20585-2-eric@anholt.net>
References: <20181130202743.20585-1-eric@anholt.net>
 <20181130202743.20585-2-eric@anholt.net>
Subject: Re: [PATCH v3 1/5] dt-bindings: soc: Add a new binding for the
 BCM2835 PM node.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Eric,

[add Sebastian]

> Eric Anholt <eric@anholt.net> hat am 30. November 2018 um 21:27 geschrieben:
> 
> 
> This binding supersedes the bcm2835-pm-wdt binding which only covered
> enough to provide a watchdog, but the HW block is actually mostly
> about power domains.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  .../bindings/soc/bcm/brcm,bcm2835-pm.txt      | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
> 
> diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
> new file mode 100644
> index 000000000000..7818d33a158f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.txt
> @@ -0,0 +1,42 @@
> +BCM2835 PM (Power domains, watchdog)
> +
> +The PM block controls power domains and some reset lines, and includes
> +a watchdog timer.  This binding supersedes the brcm,bcm2835-pm-wdt
> +binding which covered some of PM's register range and functionality.
> +
> +Required properties:
> +
> +- compatible:		Should be "brcm,bcm2835-pm"
> +- reg:			Specifies base physical address and size of the two
> +			  register ranges ("PM" and "ASYNC_BRIDGE" in that
> +			  order)
> +- clocks:		a) v3d: The V3D clock from CPRMAN
> +			b) peri_image: The PERI_IMAGE clock from CPRMAN
> +			c) h264: The H264 clock from CPRMAN
> +			d) isp: The ISP clock from CPRMAN
> +- #reset-cells: 	Should be 1.  This property follows the reset controller
> +			  bindings[1].
> +- #power-domain-cells:	Should be 1.  This property follows the power domain
> +			  bindings[2].
> +
> +Optional properties:
> +
> +- timeout-sec:	Contains the watchdog timeout in seconds
> +
> +[1] Documentation/devicetree/bindings/reset/reset.txt
> +[2] Documentation/devicetree/bindings/power/power_domain.txt
> +

sorry for my late reply. I hope we can take the opportunity of a new binding to fix an old issue of the bcm2835-wdt driver. The watchdog driver sets the pm_power_off callback without checking for "system-power-controller" property [3]. As a result we can't use another poweroff controller like e.g. gpio-poweroff. In downstream this has been workarounded by an additional devicetree property for the gpio-poweroff driver [4]. But this isn't the right way because the issue is in the bcm2835 watchdog driver not in all the other reset controller.

Suggested pseudo code:

if (!pm_power_off) {
    /* Preserve the old behavior of watchdog driver in case of old DTB */
    if (!of_device_is_compatible(dev->of.node, "brcm,bcm2835-pm") ||
        of_device_is_system_power_controller(dev->of.node))
        pm_power_off = bcm2835_power_off;
}

Best regards
Stefan

[3] - https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/power/power-controller.txt
[4] - https://github.com/raspberrypi/linux/commit/f86dcfac0a4e478fee40b5a3729ff1b159ae91ee
