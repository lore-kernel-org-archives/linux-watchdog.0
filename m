Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46079 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751108AbdFUGfx (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 21 Jun 2017 02:35:53 -0400
References: <cover.50aaf23e8fbe9028f711a67e39b96910c986e8b0.1495443015.git-series.s.trumtrar@pengutronix.de> <738tknf5zp.fsf@pengutronix.de> <a6d32d71-6f66-18af-5283-036bf1ef93ce@roeck-us.net>
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Dinh Nguyen <dinguyen@opensource.altera.com>,
        linux-arm-kernel@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>, kernel@pengutronix.de
Subject: Re: [PATCH v4 0/3] watchdog: dw_wdt: add reset lines
In-reply-to: <a6d32d71-6f66-18af-5283-036bf1ef93ce@roeck-us.net>
Date: Wed, 21 Jun 2017 08:35:39 +0200
Message-ID: <737f05g85g.fsf@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


Guenter Roeck <linux@roeck-us.net> writes:

> On 06/20/2017 12:55 AM, Steffen Trumtrar wrote:
>> 
>> Steffen Trumtrar <s.trumtrar@pengutronix.de> writes:
>> 
>>> Hi!
>>>
>>> This series adds support for the reset line that is (potentially) holding
>>> the watchdog in reset.
>>>
>>> As the watchdog is useless if this happens, it needs to be deasserted in
>>> the probe function.
>>>
>>> Tested on a Socrates board.
>>>
>>> Regards,
>>> Steffen
>>>
>>>
>>> Changes since v3:
>>>
>>>    - goto out_disable_clk
>>>    - add Reviewed-by
>>>
>>> Changes since v2:
>>>
>>>    - use optional reset functions
>>>    - add Acked-by to devictree bindings
>>>
>>> Changes since v1:
>>>
>>>    - remove reset-names property
>>>    - remove warning if reset property is missing
>>>
>>> Steffen Trumtrar (3):
>>>    watchdog: bindings: dw_wdt: add reset lines
>>>    watchdog: dw_wdt: get reset lines from dt
>>>    ARM: socfpga: dtsi: add dw-wdt reset lines
>>>
>>>   Documentation/devicetree/bindings/watchdog/dw_wdt.txt |  3 +++
>>>   arch/arm/boot/dts/socfpga.dtsi                        |  2 ++
>>>   drivers/watchdog/dw_wdt.c                             | 11 +++++++++++
>>>   3 files changed, 16 insertions(+)
>>>
>>> base-commit: 2ea659a9ef488125eb46da6eb571de5eae5c43f6
>> 
>> Gentle Ping!
>> 
>> Is this series already applied somewhere I didn't look?
>> 
>
> https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git/log/?h=watchdog-next
>
>  From there, we can only hope that Wim will find the time to pick it up for the next release.

Ah, somewhere I didn't look :) Thanks.

Best regards,
Steffen

-- 
Pengutronix e.K.                           | Steffen Trumtrar            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
