Return-Path: <garsilva@embeddedor.com>
Return-path: <garsilva@embeddedor.com>
Date: Fri, 03 Nov 2017 10:47:37 -0500
Message-ID: <20171103104737.Horde.jIupkyXRbKxDR--eHgm0-aF@gator4166.hostgator.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: pcwd_pci: mark expected switch fall-through
References: <20171103144915.GA6243@embeddedor.com>
 <20171103150423.GA10138@infomag.iguana.be>
In-Reply-To: <20171103150423.GA10138@infomag.iguana.be>
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
List-ID: <linux-watchdog@vger.kernel.org>

Hi Wim,

Quoting Wim Van Sebroeck <wim@iguana.be>:

> Hi Gustavo,
>
>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>> where we are expecting to fall through.
>>
>> Notice that in this particular case I replaced "Fall" with a proper
>> "fall through" comment, which is what GCC is expecting to find.
>>
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>> ---
>>  drivers/watchdog/pcwd_pci.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/watchdog/pcwd_pci.c b/drivers/watchdog/pcwd_pci.c
>> index c0d07ee..c882252 100644
>> --- a/drivers/watchdog/pcwd_pci.c
>> +++ b/drivers/watchdog/pcwd_pci.c
>> @@ -545,7 +545,7 @@ static long pcipcwd_ioctl(struct file *file,  
>> unsigned int cmd,
>>  			return -EINVAL;
>>
>>  		pcipcwd_keepalive();
>> -		/* Fall */
>> +		/* fall through */
>>  	}
>>
>>  	case WDIOC_GETTIMEOUT:
>> --
>> 2.7.4
>>
>
> Shouldn't the /* fall through */ come after the } ?
>

Yep, you are right.

I'll fix that.

Thank you!
--
Gustavo A. R. Silva

> Kind regards,
> Wim.
