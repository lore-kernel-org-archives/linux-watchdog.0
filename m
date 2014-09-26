Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47066 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbaIZN6k (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 26 Sep 2014 09:58:40 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XXW2h-001Zcm-Hu
	for linux-watchdog@vger.kernel.org; Fri, 26 Sep 2014 13:58:39 +0000
Message-ID: <542570F2.4090908@roeck-us.net>
Date: Fri, 26 Sep 2014 06:58:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Chen-Yu Tsai <wens@csie.org>
CC: Wim Van Sebroeck <wim@iguana.be>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] watchdog: sunxi: support parameterized compatible
 strings
References: <1411315519-26257-1-git-send-email-wens@csie.org> <1411315519-26257-2-git-send-email-wens@csie.org> <541EFD9A.2000406@roeck-us.net> <CAGb2v66dv4TRKB3LDksTudYPQThOV9NaEZDByZVSqedDOjekwQ@mail.gmail.com>
In-Reply-To: <CAGb2v66dv4TRKB3LDksTudYPQThOV9NaEZDByZVSqedDOjekwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/26/2014 01:29 AM, Chen-Yu Tsai wrote:
> On Mon, Sep 22, 2014 at 12:32 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 09/21/2014 09:05 AM, Chen-Yu Tsai wrote:
>>>
>>> This patch adds support for hardware parameters tied to compatible
>>> strings, so similar hardware can reuse the driver.
>>>
>>> This will be used to support the newer watchdog found in A31 and
>>> later SoCs. Differences in the new hardware include separate
>>> interrupt lines for each watchdog, and corresponding interrupt
>>> control/status registers. Watchdog control registers were also
>>> slightly rearranged.
>>>
>>> Also replace ioread32()/iowrite32() with readl()/writel() in various
>>> places changed.
>>>
>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>
>>
>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>
>
> Hi Guenter,
>
> Are you submitting the restart handler patches for inclusion in 3.18?

Yes, should go in through Andrew's tree or through one of the branches
depending on it.

> If so, are you taking any related patches or patches depending on
> that series?
>
In general no, but I just sent a pull request pointing to an immutable branch
containing the series. Affected maintainers should merge this branch into
the affected subject branch(es).

I do have a number of related patches in my watchdog-next branch. I'll send
an updated pull request with those to Wim later today.

Thanks,
Guenter

