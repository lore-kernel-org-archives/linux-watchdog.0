Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57592 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754446AbbHXMuG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 24 Aug 2015 08:50:06 -0400
Message-ID: <55DB12F3.3020100@roeck-us.net>
Date: Mon, 24 Aug 2015 05:49:55 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Chen-Yu Tsai <wens@csie.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Wim Van Sebroeck <wim@iguana.be>
CC: Francesco Lavra <francescolavra.fl@gmail.com>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] watchdog: sunxi: fix activation of system reset
References: <55B32BCE.5050506@gmail.com> <20150726193238.GM2564@lukather> <CAGb2v66oZH_OifuUkzjJS3B5L-uBOaNMWZ7xhgF01EjrkuEq6g@mail.gmail.com>
In-Reply-To: <CAGb2v66oZH_OifuUkzjJS3B5L-uBOaNMWZ7xhgF01EjrkuEq6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/24/2015 02:25 AM, Chen-Yu Tsai wrote:
> Hi,
>
> On Mon, Jul 27, 2015 at 3:32 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
>> On Sat, Jul 25, 2015 at 08:25:18AM +0200, Francesco Lavra wrote:
>>> Commit f2147de33470 ("watchdog: sunxi: support parameterized compatible
>>> strings") introduced a regression in sunxi_wdt_start(), by which
>>> the system reset function of the watchdog is not enabled upon
>>> starting the watchdog. As a result, the system is not reset when the
>>> watchdog expires. Fix it.
>>>
>>> Signed-off-by: Francesco Lavra <francescolavra.fl@gmail.com>
>>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>> Fixes: f2147de33470 ("watchdog: sunxi: support parameterized compatible strings")
>>> Cc: stable@vger.kernel.org
>>
>> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>
> What tree should this go in through?
> Guenter, are you still taking watchdog patches?
>

The patch is included in the pull request I sent to Wim last week [1].

Guenter

---
[1] http://www.spinics.net/lists/linux-watchdog/msg07219.html

