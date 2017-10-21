Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44550 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751885AbdJUChZ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 20 Oct 2017 22:37:25 -0400
Subject: Re: [PATCH 2/3] watchdog: hpwdt: SMBIOS check
To: Jerry Hoemann <jerry.hoemann@hpe.com>, wim@iguana.be
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1508539271.git.jerry.hoemann@hpe.com>
 <edf5fbe55bc25680926f1526145584bd33b05ff3.1508539271.git.jerry.hoemann@hpe.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <c27c64af-6006-7bb1-deff-eb0ef65b87f2@roeck-us.net>
Date: Fri, 20 Oct 2017 19:37:21 -0700
MIME-Version: 1.0
In-Reply-To: <edf5fbe55bc25680926f1526145584bd33b05ff3.1508539271.git.jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/20/2017 03:54 PM, Jerry Hoemann wrote:
> Correct test on SMBIOS table 219 Misc Features bits for UEFI supported.
> 
Please explain in more detail. There is no table 219 in the SMBIOS specification.
There is table 9, BIOS Characteristics Extension Byte 2, which specifies bit 3
as "UEFI Specification is supported.", but nothing that really maps to the
other byte, and no "misc features". Maybe this is HP specific, but then we'll
need to have much better explanation.

> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
> ---
>   drivers/watchdog/hpwdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index ef54b03..4c011e8 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -707,7 +707,7 @@ static void dmi_find_icru(const struct dmi_header *dm, void *dummy)
>   		smbios_proliant_ptr = (struct smbios_proliant_info *) dm;
>   		if (smbios_proliant_ptr->misc_features & 0x01)
>   			is_icru = 1;
> -		if (smbios_proliant_ptr->misc_features & 0x408)
> +		if (smbios_proliant_ptr->misc_features & 0x1400)
>   			is_uefi = 1;
>   	}
>   }
> 
Presumably patch 2/3 and 3/3 are bug fixs and should come first
so they can be applied to stable releases.

Thanks,
Guenter

