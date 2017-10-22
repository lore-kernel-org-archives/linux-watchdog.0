Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:56487 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751637AbdJVO4I (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 22 Oct 2017 10:56:08 -0400
Subject: Re: [PATCH 2/3] watchdog: hpwdt: SMBIOS check
To: Jerry.Hoemann@hpe.com
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1508539271.git.jerry.hoemann@hpe.com>
 <edf5fbe55bc25680926f1526145584bd33b05ff3.1508539271.git.jerry.hoemann@hpe.com>
 <c27c64af-6006-7bb1-deff-eb0ef65b87f2@roeck-us.net>
 <20171022015621.GB28641@anatevka.americas.hpqcorp.net>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <b3bfecf2-2ac6-4c1d-a03e-5f70aa03f7e0@roeck-us.net>
Date: Sun, 22 Oct 2017 07:56:05 -0700
MIME-Version: 1.0
In-Reply-To: <20171022015621.GB28641@anatevka.americas.hpqcorp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/21/2017 06:56 PM, Jerry Hoemann wrote:
> On Fri, Oct 20, 2017 at 07:37:21PM -0700, Guenter Roeck wrote:
>> On 10/20/2017 03:54 PM, Jerry Hoemann wrote:
>>> Correct test on SMBIOS table 219 Misc Features bits for UEFI supported.
>>>
>> Please explain in more detail. There is no table 219 in the SMBIOS specification.
> 
> Sorry, my patch documentation was imprecise, I should have stated Type 219 record.
> 
> Type 219 is an HPE OEM SMBIOS extension whose contents are considered
> confidential, so I'm not at liberty to go into details.  I will say
> that Type 219 describes features of the iLO which hpwdt is implemented
> against.
> 
> 
>> There is table 9, BIOS Characteristics Extension Byte 2, which specifies bit 3
>> as "UEFI Specification is supported.", but nothing that really maps to the
>> other byte, and no "misc features". Maybe this is HP specific, but then we'll
>> need to have much better explanation.
> 
> This patch is to correct commit cce78da766.
> 
> Our current servers do not support the CRU BIOS interfaces and we
> need to avoid calling it.  Tom initially only checked that iCRU which
> replaced CRU was supported.  But, later added code to extend to also
> test whether UEFI was supported to anticipate a time when iCRU wasn't
> supported either but where we still don't want to call back into CRU.
> 
> Tom's original change was implemented to an older definition of Type 219.
> Unfortunately, the specification (and firmware) were modified to use a
> different pair of bits to represent UEFI.  However, a corresponding change
> to update Linux was missed.
> 
> The code is currently working today as the iCRU bit is correctly being
> checked.  But as the purpose of cce78da766 is to protect the
> code for a time when iCRU isn't true, we want to correct the
> checking of the UEFI bit.
> 
Please add at least some of that explanation to the description and reorder
the patches such that the fixes come first.

Thanks,
Guenter

> 
>>
>>> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
>>> ---
>>>    drivers/watchdog/hpwdt.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
>>> index ef54b03..4c011e8 100644
>>> --- a/drivers/watchdog/hpwdt.c
>>> +++ b/drivers/watchdog/hpwdt.c
>>> @@ -707,7 +707,7 @@ static void dmi_find_icru(const struct dmi_header *dm, void *dummy)
>>>    		smbios_proliant_ptr = (struct smbios_proliant_info *) dm;
>>>    		if (smbios_proliant_ptr->misc_features & 0x01)
>>>    			is_icru = 1;
>>> -		if (smbios_proliant_ptr->misc_features & 0x408)
>>> +		if (smbios_proliant_ptr->misc_features & 0x1400)
>>>    			is_uefi = 1;
>>>    	}
>>>    }
>>>
>> Presumably patch 2/3 and 3/3 are bug fixs and should come first
>> so they can be applied to stable releases.
>>
> 
> I can re-order the patches or delay the first patch if necessary.
> 
> 
> Thanks
> Jerry
> 

