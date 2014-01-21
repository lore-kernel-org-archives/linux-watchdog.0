Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:42622 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754042AbaAULou (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 21 Jan 2014 06:44:50 -0500
Message-ID: <52DE5DAD.7040308@gmail.com>
Date: Tue, 21 Jan 2014 12:44:45 +0100
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
CC: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: Removing PLAT_ORION dependency from ARCH_MVEBU (Was Re: [PATCH
 v2 14/15] watchdog: orion: Allow to build on any Orion platform)
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com> <1390295561-3466-15-git-send-email-ezequiel.garcia@free-electrons.com> <52DE40BD.10700@gmail.com> <20140121110603.GB4356@localhost>
In-Reply-To: <20140121110603.GB4356@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/21/14 12:06, Ezequiel Garcia wrote:
> Sebastian,
>
> I'm picking on this discussion, with a new Subject.
>
> On Tue, Jan 21, 2014 at 10:41:17AM +0100, Sebastian Hesselbarth wrote:
>> On 01/21/14 10:12, Ezequiel Garcia wrote:
>>> After getting rid of all the mach-specific code, it's now possible
>>> to allow builds in any Orion platform.
>>>
>>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>>> ---
>>>    drivers/watchdog/Kconfig | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>>> index 5be6e91..1689f72 100644
>>> --- a/drivers/watchdog/Kconfig
>>> +++ b/drivers/watchdog/Kconfig
>>> @@ -282,7 +282,7 @@ config DAVINCI_WATCHDOG
>>>
>>>    config ORION_WATCHDOG
>>>    	tristate "Orion watchdog"
>>> -	depends on ARCH_ORION5X || ARCH_KIRKWOOD || ARCH_DOVE
>>> +	depends on PLAT_ORION
> [..]
>>
>> I haven't checked why ARCH_MVEBU at all added PLAT_ORION as dependency,
>> but IIRC it was just because of a missing mbus driver? If it is just
>> this, we should also remove PLAT_ORION from ARCH_MVEBU to have a clean
>> cut between new common arch and existing sub-archs.
>>
>
> Well, I'm not sure if I'm following you. Many drivers currently depend
> on PLAT_ORION, so if we remove PLAT_ORION from ARCH_MVEBU we would have
> to replace: s/PLAT_ORION/ARCH_{MVEBU, KIRKWOOD, DOVE, ...}.
>
> Is this the suggested roadmap or I've completely misunderstood it?

Actually, you are right, PLAT_ORION is dependency for a bunch of
drivers. But as PLAT_ORION - code-wise - almost only contains non-DT
stuff, I'd prefer to use ARCH_MVEBU for DT enabled Marvell SoCs where
possible.

So for the above, just add ARCH_MVEBU and remove ARCH_KIRKWOOD,
ARCH_DOVE later when we kill them, instead of hiding all behind
PLAT_ORION. Also remove the dependency of ARCH_MVEBU to PLAT_ORION
where possible or replace it with ARCH_MVEBU directly.

This way we would have a clean ARCH_MVEBU config for DT-enabled
SoCs and PLAT_ORION for non-DT ones. BTW, there is also
PLAT_ORION_LEGACY which is just selecting PLAT_ORION. IIRC, I added
that to distinguish non-DT and DT earlier, but ARCH_MVEBU selecting
PLAT_ORION made that redundant.

Sebastian

