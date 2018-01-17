Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34641 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeAQB2S (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 16 Jan 2018 20:28:18 -0500
Subject: Re: [05/12] watchdog: sp5100_tco: Clean up sp5100_tco_setupdevice
From: Guenter Roeck <linux@roeck-us.net>
To: Lyude Paul <lyude@redhat.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?Wm9sdMOhbiBCw7ZzesO2cm3DqW55aQ==?= <zboszor@pr.hu>
References: <1514149457-20273-6-git-send-email-linux@roeck-us.net>
 <1516132557.18904.12.camel@redhat.com> <20180116202246.GC9484@roeck-us.net>
Message-ID: <b16fd820-fa09-67dc-abf2-94f82269571f@roeck-us.net>
Date: Tue, 16 Jan 2018 17:28:16 -0800
MIME-Version: 1.0
In-Reply-To: <20180116202246.GC9484@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/16/2018 12:22 PM, Guenter Roeck wrote:
> On Tue, Jan 16, 2018 at 02:55:57PM -0500, Lyude Paul wrote:
>> Thank you for this cleanup, the gotos that were in this code are really
>> confusing to read through! I'd recommend one very small change described
>> below. Assuming you add that in the next version:
>>
>> Reviewed-by: Lyude Paul <lyude@redhat.com>
>>
>> On Sun, 2017-12-24 at 13:04 -0800, Guenter Roeck wrote:
>>> There are too many unnecessary goto statements in sp5100_tco_setupdevice().
>>> Rearrange the code and limit goto statements to error handling.
>>>
>>> Cc: Zoltán Böszörményi <zboszor@pr.hu>
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>> ---
>>>   drivers/watchdog/sp5100_tco.c | 62 ++++++++++++++++++++------------------
>>> -----
>>>   1 file changed, 29 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
>>> index 0e816f2cdb07..5a13ab483c50 100644
>>> --- a/drivers/watchdog/sp5100_tco.c
>>> +++ b/drivers/watchdog/sp5100_tco.c
>>> @@ -396,48 +396,44 @@ static int sp5100_tco_setupdevice(void)
>>>   	pr_debug("Got 0x%04x from indirect I/O\n", val);
>>>   
>>>   	/* Check MMIO address conflict */
>>> -	if (request_mem_region_exclusive(val, SP5100_WDT_MEM_MAP_SIZE,
>>> -								dev_name))
>>> -		goto setup_wdt;
>>> -	else
>>> +	if (!request_mem_region_exclusive(val, SP5100_WDT_MEM_MAP_SIZE,
>>> +					  dev_name)) {
>>>   		pr_debug("MMIO address 0x%04x already in use\n", val);
>>> +		/*
>>> +		 * Secondly, Find the watchdog timer MMIO address
>>> +		 * from SBResource_MMIO register.
>>> +		 */
>>> +		if (tco_has_sp5100_reg_layout(sp5100_tco_pci)) {
>>> +			/* Read SBResource_MMIO from PCI config(PCI_Reg:
>>> 9Ch) */
>>> +			pci_read_config_dword(sp5100_tco_pci,
>>> +					      SP5100_SB_RESOURCE_MMIO_BASE,
>>> +					      &val);
>>> +		} else {
>>> +			/* Read SBResource_MMIO from AcpiMmioEn(PM_Reg:
>>> 24h) */
>>> +			val =
>>> sp5100_tco_read_pm_reg32(SB800_PM_ACPI_MMIO_EN);
>>> +		}
>>>   
>>> -	/*
>>> -	 * Secondly, Find the watchdog timer MMIO address
>>> -	 * from SBResource_MMIO register.
>>> -	 */
>>> -	if (tco_has_sp5100_reg_layout(sp5100_tco_pci)) {
>>> -		/* Read SBResource_MMIO from PCI config(PCI_Reg: 9Ch) */
>>> -		pci_read_config_dword(sp5100_tco_pci,
>>> -				      SP5100_SB_RESOURCE_MMIO_BASE, &val);
>>> -	} else {
>>> -		/* Read SBResource_MMIO from AcpiMmioEn(PM_Reg: 24h) */
>>> -		val = sp5100_tco_read_pm_reg32(SB800_PM_ACPI_MMIO_EN);
>>> -	}
>>> -
>>> -	/* The SBResource_MMIO is enabled and mapped memory space? */
>>> -	if ((val & (SB800_ACPI_MMIO_DECODE_EN | SB800_ACPI_MMIO_SEL)) ==
>>> +		/* The SBResource_MMIO is enabled and mapped memory space?
>>> */
>>> +		if ((val & (SB800_ACPI_MMIO_DECODE_EN |
>>> SB800_ACPI_MMIO_SEL)) !=
>>>   						  SB800_ACPI_MMIO_DECODE_EN
>> Re-align this line since you're changing the code around here anyway
>>
> 
> This code is changed again in a later patch, and I don't see anything wrong
> with the final alignment. Can you look at the final code and let me know what
> alignment you would like to have changed there ?
> 

Never mind, I (think) I found what you meant: I dropped a couple of spaces
in front of SB800_ACPI_MMIO_DECODE_EN. After the last patch, this affected
two places. You are right, those spaces don't add any value.

I also see that Wim didn't pull the changes into his watchdog-next tree,
meaning they are not in linux-next and will miss 4.16 anyway. Given that,
I'll send another version of the series right after the commit window
closes.

Thanks,
Guenter
