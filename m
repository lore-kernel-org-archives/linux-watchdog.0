Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:55612 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbdJXDSg (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 23 Oct 2017 23:18:36 -0400
Subject: Re: [PATCH v2 1/3] watchdog: hpwdt: SMBIOS check
To: Jerry Hoemann <jerry.hoemann@hpe.com>, wim@iguana.be
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1508797127.git.jerry.hoemann@hpe.com>
 <bd8ad99a9575e3c1df7a73f3b4369785aac56b64.1508797127.git.jerry.hoemann@hpe.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <84aa34bd-01b6-37fc-2803-e64986f79741@roeck-us.net>
Date: Mon, 23 Oct 2017 20:18:29 -0700
MIME-Version: 1.0
In-Reply-To: <bd8ad99a9575e3c1df7a73f3b4369785aac56b64.1508797127.git.jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/23/2017 03:46 PM, Jerry Hoemann wrote:
> This corrects:
> commit cce78da76601 ("watchdog: hpwdt: Add check for UEFI bits")
> 
> The test on HPE SMBIOS extension type 219 record "Misc Features"
> bits for UEFI support is incorrect.  The definition of the Misc Features
> bits in the HPE SMBIOS OEM Extensions specification (and related
> firmware) was changed to use a different pair of bits to
> represent UEFI supported.  Howerver, a corresponding change
> to Linux was missed.
> 
> Current code/platform work because the iCRU test is working.
> But purpose of cce78da766 is to ensure correct functionality
> on future systems where iCRU isn't supported.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/hpwdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index 67fbe35..9fd869f 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -700,7 +700,7 @@ static void dmi_find_icru(const struct dmi_header *dm, void *dummy)
>   		smbios_proliant_ptr = (struct smbios_proliant_info *) dm;
>   		if (smbios_proliant_ptr->misc_features & 0x01)
>   			is_icru = 1;
> -		if (smbios_proliant_ptr->misc_features & 0x408)
> +		if (smbios_proliant_ptr->misc_features & 0x1400)
>   			is_uefi = 1;
>   	}
>   }
> 

