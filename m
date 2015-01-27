Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57508 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753388AbbA0EIJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 26 Jan 2015 23:08:09 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YFxRh-003r1I-RV
	for linux-watchdog@vger.kernel.org; Tue, 27 Jan 2015 04:08:10 +0000
Message-ID: <54C70F24.5080100@roeck-us.net>
Date: Mon, 26 Jan 2015 20:08:04 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Jisheng Zhang <jszhang@marvell.com>,
	Doug Anderson <dianders@chromium.org>
CC: Wim Van Sebroeck <wim@iguana.be>, Heiko Stuebner <heiko@sntech.de>,
	Lunxue Dai <lunxue.dai@rock-chips.com>,
	Dinh Nguyen <dinguyen@altera.com>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] watchdog: dw_wdt: pat the watchdog before enabling
 it
References: <1422314836-30516-1-git-send-email-dianders@chromium.org> <20150127114909.204eeee0@xhacker>
In-Reply-To: <20150127114909.204eeee0@xhacker>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/26/2015 07:49 PM, Jisheng Zhang wrote:
> Dear Doug,
>
> On Mon, 26 Jan 2015 15:27:15 -0800
> Doug Anderson <dianders@chromium.org> wrote:
>
>> On some dw_wdt implementations the "top" register may be initted to 0
>> at bootup.  In such a case, each "pat" of the watchdog will reset the
>> timer to 0xffff.  That's pretty short.
>>
>> The input clock of the wdt can be any of a wide range of values.  On
>> an rk3288 system, I've seen the wdt clock be 24.75 MHz.  That means
>> each tick is ~40ns and we'll count to 0xffff in ~2.6ms.
>>
>> Because of the above two facts, it's a really good idea to pat the
>> watchdog after initting the "top" register properly and before
>> enabling the watchdog.  If you don't then there's no way we'll get the
>> next heartbeat in time.
>>
>> Jisheng Zhang fixed this problem on some dw_mmc versions by using the
>
> s/dw_mmc/dw_wdt
>
>> TOP_INIT feature.  However, the dw_wdt on rk3288 doesn't have TOP_INIT
>> so it's a good idea to also pat the watchdog manually.
>
> Based on your register dumping, I see the following configurations on rk3288:
>
> WDT_DUAL_TOP is configured as false, so there's no TOP_INIT
>
> WDT_DFLT_TOP is configured as 0, so it will timeout soon.
>
>
> So an extra pat is a must on such platforms with similar configurations. And it
> doesn't hurt anything if we have an extra pat before enabling the WDT
>
> All in all, except the "dw_mmc" typo above, the patch looks good to me.
>

Jisheng,

it would be great if you can provide configuration information shown in
the (undocumented) registers.

Doug,

can you send another version with this information added as comment
to the code ? This will help others to understand what is going on
(and why) later on.

Thanks,
Guenter

