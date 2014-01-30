Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f48.google.com ([74.125.83.48]:61159 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbaA3WA5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 30 Jan 2014 17:00:57 -0500
Message-ID: <52EACB92.2080700@gmail.com>
Date: Thu, 30 Jan 2014 23:00:50 +0100
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>
CC: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 00/20] Armada 370/XP watchdog support
References: <1390836440-12744-1-git-send-email-ezequiel.garcia@free-electrons.com> <20140129181949.GB27143@localhost> <20140130205315.GD29184@titan.lakedaemon.net> <20140130215056.GA1063@localhost>
In-Reply-To: <20140130215056.GA1063@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/30/2014 10:50 PM, Ezequiel Garcia wrote:
> On Thu, Jan 30, 2014 at 03:53:15PM -0500, Jason Cooper wrote:
>> Ezequiel,
>>
>> On Wed, Jan 29, 2014 at 03:19:50PM -0300, Ezequiel Garcia wrote:
>>> On Mon, Jan 27, 2014 at 12:27:00PM -0300, Ezequiel Garcia wrote:
>>>> A new round, mostly fixing some minor nitpicks.
>>>>
>>>
>>> If anyone wants to give this a test, here's a public branch:
>>>
>>> https://github.com/MISL-EBU-System-SW/mainline-public/tree/wdt_for_v3.14_v5
>>
>> I just took a quick glance at this (commit oneliners/tags) and there
>> doesn't appear to be any dependence on Sebastian's series.  Did I miss
>> something?
>>
>
> True, I've completely missed that. I pushed the branch in a rush!
>
> Let me prepare a v6, fixing the remaining issue pointed out by Russell,
> and push again (together with Sebastian's irqchip fixes).

Umm, no. Just directly name irqchip-orion fixes. Jason will send a PR
for irqchip-fixes _with-in_ v3.14 while watchdog will go into v3.15.

Or are there any plans to get watchdog in *now*?

In any way, do not include my patches into your set.

Jason: Ezequiel's watchdog patches install an irq handler that will
panic(TM) on a watchdog irq. irqchip-orion does not properly clear
stale bridge irqs which could signal a watchdog irq left by bootloader
(or watchdog triggering between bootloader and driver probe).

Sebastian
