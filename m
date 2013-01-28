Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <51063791.9090606@atmel.com>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <1359153858-31992-1-git-send-email-arnd@arndb.de> <1359153858-31992-11-git-send-email-arnd@arndb.de>
 <51063791.9090606@atmel.com>
From: Fabio Porcedda <fabio.porcedda@gmail.com>
Date: Mon, 28 Jan 2013 11:19:03 +0100
Message-ID: <CAHkwnC-emr-mx_s7ka3_M1dy-u8RaA37XzxD2rTNarYMXG4y5Q@mail.gmail.com>
Subject: Re: [PATCH 10/19] watchdog: at91sam9: at91_wdt_dt_ids cannot be __init
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, Jan 28, 2013 at 9:32 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> On 01/25/2013 11:44 PM, Arnd Bergmann :
>> The device IDs are referenced by the driver and potentially
>> used beyond the init time, as kbuild correctly warns
>> about. Remove the __initconst annotation.
>>
>> Without this patch, building at91_dt_defconfig results in:
>>
>> WARNING: drivers/watchdog/built-in.o(.data+0x28): Section mismatch in reference from the variable at91wdt_driver to the (unknown reference) .init.rodata:(unknown)
>> The variable at91wdt_driver references
>> the (unknown reference) __initconst (unknown)
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Cc: Wim Van Sebroeck <wim@iguana.be>
>> Cc: linux-watchdog@vger.kernel.org
>> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>
> Thanks,
>
>> Cc: Fabio Porcedda <fabio.porcedda@gmail.com>

Tested-by: Fabio Porcedda <fabio.porcedda@gmail.com>

Thanks.

>> ---
>>  drivers/watchdog/at91sam9_wdt.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
>> index dc42e44..6dad954 100644
>> --- a/drivers/watchdog/at91sam9_wdt.c
>> +++ b/drivers/watchdog/at91sam9_wdt.c
>> @@ -304,7 +304,7 @@ static int __exit at91wdt_remove(struct platform_device *pdev)
>>  }
>>
>>  #if defined(CONFIG_OF)
>> -static const struct of_device_id at91_wdt_dt_ids[] __initconst = {
>> +static const struct of_device_id at91_wdt_dt_ids[] = {
>>       { .compatible = "atmel,at91sam9260-wdt" },
>>       { /* sentinel */ }
>>  };
>>
>
>
> --
> Nicolas Ferre



--
Fabio Porcedda
