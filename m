Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56228 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755316AbcECNrc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 3 May 2016 09:47:32 -0400
Subject: Re: [PATCH RFC] Watchdog: sbsa_gwdt: Enhance timeout range
To: Pratyush Anand <panand@redhat.com>,
	Timur Tabi <timur@codeaurora.org>
References: <20da73bb9bdf27993514c1da80fead13dc92932d.1462262900.git.panand@redhat.com>
 <57289594.3050801@codeaurora.org> <20160503132439.GC13045@dhcppc6.redhat.com>
Cc: fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com, wim@iguana.be,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5728ABE0.5040000@roeck-us.net>
Date: Tue, 3 May 2016 06:47:12 -0700
MIME-Version: 1.0
In-Reply-To: <20160503132439.GC13045@dhcppc6.redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/03/2016 06:24 AM, Pratyush Anand wrote:
> On 03/05/2016:07:12:04 AM, Timur Tabi wrote:
>> Pratyush Anand wrote:
>>> + * Note: This watchdog timer has two stages. If action is 0, first stage is
>>> + * determined by directly programming WCV and second by WOR. When first
>>> + * timeout is reached, WS0 is triggered and WCV is reloaded with value in
>>> + * WOR. WS0 interrupt will be ignored, then the second watch period starts;
>>> + * when second timeout is reached, then WS1 is triggered, system resets. WCV
>>> + * and WOR are programmed in such a way that total time corresponding to
>>> + * WCV+WOR becomes equivalent to user programmed "timeout".
>>> + * If action is 1, then we expect to call panic() at user programmed
>>> + * "timeout". Therefore, we program both first and second stage using WCV
>>> + * only.
>>
>> So I'm not sure I understand how this works yet, but there was an earlier
>> version of Fu's driver that did something similar.  It depended on being
>> able to reprogram the hardware during the WS0 interrupt, and that was
>> rejected by the community.
>>
>> How is what you are doing different?
>
> * Following was the comment for Fu Wei's primitive version of patch [1], because
> * of which community rejected it.
>
>> The triggering of the hardware reset should never depend on an interrupt being
>> handled properly.  You should always program WCV correctly in advance.
>
> Now, there are couple of things different:
>
> (1) There is an important difference in upstreamed version than the version [1]
> which was rejected on above ground. In upstreamed version,  there would be no
> interrupt handler when we are in normal mode ie action=0.  So, there is no
> possibility of doing any thing in ISR for all normal usage of this timer. In
> this mode WCV is always programmed well in advance now.
>
> (2)action=1 mechanism was introduced to implement a dump saving mechanism if
> watchdog timeout expires before next kick. So, the current upstream version
> calls panic() in ISR. When action=1, then we do write WCV now in ISR, but there
> too some precaution have been taken.
>
> When action=1, and we land into isr handler sbsa_gwdt_interrupt() we can not
> trust watchdog data structure any more. That might have been corrupted.

Why ?

> (i) So it might happen that gwdt or wdd pointers have a corrupted value and as
> soon as we access gwdt->wdd or wdd->timeout, kernel panics. *No harm*, just
> panic() is called a bit early, which dump saving mechanism would be able to
> find. So, in fact it will give an extra information to dump saving mechanism
> that watchdog structure was corrupted as well.
> (ii) Another case, It might happen that wdd->timeout has been corrupted with
> large values. This patch does a protection while programming WCV in ISR. It

How would wdd->timeout be corrupted ?

If what you are say is correct, the interrupt handler can not be trusted, period,
and should be disabled entirely.

Guenter

> checks wdd->timeout against MAX_TIMEOUT value and reprograms WCV only when
> wdd->timeout is lesser than MAX_TIMEOUT. So, here too, there would be watchdog
> reset for sure if dump saving mechanism hangs.
>
> ~Pratyush
>
> [1] https://lists.linaro.org/pipermail/linaro-acpi/2015-June/004956.html
>

