Return-Path: <mathieu.malaterre@gmail.com>
Return-path: <mathieu.malaterre@gmail.com>
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <20170915224220.GB3420@roeck-us.net>
References: <20170915192020.27717-1-malat@debian.org> <20170915224220.GB3420@roeck-us.net>
From: Mathieu Malaterre <malat@debian.org>
Date: Mon, 18 Sep 2017 12:00:00 +0200
Message-ID: <CA+7wUsx91=ZkBTuqwshrx8Mt2rG0EZc3K58hePv+7R=Mgc9LyA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] watchdog: jz4740: Add support for the watchdog in
 jz4780 SoC
To: Guenter Roeck <linux@roeck-us.net>
Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paul Cercueil <paul@crapouillou.net>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

On Sat, Sep 16, 2017 at 12:42 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Fri, Sep 15, 2017 at 09:20:19PM +0200, Mathieu Malaterre wrote:
>> The watchdog unit present in the JZ4780 works the same as the one in the
>> JZ4740.
>>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>> ---
>> Changes in v2:
>> * do not re-use the compatible string for different SoC (Paul Cercueil)
>
> I thought that was one of the specific features of compatible statements,
> to avoid having to change the driver each time a new chip comes along.
> Did that change recently ?

Well, this was suggested-by Paul Cercueil. This seems to make sense to
have two different compatible strings for two different SoC (JZ4740 &
JZ4780, technically there is also JZ4770). This also seems to be used
in other drivers:

% grep -lroPz  '(?s)ingenic,jz4740.*?ingenic,jz4780' *
Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.txt
Documentation/devicetree/bindings/clock/ingenic,cgu.txt
Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.txt
Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
Documentation/devicetree/bindings/serial/ingenic,uart.txt
Documentation/devicetree/bindings/sound/ingenic,jz4740-i2s.txt
drivers/gpio/gpio-ingenic.c
drivers/pinctrl/pinctrl-ingenic.c
drivers/tty/serial/8250/8250_ingenic.c
drivers/rtc/rtc-jz4740.c
drivers/irqchip/irq-ingenic.c
sound/soc/jz4740/jz4740-i2s.c


>>
>>  drivers/watchdog/jz4740_wdt.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
>> index 20627f22baf6..aafbeb96561b 100644
>> --- a/drivers/watchdog/jz4740_wdt.c
>> +++ b/drivers/watchdog/jz4740_wdt.c
>> @@ -146,6 +146,7 @@ static const struct watchdog_ops jz4740_wdt_ops = {
>>  #ifdef CONFIG_OF
>>  static const struct of_device_id jz4740_wdt_of_matches[] = {
>>       { .compatible = "ingenic,jz4740-watchdog", },
>> +     { .compatible = "ingenic,jz4780-watchdog", },
>>       { /* sentinel */ }
>>  };
>>  MODULE_DEVICE_TABLE(of, jz4740_wdt_of_matches);
>> --
>> 2.11.0
>>
