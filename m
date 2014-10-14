Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:48314 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754166AbaJNTAb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 14 Oct 2014 15:00:31 -0400
Message-ID: <543D72DD.4000501@wwwdotorg.org>
Date: Tue, 14 Oct 2014 13:00:45 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>
CC: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-watchdog@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 2/2] clocksource: tegra: Register watchdog device
References: <1413201922-4210-1-git-send-email-thierry.reding@gmail.com> <1413201922-4210-2-git-send-email-thierry.reding@gmail.com> <543C00E2.2090806@roeck-us.net> <20141014104218.GG18993@ulmo>
In-Reply-To: <20141014104218.GG18993@ulmo>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/14/2014 04:42 AM, Thierry Reding wrote:
> On Mon, Oct 13, 2014 at 09:42:10AM -0700, Guenter Roeck wrote:
>> On 10/13/2014 05:05 AM, Thierry Reding wrote:
>>> From: Thierry Reding <treding@nvidia.com>
>>>
>>> The watchdog timer is part of the timer controller block on Tegra. In
>>> order to avoid access to the same registers from two drivers, register
>>> the watchdog device from the clocksource driver.
>>>
>>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>>
>> Does that really make sense ?
>>
>> A couple of callbacks into the clock driver to implement register accesses
>> might be a better approach.
>
> I guess that would be a valid approach as well. It has the downside of
> requiring the addition of at least two globally visible symbols to the
> kernel. It also means that we'd need to somehow pass around a struct
> device for diagnostic messages and so on. Dealing with all of that seems
> like much more of a burden than this.
>
> Also if you look at the diffstat this approach allows us to get rid of
> 80 lines of code. Adding a custom mechanism to share the register space
> would be more likely to result in a positive diffstat.

FWIW, (although I haven't read the patches), the general idea of 
registering a single driver for each HW block makes sense to me. While 
we've split up HW blocks into separate drivers in the past, I think 
that's just made things more complex without much benefit, so I think 
those decisions were a mistake in retrospect. If we do actually need to 
split things up into separate drivers, we should use MFD rather than 
multiple unrelated top-level drivers. That way, we will have a single 
top-level driver that gets instantiated from a single DT node (or 
platform device in a board file or ACPI thing or ...)
