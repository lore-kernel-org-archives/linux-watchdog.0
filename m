Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36252 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbbJ1EKP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 28 Oct 2015 00:10:15 -0400
Received: by oiao187 with SMTP id o187so132908266oia.3
        for <linux-watchdog@vger.kernel.org>; Tue, 27 Oct 2015 21:10:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20151027162257.GJ3091@leverpostej>
References: <1445961999-9506-1-git-send-email-fu.wei@linaro.org>
	<1445961999-9506-2-git-send-email-fu.wei@linaro.org>
	<20151027162257.GJ3091@leverpostej>
Date: Wed, 28 Oct 2015 12:10:14 +0800
Message-ID: <CADyBb7sAcT4bXrkNo2GKx1Tw5wOuf8JeMgCoiAw=owHqvYx6ug@mail.gmail.com>
Subject: Re: [PATCH v8 1/5] Documentation: add sbsa-gwdt driver documentation
From: Fu Wei <fu.wei@linaro.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
	Wei Fu <tekkamanninja@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Jon Masters <jcm@redhat.com>, Leo Duran <leo.duran@amd.com>,
	Jon Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Rafael Wysocki <rjw@rjwysocki.net>,
	Dave Young <dyoung@redhat.com>,
	Pratyush Anand <panand@redhat.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Rob Herring <robherring2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Mark

Thanks for your rapid feedback, I appreciate your help very much.


On 28 October 2015 at 00:22, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Oct 28, 2015 at 12:06:35AM +0800, fu.wei@linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> The sbsa-gwdt.txt documentation in devicetree/bindings/watchdog is for
>> introducing SBSA(Server Base System Architecture) Generic Watchdog
>> device node info into FDT.
>>
>> Also add sbsa-gwdt introduction in watchdog-parameters.txt
>>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> ---
>>  .../devicetree/bindings/watchdog/sbsa-gwdt.txt     | 46 ++++++++++++++++++++++
>>  Documentation/watchdog/watchdog-parameters.txt     |  6 +++
>>  2 files changed, 52 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt b/Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
>> new file mode 100644
>> index 0000000..ad8e99a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
>> @@ -0,0 +1,46 @@
>> +* SBSA (Server Base System Architecture) Generic Watchdog
>> +
>> +The SBSA Generic Watchdog Timer is used to force a reset of the system
>> +after two stages of timeout have elapsed.  A detailed definition of the
>> +watchdog timer can be found in the ARM document: ARM-DEN-0029 - Server
>> +Base System Architecture (SBSA)
>> +
>> +Required properties:
>> +- compatible: Should at least contain "arm,sbsa-gwdt".
>> +
>> +- reg: Each entry specifies the base physical 64-bit address of a register
>> +  frame and the 64-bit length of that frame; currently, two frames must be
>
> Remove "64-bit" here. This depends on #address-cells and #size-cells, as
> usual.

Ah, right, Thanks , will do

>
>> +  defined, in this order:
>> +  1: Watchdog control frame
>> +  2: Refresh frame.
>> +
>> +- interrupts: At least one interrupt must be defined that will be used as
>> +  the WS0 interrupt.  A WS1 interrupt definition can be provided, but is
>> +  optional.  The interrupts must be defined in this order:
>> +  1: WS0 interrupt
>> +  2: WS1 interrupt
>
> Why is WS1 optional?

According to the description of WS1 in SBSA 2.3 (5.2 Watchdog Operation) page 21
-----------------
The signal is fed to a higher agent as an interrupt or reset for it to
take executive action.
----------------

So WS1 maybe a interrupt.

In a real Hardware,  WS1 hooks to a  reset signal pin of BMC, if this
pin is triggered, BMC will do a real warm reset.
In this case, WS1 is a reset, Linux doesn't need to deal with that.

For now , I haven't found a hardware use WS1 as  interrupt.
In <ARM v8-A Foundation Platform User Guide> 3.2 Interrupt maps  Page 22
Table 3-3 Shared peripheral interrupt assignments
IRQ ID       SPI offset      Device
60               28              EL2 Generic Watchdog WS1

But I don't have further info about it.

Anyway,  because this signal could be interrupt or reset, Linux don't
need know this signal sometimes.
So I think it should be optional in binding info.

Do I miss something? Any suggestion ? Please correct me, thanks.

>
>> +Optional properties
>> +- timeout-sec: To use a timeout value that is different from the driver
>> +  default values, use this property.
>
> Either define a default value, or don't state anything about the
> behaviour when this is not present.

OK, thanks :-)

>
>>    If used, at least one timeout value
>> +  (in seconds) must be provided.  A second optional timeout value (in
>> +  seconds) may also be provided and will be used as the pre-timeout value,
>> +  if it is given.
>> +
>> +  There are two possible sources for driver default timeout values:
>> +  (1) the driver contains hard-coded default values, or
>> +  (2) module parameters can be given when the module is loaded
>> +
>> +  If timeout/pretimeout values are provided when the module loads, they
>> +  will take priority.  Second priority will be the timeout-sec from DTB,
>> +  and third the hard-coded driver values.
>
> The last two paragraphs should go. They describe Linux behaviour rather
> than the binding.

yes, maybe that should be in the watchdog documentation?

>
> Thanks,
> Mark.



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
