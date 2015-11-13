Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:51655 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934AbbKMSoQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 13 Nov 2015 13:44:16 -0500
Subject: Re: [PATCH 2/2] watchdog: gpio-wdt: Add panic notifier
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <1447062944-12296-1-git-send-email-alexander.stein@systec-electronic.com>
 <1447062944-12296-2-git-send-email-alexander.stein@systec-electronic.com>
 <5640B96D.6010408@roeck-us.net> <20151109190249.GG4931@pengutronix.de>
 <56412A14.60800@roeck-us.net> <20151110072031.GH4931@pengutronix.de>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56462F7D.4010809@roeck-us.net>
Date: Fri, 13 Nov 2015 10:44:13 -0800
MIME-Version: 1.0
In-Reply-To: <20151110072031.GH4931@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/09/2015 11:20 PM, Uwe Kleine-König wrote:
> Hello Guenter,
>
> On Mon, Nov 09, 2015 at 03:19:48PM -0800, Guenter Roeck wrote:
>> On 11/09/2015 11:02 AM, Uwe Kleine-König wrote:
>>> On Mon, Nov 09, 2015 at 07:19:09AM -0800, Guenter Roeck wrote:
>>>> On 11/09/2015 01:55 AM, Alexander Stein wrote:
>>>>> This notifier is required when the watchdog is configured as always running
>>>>> because in this case the watchdog will be triggered when the kernel panics
>>>>> at boot before any application could open the device, e.g. because the
>>>>> rootfs is broken. This should result in a resetting system. Thus we
>>>>> register a panic notifier which stops triggering the watchdog.
>>>>>
>>>>
>>>> Shouldn't the timer be stopped instead ?
>>>
>>> What do you mean saying "timer"? The hardware? This might or might not
>>> be possible.
>>>
>> I meant the timer referenced with the variable 'timer' in struct
>> gpio_wdt_priv, and "stop timer' would translate to somoething like
>> 'mod_timer(&priv->timer, 0);'.
>> Sorry for not being more specific.
>
> My feeling is that improving the gpio-wdt driver is the wrong way. I
> admit I lost track of the patch series that moves that handling into the
> watchdog core, what is the status here? There thinking more accurately

I got no further review comments, so it is stalled.

I think I may resubmit after -rc1 is out and then just ask Wim to accept
the series. I think it is in good enough shape that we can fix any left-over
problems (if any) separately.

Guenter

