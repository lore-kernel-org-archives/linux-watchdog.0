Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from gateway22.websitewelcome.com ([192.185.47.129]:21450 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750821AbdKCPG4 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 3 Nov 2017 11:06:56 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 728364121
        for <linux-watchdog@vger.kernel.org>; Fri,  3 Nov 2017 09:44:26 -0500 (CDT)
Date: Fri, 03 Nov 2017 09:44:26 -0500
Message-ID: <20171103094426.Horde.P3wnwgmj4SNV10vNNQ6Ohyp@gator4166.hostgator.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: watchdog: f71808e_wdt: mark expected switch fall-throughs
References: <20171102192817.GA20042@embeddedor.com>
 <20171103133414.GA14463@roeck-us.net>
In-Reply-To: <20171103133414.GA14463@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


Quoting Guenter Roeck <linux@roeck-us.net>:

> On Thu, Nov 02, 2017 at 02:28:17PM -0500, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>> where we are expecting to fall through.
>>
>> Notice that in this particular case I replaced "Fall" with a proper
>> "fall through" comment, which is what GCC is expecting to find.
>>
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>

Thanks!

--
Gustavo A. R. Silva

>> ---
>>  drivers/watchdog/f71808e_wdt.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
>> index 8658dba..e0678c1 100644
>> --- a/drivers/watchdog/f71808e_wdt.c
>> +++ b/drivers/watchdog/f71808e_wdt.c
>> @@ -627,7 +627,7 @@ static long watchdog_ioctl(struct file *file,  
>> unsigned int cmd,
>>
>>  		if (new_options & WDIOS_ENABLECARD)
>>  			return watchdog_start();
>> -
>> +		/* fall through */
>>
>>  	case WDIOC_KEEPALIVE:
>>  		watchdog_keepalive();
>> @@ -641,7 +641,7 @@ static long watchdog_ioctl(struct file *file,  
>> unsigned int cmd,
>>  			return -EINVAL;
>>
>>  		watchdog_keepalive();
>> -		/* Fall */
>> +		/* fall through */
>>
>>  	case WDIOC_GETTIMEOUT:
>>  		return put_user(watchdog.timeout, uarg.i);






