Return-path: <fu.wei@linaro.org>
MIME-Version: 1.0
In-Reply-To: <56C34076.1020206@roeck-us.net>
References: <1455611785-2407-1-git-send-email-fu.wei@linaro.org>
	<1455611785-2407-5-git-send-email-fu.wei@linaro.org>
	<56C34076.1020206@roeck-us.net>
Date: Tue, 16 Feb 2016 23:54:04 +0800
Message-ID: <CADyBb7vDuZjjy92WkV_jML2Ji13LvtuqkKszAetzvoM47CaY7Q@mail.gmail.com>
Subject: Re: [PATCH v12 4/4] Watchdog: introduce ARM SBSA watchdog driver
From: Fu Wei <fu.wei@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, Wim Van Sebroeck <wim@iguana.be>, Jon Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, LKML <linux-kernel@vger.kernel.org>,
	linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Richard Ruigrok <rruigrok@codeaurora.org>,
	"Abdulhamid, Harb" <harba@codeaurora.org>, Christopher Covington <cov@codeaurora.org>,
	Timur Tabi <timur@codeaurora.org>, Dave Young <dyoung@redhat.com>,
	Pratyush Anand <panand@redhat.com>, G Gregory <graeme.gregory@linaro.org>,
	Al Stone <al.stone@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>,
	Jon Masters <jcm@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Leo Duran <leo.duran@amd.com>,
	Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-watchdog@vger.kernel.org>

On 16 February 2016 at 23:29, Guenter Roeck <linux@roeck-us.net> wrote:
> On 02/16/2016 12:36 AM, fu.wei@linaro.org wrote:
>>
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> According to Server Base System Architecture (SBSA) specification,
>> the SBSA Generic Watchdog has two stage timeouts: the first signal (WS0)
>> is for alerting the system by interrupt, the second one (WS1) is a real
>> hardware reset.
>> More details about the hardware specification of this device:
>> ARM DEN0029B - Server Base System Architecture (SBSA)
>>
>> This driver can operate ARM SBSA Generic Watchdog as a single stage
>> watchdog
>> or a two stages watchdog, it's set up by the module parameter "action".
>> In the single stage mode, when the timeout is reached, your system
>> will be reset by WS1. The first signal (WS0) is ignored.
>> In the two stages mode, when the timeout is reached, the first signal
>> (WS0)
>> will trigger panic. If the system is getting into trouble and cannot be
>> reset
>> by panic or restart properly by the kdump kernel(if supported), then the
>> second stage (as long as the first stage) will be reached, system will be
>> reset by WS1. This function can help administrator to backup the system
>> context info by panic console output or kdump.
>>
>> This driver bases on linux kernel watchdog framework, so it can get
>> timeout from module parameter and FDT at the driver init stage.
>>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> Reviewed-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Tested-by: Pratyush Anand <panand@redhat.com>
>> Acked-by: Timur Tabi <timur@codeaurora.org>
>> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> ---
>>   drivers/watchdog/Kconfig     |  20 +++
>>   drivers/watchdog/Makefile    |   1 +
>>   drivers/watchdog/sbsa_gwdt.c | 403
>> +++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 424 insertions(+)
>>
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index 0f6d851..ed9a5cb 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>
>
> [ ... ]
>
>> +
>> +static int sbsa_gwdt_probe(struct platform_device *pdev)
>> +{
>
>
> [ ... ]
>
>> +               if (!action)
>> +                       dev_warn(dev, "falling back to signle stage
>> mode.\n");
>
>
> Still:
>
> s/signle/single/

sorry, my bad, will fix it

>
> [ ... ]
>
>> +
>> +MODULE_DESCRIPTION("SBSA Generic Watchdog Driver");
>> +MODULE_AUTHOR("Fu Wei <fu.wei@linaro.org>");
>> +MODULE_AUTHOR("Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>");
>> +MODULE_AUTHOR("Al Stone <al.stone@linaro.org>");
>> +MODULE_AUTHOR("Timur Tabi <timur@codeaurora.org>");
>> +MODULE_LICENSE("GPL v2");
>>
> Do you need a MODULE_ALIAS ?

For now, I thinks we don't need it, Hope I didn't miss something :-)
Because this module can be mounted automatically with dtb or ACPI(if
apply my GTDT patch).
Do you have any suggestion or concern? :-)

>
> Guenter
>



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat Software (Beijing) Co.,Ltd.Shanghai Branch
Ph: +86 21 61221326(direct)
Ph: +86 186 2020 4684 (mobile)
Room 1512, Regus One Corporate Avenue,Level 15,
One Corporate Avenue,222 Hubin Road,Huangpu District,
Shanghai,China 200021
