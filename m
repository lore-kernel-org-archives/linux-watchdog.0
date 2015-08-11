Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:33196 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933629AbbHKHjQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 11 Aug 2015 03:39:16 -0400
Received: by ykaz130 with SMTP id z130so52783210yka.0
        for <linux-watchdog@vger.kernel.org>; Tue, 11 Aug 2015 00:39:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55C97D2C.6090505@roeck-us.net>
References: <1437630551-39650-1-git-send-email-eddie.huang@mediatek.com>
 <1437630551-39650-3-git-send-email-eddie.huang@mediatek.com>
 <1488521.5eJqASov2O@ubix> <CAGS+omD1UYSTfJ4-vZSE_BYuvGcTvpbC7T4ukaV10xuQxkCChg@mail.gmail.com>
 <55C97D2C.6090505@roeck-us.net>
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Tue, 11 Aug 2015 15:38:55 +0800
Message-ID: <CAGS+omASBsbMJT0CM5O3SsxTzu52uSW=7jhP9i2m3QWYeu8A3A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] watchdog: add wdt shutdown callback to disable wdt
 if enabled
To: Guenter Roeck <linux@roeck-us.net>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	Eddie Huang <eddie.huang@mediatek.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	linux-mediatek@lists.infradead.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Greta Zhang <greta.zhang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Aug 11, 2015 at 12:42 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 08/10/2015 09:28 PM, Daniel Kurtz wrote:
>>
>> Hi Guenter, Matthias,
>>
>> On Fri, Jul 24, 2015 at 1:37 AM, Matthias Brugger
>> <matthias.bgg@gmail.com> wrote:
>>>
>>> On Thursday, July 23, 2015 01:49:11 PM Eddie Huang wrote:
>>>>
>>>> From: Greta Zhang <greta.zhang@mediatek.com>
>>>>
>>>> Without .shutdown(), watchdog might reset the system during power off.
>>>> For example, if watchdog's timeout is set to 30s, then it is reset to
>>>> zero by mtk_wdt_ping(). During power off, no app will ping watchdog,
>>>> but watchdog is still running and may trigger reset.
>>>>
>>>> Signed-off-by: Greta Zhang <greta.zhang@mediatek.com>
>>>> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
>>>> ---
>>>>   drivers/watchdog/mtk_wdt.c | 9 +++++++++
>>>>   1 file changed, 9 insertions(+)
>>>
>>>
>>> Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
>>
>>
>> is the plan to land these two patches via Guenter's watchdog tree [0]?
>> [0] git://www.linux-watchdog.org/linux-watchdog.git
>>
> That is Wim's tree, and Wim is the maintainer ;-).

No wonder!  Thanks for cluing me in.

> I have the patches queued in my tree [1], and I plan to send a pull request
> to Wim this week or early next week.

Great!

Thanks,
-Dan

> Guenter
>
> ---
> [1]
> https://git.kernel.org/cgit/linux/kernel/git/groeck/linux-staging.git/log/?h=watchdog-next
>
