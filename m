Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59113 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965996AbcAZOnG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 Jan 2016 09:43:06 -0500
Subject: Re: [PATCH v7 0/9] watchdog: Add support for keepalives triggered by
 infrastructure
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
	Guenter Roeck <patchwork@patchwork.roeck-us.net>
References: <1453776796-3885-1-git-send-email-patchwork@patchwork.roeck-us.net>
 <20160126080904.GV3338@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	linux-doc@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56A785F6.9000008@roeck-us.net>
Date: Tue, 26 Jan 2016 06:43:02 -0800
MIME-Version: 1.0
In-Reply-To: <20160126080904.GV3338@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Uwe,

On 01/26/2016 12:09 AM, Uwe Kleine-König wrote:
> Hello Guenter,
>
> On Mon, Jan 25, 2016 at 06:53:07PM -0800, Guenter Roeck wrote:
>> Patch #1 adds timer functionality to the watchdog core. It solves the problem
>> of short maximum hardware timeouts by augmenting heartbeats triggered from
>> user space with internally triggered heartbeats.
>>
>> Patch #2 adds functionality to generate heartbeats while the watchdog device
>> is closed. It handles situation where where the watchdog is running after
>> the driver has been instantiated, but the device is not yet opened,
>> and post-close situations necessary if a watchdog can not be stopped.
>>
>> Patch #3 makes the set_timeout function optional. This is now possible since
>> timeout changes can now be completely handled in the watchdog core, for
>> example if the hardware watchdog timeout is fixed.
>>
>> Patch #4 adds code to ensure that the minimum time between heartbeats meets
>> constraints provided by the watchdog driver.
>>
>> Patch #5 simplifies the watchdog_update_worker() function introduced with
>> patch #1 to only take a single argument, and to always cancel any pending
>> work if a worker is not or no longer needed. This patch is kept as separate
>> patch on purpose, to enable dropping or reverting it easily if it causes
>> any problems. It should not cause any problems; this is just out of an
>> abundance of caution.
>
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de> for patches
> 1-5.
>

Thanks a lot for your time!

Guenter

