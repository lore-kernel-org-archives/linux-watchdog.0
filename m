Return-Path: <cbostic@linux.vnet.ibm.com>
Return-path: <cbostic@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] drivers/watchdog: Document new aspeed optional dev
 tree properties.
To: Joel Stanley <joel@jms.id.au>
References: <20170613203818.17399-1-cbostic@linux.vnet.ibm.com>
 <20170613203818.17399-2-cbostic@linux.vnet.ibm.com>
 <CACPK8Xe4kWoZKhwRWD+p-zFz-EQDn_3Q5=U4tUX-n6paKMYy1A@mail.gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-watchdog@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>
From: Christopher Bostic <cbostic@linux.vnet.ibm.com>
Date: Tue, 27 Jun 2017 14:44:18 -0500
MIME-Version: 1.0
In-Reply-To: <CACPK8Xe4kWoZKhwRWD+p-zFz-EQDn_3Q5=U4tUX-n6paKMYy1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <fdbaf3ce-061b-d639-89ac-fed221d60f45@linux.vnet.ibm.com>
List-ID: <linux-watchdog@vger.kernel.org>



On 6/26/17 9:59 PM, Joel Stanley wrote:
> On Wed, Jun 14, 2017 at 6:08 AM, Christopher Bostic
> <cbostic@linux.vnet.ibm.com> wrote:
>> Describe new optional property 'external-signal'.  When present in the
>> system device tree an exernal signal is generated on watchdog timeout.
>>
>> Describe new optional property 'no-system-reset'.  When present in the
>> system device tree no system reset is to occur on watchdog timeout.
>> System reset in this case is managed by one of the other watchogs
>> available.
>>
>> Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
>> ---
>>   Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
>> index c5e74d7..4099ea5 100644
>> --- a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
>> +++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
>> @@ -8,9 +8,20 @@ Required properties:
>>    - reg: physical base address of the controller and length of memory mapped
>>      region
>>
>> +Optional properties:
>> + - external-signal: If the property is present then an external signal is to
>> +   be generated on watchdog timeout.  If absent, external signal is not
>> +   generated.
>> +
>> + - no-system-reset: If the property is present then system will not be reset
>> +   on watchdog timeout. In this case one of the other watchdogs will handle
>> +   reset.  If absent then the watchdog resets the system on timeout.
> I'm not sure that this describes the hardware. The datasheet says:
>
> Whenever timeout ocurs, WDT can program to generate 6 types of signals:
>
>   * ARM reset signal: to reset ARM CPU only
>   * SOC reset signal: to reset SOC part function
>   * System reset signal: to reset full chip
>   * Interrupt signal: to interrupt CPU
>   * Eternal signal: to external reset counter (only WDT1 and WDT2)
>   * Alternate boot signal: to boot from alternate block
>
> I think your bindings should describe these modes where possible.

I'll add the modes you describe.

Thanks,
Chris
>
> Cheers,
>
> Joel
>
>
>> +
>>   Example:
>>
>>          wdt1: watchdog@1e785000 {
>>                  compatible = "aspeed,ast2400-wdt";
>>                  reg = <0x1e785000 0x1c>;
>> +               external-signal;
>> +               no-system-reset;
>>          };
>> --
>> 1.8.2.2
>>
