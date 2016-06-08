Return-path: <hpeter@gmail.com>
Subject: Re: [PATCH] watchdog: f71808e_wdt: Add F81866 support
To: Guenter Roeck <linux@roeck-us.net>, wim@iguana.be
References: <1465196330-9410-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <5756D4FD.4090109@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 peter_hong@fintek.com.tw, tom_tsai@fintek.com.tw,
 "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
From: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Message-ID: <663dec87-8b9e-f7a5-0224-991e8c528705@gmail.com>
Date: Wed, 8 Jun 2016 09:40:21 +0800
MIME-Version: 1.0
In-Reply-To: <5756D4FD.4090109@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

Guenter Roeck 於 2016/6/7 下午 10:06 寫道:
> On 06/05/2016 11:58 PM, Ji-Ze Hong (Peter Hong) wrote:
>> +#define SIO_REG_PORT_SEL    0x27    /* F81866 Multi-Function Register */
>> +#define SIO_REG_GPIO1        0x2c    /*
>> +                     * GPIO1 Control Register when 27h
>> +                     * BIT3:2 = 01 & BIT0 = 0
>> +                     *
>> +                     * The PIN 70(GPIO15/WDTRST) is
>> +                     * controlled by 2Ch:
>> +                     * BIT5: 0 -> WDTRST#
>> +                     *       1 -> GPIO15
>> +                     */
>> +
> Please keep register defines in order, and move the explanation
> to where the register values are set.

OK. BTW, should I rename SIO_REG_PORT_SEL & SIO_REG_GPIO1 to
SIO_F81866_REG_PORT_SEL & SIO_F81866_REG_GPIO1? It's only used by
F81866.

>> +    case f81866:
>> +        /* Set pin 70 to WDTRST# */
>> +        superio_clear_bit(watchdog.sioaddr, SIO_REG_PORT_SEL, 9);
>> +        superio_set_bit(watchdog.sioaddr, SIO_REG_PORT_SEL, 4);
>> +        superio_clear_bit(watchdog.sioaddr, SIO_REG_GPIO1, 0x20);
>
> Using BIT() here would be a bit nicer. Yes, I know, it isn't done
> everywhere
> in this driver, but that doesn't mean we should not do it in added code.

I'll use BIT() to re-write it.

Thanks
-- 
With Best Regards,
Peter Hung
