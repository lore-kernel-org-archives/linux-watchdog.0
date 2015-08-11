Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:33103 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbbHKE3C (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 11 Aug 2015 00:29:02 -0400
Received: by ykaz130 with SMTP id z130so50239763yka.0
        for <linux-watchdog@vger.kernel.org>; Mon, 10 Aug 2015 21:29:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1488521.5eJqASov2O@ubix>
References: <1437630551-39650-1-git-send-email-eddie.huang@mediatek.com>
 <1437630551-39650-3-git-send-email-eddie.huang@mediatek.com> <1488521.5eJqASov2O@ubix>
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Tue, 11 Aug 2015 12:28:41 +0800
Message-ID: <CAGS+omD1UYSTfJ4-vZSE_BYuvGcTvpbC7T4ukaV10xuQxkCChg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] watchdog: add wdt shutdown callback to disable wdt
 if enabled
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Eddie Huang <eddie.huang@mediatek.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
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

Hi Guenter, Matthias,

On Fri, Jul 24, 2015 at 1:37 AM, Matthias Brugger
<matthias.bgg@gmail.com> wrote:
> On Thursday, July 23, 2015 01:49:11 PM Eddie Huang wrote:
>> From: Greta Zhang <greta.zhang@mediatek.com>
>>
>> Without .shutdown(), watchdog might reset the system during power off.
>> For example, if watchdog's timeout is set to 30s, then it is reset to
>> zero by mtk_wdt_ping(). During power off, no app will ping watchdog,
>> but watchdog is still running and may trigger reset.
>>
>> Signed-off-by: Greta Zhang <greta.zhang@mediatek.com>
>> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
>> ---
>>  drivers/watchdog/mtk_wdt.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>
> Acked-by: Matthias Brugger <matthias.bgg@gmail.com>

is the plan to land these two patches via Guenter's watchdog tree [0]?
[0] git://www.linux-watchdog.org/linux-watchdog.git

In fact, though, I don't see any new patches in that repository.
The only branches I see are:
  remotes/wdog/master                                      b953c0d Linux 4.1
  remotes/wdog/winbond-superio                             dc89871
Sample Winbond Super-I/O MFD device consisting out of a lowel-level
driver that does the detection and creates the platform-data and a
watchdog driver.

Am I looking in the wrong place?

-Dan

> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
