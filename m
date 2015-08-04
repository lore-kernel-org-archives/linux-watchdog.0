Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46843 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770AbbHDP4V (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 4 Aug 2015 11:56:21 -0400
Message-ID: <55C0E0A1.4060601@roeck-us.net>
Date: Tue, 04 Aug 2015 08:56:17 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
CC: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	kernel@pengutronix.de
Subject: Re: [PATCH 3/8] watchdog: Introduce WDOG_RUNNING flag
References: <1438654414-29259-1-git-send-email-linux@roeck-us.net> <1438654414-29259-4-git-send-email-linux@roeck-us.net> <20150804154104.GT9999@pengutronix.de>
In-Reply-To: <20150804154104.GT9999@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Uwe,

On 08/04/2015 08:41 AM, Uwe Kleine-König wrote:
> Hello,
>
> On Mon, Aug 03, 2015 at 07:13:29PM -0700, Guenter Roeck wrote:
>> The WDOG_RUNNING flag is expected to be set by watchdog drivers if
>> the hardware watchdog is running. If the flag is set, the watchdog
>> subsystem will ping the watchdog even if the watchdog device is closed.
>>
>> The watchdog driver stop function is now optional and may be omitted
>> if the watchdog can not be stopped. If stopping the watchdog is not
>> possible but the driver implements a stop function, it is responsible
>> to set the WDOG_RUNNING flag in its stop function.
>>
>> Cc: Timo Kokkonen <timo.kokkonen@offcode.fi>
>> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   Documentation/watchdog/watchdog-kernel-api.txt | 19 ++++++++-----
>>   drivers/watchdog/watchdog_core.c               |  2 +-
>>   drivers/watchdog/watchdog_dev.c                | 39 ++++++++++++++++++++------
>>   include/linux/watchdog.h                       |  7 +++++
>>   4 files changed, 50 insertions(+), 17 deletions(-)
> Another thing that I noticed just now after looking at a later patch in
> this series: Conceptually that worker stuff better fits into
> watchdog_core.c than watchdog_dev.c, doesn't it? But maybe this
> separation doesn't make sense anyhow?
>

I actually started with that approach.

Problem is that the functionality added by the patch set is to a large degree
associated with code in watchdog_dev.c. I would have to export static functions
from watchdog_dev.c (such as _watchdog_ping), and I would have to export some
of the worker functions (such as watchdog_update_worker) if the code would be
in watchdog_core.c.

On the other side, when adding the code to watchdog_dev.c, I did not have to
export any functions. So adding the code there seemed to make more sense to me.

Thanks,
Guenter

