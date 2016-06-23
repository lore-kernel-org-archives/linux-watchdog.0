Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42134 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743AbcFWNiP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 23 Jun 2016 09:38:15 -0400
Subject: Re: [PATCH v2 0/2] Correct iTCO Watchdog for Apollo Lake
To: Darren Hart <dvhart@infradead.org>
References: <1463541972-19758-1-git-send-email-jonathan.yong@intel.com>
 <1466123817-50679-1-git-send-email-jonathan.yong@intel.com>
 <576A19BC.4000502@intel.com> <576A299D.5010300@roeck-us.net>
 <20160623050218.GC3379@f23x64.localdomain>
Cc: "Yong, Jonathan" <jonathan.yong@intel.com>,
	linux-watchdog@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, qipeng.zha@intel.com,
	linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <576BE633.3040104@roeck-us.net>
Date: Thu, 23 Jun 2016 06:37:55 -0700
MIME-Version: 1.0
In-Reply-To: <20160623050218.GC3379@f23x64.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/22/2016 10:02 PM, Darren Hart wrote:
> On Tue, Jun 21, 2016 at 11:01:01PM -0700, Guenter Roeck wrote:
>> On 06/21/2016 09:53 PM, Yong, Jonathan wrote:
>>> On 06/17/2016 08:36, Yong, Jonathan wrote:
>>>> These patches fix the iTCO watchdog for Apollo Lake.
>>>> I changed the watchdog memory io to only use 4 bytes rather
>>>> the whole region, I'm not sure if that is the correct way.
>>>>
>>>> The previous 0x30h offset in intel_pmc_ipc.c was for based
>>>> on the earlier BXT-M platform. Apollo Lake has it at 0x40h.
>>>>
>>>> Let me know if the patches need changes.
>>>> Please CC me as I am not subscribed, thanks.
>>>>
>>>> * Resent, typo in linux-kernel email address
>>>>
>>>> Changes since v1:
>>>>      * Watchdog NO_REBOOT bit off-by-one corrected.
>>>>
>>>> Yong, Jonathan (2):
>>>>     watchdog: iTCO-wdt handle 5th variation for Apollo Lake
>>>>     x86: Fix Apollo Lake Watchdog address in PMC driver
>>>>
>>>>    drivers/platform/x86/intel_pmc_ipc.c | 10 ++++++----
>>>>    drivers/watchdog/iTCO_wdt.c          |  2 ++
>>>>    2 files changed, 8 insertions(+), 4 deletions(-)
>>>>
>>>
>>> Ping.
>>>
>>>
>> Waiting for an Ack from Darren.
>
> Jonathan verified that the change will not break existing external platforms.
> I'm happy with it from that perspective.
>
> Guenter, will you take both patches together?
>

Yes, I'll add them to my queue of patches to send to Wim.

Thanks,
Guenter

> Reviewed-by: Darren Hart <dvhart@linux.intel.com>
>
>

