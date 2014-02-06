Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:24481 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbaBFGZe (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 6 Feb 2014 01:25:34 -0500
Message-ID: <52F32AD8.4010108@oracle.com>
Date: Thu, 06 Feb 2014 10:25:28 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: linux-watchdog@vger.kernel.org, vasily.isaenko@oracle.com
Subject: Re: [PATCH] watchdog: w83697hf_wdt: return ENODEV if no device was
 found
References: <1390806273-8848-1-git-send-email-stanislav.kholmanskikh@oracle.com> <20140127163332.GA29882@roeck-us.net>
In-Reply-To: <20140127163332.GA29882@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi!

On 01/27/2014 08:33 PM, Guenter Roeck wrote:
> On Mon, Jan 27, 2014 at 11:04:33AM +0400, Stanislav Kholmanskikh wrote:
>> Most WDT driver modules return ENODEV during modprobe if
>> no valid device was found, but w83697hf_wdt returns EIO.
>>
>> Let w83697hf_wdt return ENODEV.
>>
>> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thank you.

I'm a newbie here.

Should I do something to move it forward (like send this to an another 
mail list), or just wait? :)

Thanks.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
