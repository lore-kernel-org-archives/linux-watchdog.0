Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:49543 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751014AbdJVOzW (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 22 Oct 2017 10:55:22 -0400
Subject: Re: [PATCH 1/3] watchdog: hpwdt: add ioctl WDIOC_GETPRETIMEOUT
To: Jerry.Hoemann@hpe.com
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1508539271.git.jerry.hoemann@hpe.com>
 <fdb84d723278f8f198a59f79e31d8903870fb2a0.1508539271.git.jerry.hoemann@hpe.com>
 <a9e00af0-8239-d5cb-078c-06f3388810cf@roeck-us.net>
 <20171022014102.GA28641@anatevka.americas.hpqcorp.net>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <9a67578e-5bb1-621e-4000-d25444228783@roeck-us.net>
Date: Sun, 22 Oct 2017 07:55:19 -0700
MIME-Version: 1.0
In-Reply-To: <20171022014102.GA28641@anatevka.americas.hpqcorp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/21/2017 06:41 PM, Jerry Hoemann wrote:
> On Fri, Oct 20, 2017 at 07:25:20PM -0700, Guenter Roeck wrote:
>> On 10/20/2017 03:54 PM, Jerry Hoemann wrote:
>>> Add support for WDIOC_GETPRETIMEOUT ioctl so that user applications
>>> can determine when the NMI should arrive.
>>>
>>> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
>>> ---
>>>    drivers/watchdog/hpwdt.c | 7 +++++++
>>>    1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
>>> index 67fbe35..ef54b03 100644
>>> --- a/drivers/watchdog/hpwdt.c
>>> +++ b/drivers/watchdog/hpwdt.c
>>> @@ -50,6 +50,7 @@
>>>    static bool nowayout = WATCHDOG_NOWAYOUT;
>>>    static char expect_release;
>>>    static unsigned long hpwdt_is_open;
>>> +static const int pretimeout = 9;
>>>    static void __iomem *pci_mem_addr;		/* the PCI-memory address */
>>>    static unsigned long __iomem *hpwdt_timer_reg;
>>> @@ -622,6 +623,12 @@ static long hpwdt_ioctl(struct file *file, unsigned int cmd,
>>>    		}
>>>    		break;
>>> +	case WDIOC_GETPRETIMEOUT:
>>> +		ret = copy_to_user(argp, &pretimeout, sizeof(pretimeout));
>>> +		if (ret)
>>> +			ret = -EFAULT;
>>> +		break;
>>> +
>>>    	case WDIOC_SETTIMEOUT:
>>>    		ret = get_user(new_margin, p);
>>>    		if (ret)
>>>
>>
>> Can you please convert the driver to use the watchdog subsystem instead ?
>> If there are still improvements needed afterwards, they can still be
>> implemented, but we really should not make improvements which are
>> already supported by the watchdog core.
> 
> I will look into converting the driver, but would like to get this
> fix in independently.
> 

I don't see this patch as a fix. It adds functionality. the other two patches
are fixes and should come first.

> SuSE brought https://bugzilla.novell.com/show_bug.cgi?id=1042933
> to my attention earlier this summer.  The submitter was trying to
> develop a watchdog test where the ping rate was set to be the
> Timeout/2.
> 
> The test worked fine until (Timeout/2) < PreTimeout.  At this point
> an NMI would be delivered to the system before the test could refresh
> the timer.
> 
Yes, but I don't think that is fixed with this patch. That would be patch 3/3, no ?

Guenter

> I came to the view that a watchdog that implements a pre-timeout NMI
> where the value of the pre-timeout is not known programmatically as having
> a defect.
> 
> This problem has been around a long time and we could live with it, but
> figured while I was in fixing other problems, I'd fix this one as well.
> 
> Thanks
> 

