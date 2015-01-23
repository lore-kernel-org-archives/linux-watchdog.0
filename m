Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:60145 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbbAWQEA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 23 Jan 2015 11:04:00 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YEgiG-001GY5-KT
	for linux-watchdog@vger.kernel.org; Fri, 23 Jan 2015 16:04:01 +0000
Message-ID: <54C270C4.4010407@roeck-us.net>
Date: Fri, 23 Jan 2015 08:03:16 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Doug Anderson <dianders@chromium.org>,
	Jisheng Zhang <jszhang@marvell.com>
CC: Wim Van Sebroeck <wim@iguana.be>, Heiko Stuebner <heiko@sntech.de>,
	Lunxue Dai <lunxue.dai@rock-chips.com>,
	Dinh Nguyen <dinguyen@altera.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] watchdog: dw_wdt: pat the watchdog before enabling
 it
References: <1421882243-3631-1-git-send-email-dianders@chromium.org>	<20150122132200.4729d38b@xhacker> <CAD=FV=UMmfNAEQVKCxTBapwO=pgno+cWUJNiMS7_uFK7NPevkw@mail.gmail.com>
In-Reply-To: <CAD=FV=UMmfNAEQVKCxTBapwO=pgno+cWUJNiMS7_uFK7NPevkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/22/2015 09:09 AM, Doug Anderson wrote:
> Jisheng,
>
> On Wed, Jan 21, 2015 at 9:22 PM, Jisheng Zhang <jszhang@marvell.com> wrote:
>> Dear Doug,
>>
>> On Wed, 21 Jan 2015 15:17:22 -0800
>> Doug Anderson <dianders@chromium.org> wrote:
>>
>>> On some dw_wdt implementations the "top" register may be initted to 0
>>> at bootup.  In such a case, each "pat" of the watchdog will reset the
>>> timer to 0xffff.  That's pretty short.
>>
>> + Guenter Roeck
>>
>> This should have been fixed by dfa07141e7a792("watchdog: dw_wdt: initialise
>> TOP_INIT in dw_wdt_set_top()")
>
> I will admit that I'm testing on a tree that doesn't have your patch
> (I'm on a 3.14 kernel with lots of backports).  ...but I did try
> cherry-picking your patch before I wrote up mine and it didn't fix my
> problem.  I believe that the watchdog that's in Rockchip rk3288 must
> be a slightly different version of the IP block than you're working
> with.
>
> Specifically I see the register WDT_TORR that has an offset of 0x4.
> That's the RANGE_REG in your code.  It shows bits 3:0 set the timeout
> period (0 = 0xffff and 15 = 0x7fffffff).  It shows bits 31:4 as
> "reserved".
>
Not sure where that leaves us. Does that mean the driver supports different
hardware with different register sets ? Should that be documented in the driver,
and should we have (or do we need) different compatible statements for those
variants, and conditional code in the driver ?

And does it mean we need both patches, at least for some of the hardware
variants ? If so, what happens if those patches are applied and the resulting
driver runs on the other hardware ?

Thanks,
Guenter

