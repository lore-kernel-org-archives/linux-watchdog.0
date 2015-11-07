Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58589 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753331AbbKGACq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 6 Nov 2015 19:02:46 -0500
Subject: Re: [PATCH 1/4] watchdog: meson: Enable meson SoC specific data
To: Carlo Caione <carlo@endlessm.com>
References: <1446846906-31520-1-git-send-email-carlo@caione.org>
 <1446846906-31520-2-git-send-email-carlo@caione.org>
 <20151106221519.GB19791@roeck-us.net>
 <CAL9uMOH4i4ajkF2x7agHe2WZcHTJ=vs9cO+TGx8WGLOFVLZnig@mail.gmail.com>
Cc: Carlo Caione <carlo@caione.org>, wim@iguana.be,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	robh+dt@kernel.org, Daniel Drake <drake@endlessm.com>,
	Jerry Cao <jerry.cao@amlogic.com>,
	Victor Wan <victor.wan@amlogic.com>, romain.perier@gmail.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <563D3FA3.8020305@roeck-us.net>
Date: Fri, 6 Nov 2015 16:02:43 -0800
MIME-Version: 1.0
In-Reply-To: <CAL9uMOH4i4ajkF2x7agHe2WZcHTJ=vs9cO+TGx8WGLOFVLZnig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/06/2015 02:47 PM, Carlo Caione wrote:
> On Fri, Nov 6, 2015 at 11:15 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>
[ ... ]

>>>
>>>   static int meson_restart_handle(struct notifier_block *this, unsigned long mode,
>>>                                void *cmd)
>>>   {
>>> -     u32 tc_reboot = MESON_WDT_DC_RESET | MESON_WDT_TC_EN;
>>> +     u32 tc_reboot = MESON_WDT_DC_RESET;
>>>        struct meson_wdt_dev *meson_wdt = container_of(this,
>>>                                                       struct meson_wdt_dev,
>>>                                                       restart_handler);
>>> +     tc_reboot |= BIT(meson_wdt->data->shift_enable);
>>>
>>
>> I am quite sure that this results in a checkpatch warning.
>> Did you run your patch through checkpatch ?
>
> Yeah, no error/warnings on that line.
>

There should be a warning since there is no empty line after the declarations.
Maybe checkpatch doesn't catch it because of the continuation line above.

Still, the extra line would be appreciated.

Thanks,
Guenter

