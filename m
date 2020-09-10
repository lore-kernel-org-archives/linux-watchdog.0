Return-Path: <SRS0=g4WE=CT=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF288C43461
	for <linux-watchdog@archiver.kernel.org>; Thu, 10 Sep 2020 17:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B478D2076C
	for <linux-watchdog@archiver.kernel.org>; Thu, 10 Sep 2020 17:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgIJRFt (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:05:49 -0400
Received: from gecko.sbs.de ([194.138.37.40]:51196 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbgIJRFo (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 10 Sep 2020 13:05:44 -0400
X-Greylist: delayed 615 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Sep 2020 13:05:43 EDT
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 08AGt98C020299
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Sep 2020 18:55:09 +0200
Received: from [139.25.68.37] ([139.25.68.37])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 08AGt8rb008938;
        Thu, 10 Sep 2020 18:55:09 +0200
Subject: Re: [PATCH 2/2] watchdog: sp5100_tco: Enable watchdog on Family 17h
 devices if disabled
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200910163109.235136-1-linux@roeck-us.net>
 <20200910163109.235136-2-linux@roeck-us.net>
 <30f69c2c-d4c8-a143-6bfa-34394b6361cf@siemens.com>
 <6ff3df92-3465-f619-7c21-eed421ff719d@roeck-us.net>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <2e35ac70-deca-d414-e8a6-2815bdd638d4@siemens.com>
Date:   Thu, 10 Sep 2020 18:55:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <6ff3df92-3465-f619-7c21-eed421ff719d@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

On 10.09.20 18:53, Guenter Roeck wrote:
> Hi Jan,
> 
> On 9/10/20 9:34 AM, Jan Kiszka wrote:
>> On 10.09.20 18:31, Guenter Roeck wrote:
>>> On Family 17h (Ryzen) devices, the WatchdogTmrEn bit of PmDecodeEn not only
>>> enables watchdog memory decoding at 0xfeb00000, it also enables the
>>> watchdog hardware itself. Use this information to enable the watchdog if
>>> it is not already enabled.
>>>
>>> Cc: Jan Kiszka <jan.kiszka@siemens.com>
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>> ---
>>>  drivers/watchdog/sp5100_tco.c | 18 ++++++++++++++++++
>>>  1 file changed, 18 insertions(+)
>>>
>>> diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
>>> index 85e9664318c9..a730ecbf78cd 100644
>>> --- a/drivers/watchdog/sp5100_tco.c
>>> +++ b/drivers/watchdog/sp5100_tco.c
>>> @@ -17,6 +17,12 @@
>>>   *	    AMD Publication 51192 "AMD Bolton FCH Register Reference Guide"
>>>   *	    AMD Publication 52740 "BIOS and Kernel Developer’s Guide (BKDG)
>>>   *				for AMD Family 16h Models 30h-3Fh Processors"
>>> + *	    AMD Publication 55570-B1-PUB "Processor Programming Reference (PPR)
>>> + *				for AMD Family 17h Model 18h, Revision B1
>>> + *				Processors (PUB)
>>> + *	    AMD Publication 55772-A1-PUB "Processor Programming Reference (PPR)
>>> + *				for AMD Family 17h Model 20h, Revision A1
>>> + *				Processors (PUB)
>>>   */
>>>  
>>>  /*
>>> @@ -241,6 +247,18 @@ static int sp5100_tco_setupdevice(struct device *dev,
>>>  		break;
>>>  	case efch:
>>>  		dev_name = SB800_DEVNAME;
>>> +		/*
>>> +		 * On Family 17h devices, the EFCH_PM_DECODEEN_WDT_TMREN bit of
>>> +		 * EFCH_PM_DECODEEN not only enables the EFCH_PM_WDT_ADDR memory
>>> +		 * region, it also enables the watchdog itself.
>>> +		 */
>>> +		if (boot_cpu_data.x86 == 0x17) {
>>> +			val = sp5100_tco_read_pm_reg8(EFCH_PM_DECODEEN);
>>> +			if (!(val & EFCH_PM_DECODEEN_WDT_TMREN)) {
>>> +				sp5100_tco_update_pm_reg8(EFCH_PM_DECODEEN, 0xff,
>>> +							  EFCH_PM_DECODEEN_WDT_TMREN);
>>> +			}
>>> +		}
>>>  		val = sp5100_tco_read_pm_reg8(EFCH_PM_DECODEEN);
>>>  		if (val & EFCH_PM_DECODEEN_WDT_TMREN)
>>>  			mmio_addr = EFCH_PM_WDT_ADDR;
>>>
>>
>> Won't that bring us EFCH_PM_WDT_ADDR as address, rather than
>> EFCH_PM_ACPI_MMIO_ADDR which worked in my case? Or is one an alias of
>> the other.
>>
> 
> Yes, it does use EFCH_PM_WDT_ADDR. EFCH_PM_ACPI_MMIO_ADDR works as well,
> but is meant to be a fallback. Both point to the watchdog memory space.
> 

OK, will test, possibly only on the weekend, and confirm this also on my
board.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
