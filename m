Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:49891 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbaERE6L (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 18 May 2014 00:58:11 -0400
Message-ID: <53783DD8.6070908@roeck-us.net>
Date: Sat, 17 May 2014 21:58:00 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: David Cohen <david.a.cohen@linux.intel.com>
CC: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [hwmon:watchdog-next 18/34] arch/x86/platform/intel-mid/device_libs/platform_wdt.c:37:2:
 error: implicit declaration of function 'mp_find_ioapic'
References: <5374a77f.J4+vnB3mNfBZ172K%fengguang.wu@intel.com> <20140515171947.GA18562@roeck-us.net> <20140515174221.GA3237@psi-dev26.jf.intel.com> <20140518032052.GA545@psi-dev26.jf.intel.com>
In-Reply-To: <20140518032052.GA545@psi-dev26.jf.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/17/2014 08:20 PM, David Cohen wrote:
> On Thu, May 15, 2014 at 10:42:21AM -0700, David Cohen wrote:
>> On Thu, May 15, 2014 at 10:19:47AM -0700, Guenter Roeck wrote:
>>> Hi David,
>>
>> Hi Guenter,
>>
>>>
>>> can you look into this ? This is from your patch 'x86: intel-mid: add watchdog
>>> platform code for Merrifield'.
>>
>> Thanks for the info.
>>
>>>
>>> Maybe the code should depend on X86_IO_APIC,
>>> or include asm/io_apic.h explicitly (which might be appropriate anyway).
>>
>> I'll send a fix.
>
> Do you prefer an incremental patch fixing this issue or a replacement
> for the first one?
>

I would suggest incremental; Wim can then decide if he wants to merge the two patches
into one or keep them separate.

Guenter


