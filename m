Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:8926 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752517AbdHNVK2 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 14 Aug 2017 17:10:28 -0400
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v1 1/1] watchdog: iTCO_wdt: Move update_no_reboot_bit()
 out of atomic context
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, sathyaosid@gmail.com
References: <92432e9cc40ba7f37f677386e7f3c5eb815dc26a.1501178882.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20170814174959.GB7764@roeck-us.net>
From: sathyanarayanan kuppuswamy
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <a11cb404-39d2-cd69-cab0-abe192fbbf53@linux.intel.com>
Date: Mon, 14 Aug 2017 14:10:03 -0700
MIME-Version: 1.0
In-Reply-To: <20170814174959.GB7764@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,


On 08/14/2017 10:49 AM, Guenter Roeck wrote:
> On Thu, Jul 27, 2017 at 11:08:44AM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> In iTCO_wdt_start() and iTCO_wdt_stop() functions, update_no_reboot_bit()
>> call has been made within io_lock spin lock context. But if the
>> update_no_reboot_bit() function is implemented by chipset/PMC driver
>> then we can't be sure whether their implementation does not include any
>> sleeping calls. Also, iTCO_wdt io_lock is mainly intended for protecting the
>> watchdog IO operations and has nothing to with no_reboot_bit update.
>>
> I disagree. The spinlock also protects update_no_reboot_bit_{pci,mem}().
> Those functions do a read-modify-write, read back the original value,
> and bail out if the reported value is unexpected. If protecting those
> functions is unnecessary, we may as well claim that the spinlock itself
> is unnecessary to start with.
I thought io_lock is only intended for protecting in/out operations. 
Thanks for
clarifying it.
>
> This also changes the order of calls, now calling iTCO_vendor_pre_start()
> _after_ updating no_reboot_bit. While that should not matter, it adds another
> level of risk and uncertainty.
>
>> Currently, update_no_reboot_bit() function implemented by intel_pmc_ipc
>> driver uses mutex_lock() which in turn causes "sleeping into atomic
>> context" issue in iTCO_wdt_start()/iTCO_wdt_stop() functions.
>>
> A better fix might be to use a spinlock for gcr reads and updates
> in the intel driver. Note that it isn't entirely clear to me why gcr
> register accesses are protected by the mutex used to protect ipc
> command execution, or why gcr_data_readq() is unprotected but
> intel_pmc_gcr_read() is, or why is_gcr_valid() would need to be protected.
Agreed.  Will submit a fix for it in intel_pmc_ipc driver.

> Thanks,
> Guenter
>
>> So moving the update_no_reboot_bit() function out of atomic context.
>>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>   drivers/watchdog/iTCO_wdt.c | 13 ++++++-------
>>   1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
>> index c4f6587..5a018b2 100644
>> --- a/drivers/watchdog/iTCO_wdt.c
>> +++ b/drivers/watchdog/iTCO_wdt.c
>> @@ -243,17 +243,16 @@ static int iTCO_wdt_start(struct watchdog_device *wd_dev)
>>   	struct iTCO_wdt_private *p = watchdog_get_drvdata(wd_dev);
>>   	unsigned int val;
>>   
>> -	spin_lock(&p->io_lock);
>> -
>> -	iTCO_vendor_pre_start(p->smi_res, wd_dev->timeout);
>> -
>>   	/* disable chipset's NO_REBOOT bit */
>>   	if (p->update_no_reboot_bit(p->no_reboot_priv, false)) {
>> -		spin_unlock(&p->io_lock);
>>   		pr_err("failed to reset NO_REBOOT flag, reboot disabled by hardware/BIOS\n");
>>   		return -EIO;
>>   	}
>>   
>> +	spin_lock(&p->io_lock);
>> +
>> +	iTCO_vendor_pre_start(p->smi_res, wd_dev->timeout);
>> +
>>   	/* Force the timer to its reload value by writing to the TCO_RLD
>>   	   register */
>>   	if (p->iTCO_version >= 2)
>> @@ -288,11 +287,11 @@ static int iTCO_wdt_stop(struct watchdog_device *wd_dev)
>>   	outw(val, TCO1_CNT(p));
>>   	val = inw(TCO1_CNT(p));
>>   
>> +	spin_unlock(&p->io_lock);
>> +
>>   	/* Set the NO_REBOOT bit to prevent later reboots, just for sure */
>>   	p->update_no_reboot_bit(p->no_reboot_priv, true);
>>   
>> -	spin_unlock(&p->io_lock);
>> -
>>   	if ((val & 0x0800) == 0)
>>   		return -1;
>>   	return 0;
>> -- 
>> 2.7.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

