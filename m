Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35942 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933635AbbHDPB2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 4 Aug 2015 11:01:28 -0400
Message-ID: <55C0D3C2.6020709@roeck-us.net>
Date: Tue, 04 Aug 2015 08:01:22 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
CC: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/8] watchdog: Add support for keepalives triggered by
 infrastructure
References: <1438654414-29259-1-git-send-email-linux@roeck-us.net> <20150804112431.GK9999@pengutronix.de>
In-Reply-To: <20150804112431.GK9999@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Uwe,

On 08/04/2015 04:24 AM, Uwe Kleine-König wrote:
> Hello Guenter,
>
> On Mon, Aug 03, 2015 at 07:13:26PM -0700, Guenter Roeck wrote:
>> This patch set does not solve all limitations of the watchdog subsystem.
>> Specifically, it does not add support for the following features.
>>
>> - It is desirable to be able to specify a maximum early timeout,
>>    from booting the system to opening the watchdog device.
>> - Some watchdogs may require a minimum period of time between
>>    heartbeats. Examples are DA9062 and possibly AT91SAM9x.
>
> Other things that come to my mind:
>   - move handling of nowayout into the core
>   - some drivers use a reboot notifier. Not sure what they are intended
>     to do there. For i.MX2x it triggers a reboot; for gpio-wdt it tries
>     to stop the watchdog.
>
Be careful - those are different functions. The imx2 driver installs
a _restart_ handler, which indeed is supposed to restart the system.
The gpio wdt driver installs a _reboot_ notifier, which is supposed to
stop the watchdog. Other drivers install a shutdown callback in the
platform driver structure to do the same; not really sure what is better.

> Of course this doesn't mean this should addressed here. I like the
> series in general.
>

The list wasn't supposed to be exhaustive. Otherwise adding "support devm"
should have been there as well. I even have a patch hanging around somewhere
to do that. Guess I should have said something like "does not solve all
timeout related limitations ...".

Thanks,
Guenter

