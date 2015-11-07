Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46244 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753669AbbKGQhn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 7 Nov 2015 11:37:43 -0500
Subject: Re: [PATCH v2 1/4] watchdog: meson: Enable meson SoC specific data
To: Carlo Caione <carlo@caione.org>
References: <1446894139-6802-1-git-send-email-carlo@caione.org>
 <1446894139-6802-2-git-send-email-carlo@caione.org>
 <563E18F0.4030807@roeck-us.net>
 <CAOQ7t2a1KBUbTvtcu7ajyX35Kx1khtYHc8pGmYdYC=872oNMQA@mail.gmail.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	Daniel Drake <drake@endlessm.com>,
	Jerry Cao <jerry.cao@amlogic.com>,
	Victor Wan <victor.wan@amlogic.com>,
	Romain Perier <romain.perier@gmail.com>,
	Carlo Caione <carlo@endlessm.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <563E28D0.3070400@roeck-us.net>
Date: Sat, 7 Nov 2015 08:37:36 -0800
MIME-Version: 1.0
In-Reply-To: <CAOQ7t2a1KBUbTvtcu7ajyX35Kx1khtYHc8pGmYdYC=872oNMQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/07/2015 07:45 AM, Carlo Caione wrote:
> On Sat, Nov 7, 2015 at 4:29 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 11/07/2015 03:02 AM, Carlo Caione wrote:
>>>
>>> From: Carlo Caione <carlo@endlessm.com>
>>>
>>> With this patch we refactor the driver code to enable watchdog support
>>> for all platforms based on Amlogic meson SoCs.
>>>
>>> Signed-off-by: Carlo Caione <carlo@endlessm.com>
>>> ---
>>>    drivers/watchdog/meson_wdt.c | 56
>>> ++++++++++++++++++++++++++++++--------------
>>>    1 file changed, 39 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/watchdog/meson_wdt.c b/drivers/watchdog/meson_wdt.c
>>> index 1f4155e..446af94 100644
>>> --- a/drivers/watchdog/meson_wdt.c
>>> +++ b/drivers/watchdog/meson_wdt.c
>>> @@ -19,6 +19,7 @@
>>>    #include <linux/moduleparam.h>
>>>    #include <linux/notifier.h>
>>>    #include <linux/of.h>
>>> +#include <linux/of_device.h>
>>>    #include <linux/platform_device.h>
>>>    #include <linux/reboot.h>
>>>    #include <linux/types.h>
>>> @@ -27,35 +28,47 @@
>>>    #define DRV_NAME              "meson_wdt"
>>>
>>>    #define MESON_WDT_TC          0x00
>>> -#define MESON_WDT_TC_EN                BIT(22)
>>> -#define MESON_WDT_TC_TM_MASK   0x3fffff
>>>    #define MESON_WDT_DC_RESET    (3 << 24)
>>>
>>>    #define MESON_WDT_RESET               0x04
>>>
>>> -#define MESON_WDT_TIMEOUT      30
>>> +#define MESON_WDT_TIMEOUT      5
>>
>>
>> This is not a reasonable default, the change is not mentioned
>> in the description, and it is unrelated to the change at hand.
>
> The problem is that the default is too small or simply that the change
> is not mentioned?
>
Both.

> For the meson8b the maximum timeout is ~8 sec whereas for meson6 is
> ~40 sec that's why I lowered the default from 30 to 5 sec.
> I can set a different default for each SoC but at least for meson8b
> the value will be always < 8 sec.
>
Ok, but your change impacts both architectures. There is no reason
to hold meson6 hostage for the meson8b limitations.

An easy fix would be to set the actual timeout to min(default, max).

Thanks,
Guenter

