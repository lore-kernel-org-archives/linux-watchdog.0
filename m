Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:40473 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754827AbdL2EZt (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 28 Dec 2017 23:25:49 -0500
Date: Thu, 28 Dec 2017 23:25:41 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linus.walleij@linaro.org, mail@maciej.szmigiero.name,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Change ISA_BUS_API dependency to selection
Message-ID: <20171229042541.GA321@sophia>
References: <cover.1514475654.git.vilhelm.gray@gmail.com>
 <4339f82b-5f37-fb8d-2725-d45747608c2e@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4339f82b-5f37-fb8d-2725-d45747608c2e@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Dec 28, 2017 at 09:03:22AM -0800, Guenter Roeck wrote:
>On 12/28/2017 08:01 AM, William Breathitt Gray wrote:
>> The ISA_BUS_API Kconfig option enables the compilation of the ISA bus
>> driver. The ISA bus driver does not perform any hardware interaction,
>> and is instead just a thin layer of software abstraction to eliminate
>> boilerplate code common to ISA-style device drivers. Since ISA_BUS_API
>> has no dependencies and does not jeopardize the integrity of the system
>> when enabled, drivers should select it when the ISA bus driver
>> functionality is needed.
>> 
>> Originally, when the ISA_BUS_API Kconfig option was introduced, it
>> served a dual-purpose of masking drivers ISA-style devices not commonly
>> found for desktop systems, such as the PC/104 device drivers. This
>> secondary semantic was inappropriate for the ISA_BUS_API option, and
>> proper masking of these device drivers is now accomplished via dedicated
>> Kconfig options such as CONFIG_PC104.
>> 
>> Linus, please pickup this entire patchset through your GPIO subsystem
>> tree; a recursive dependency error is present if these patches are
>> cherry-picked (see https://lkml.org/lkml/2017/12/26/235), so they should
>> be merged together in the same tree.
>> 
>> Maciej, this patchset resolves the recursive dependency issue you
>> encountered, so now you should be able to submit your Winbond GPIO
>> driver with the ISA_BUS_API selection as desired.
>> 
>> William Breathitt Gray (3):
>>    iio: Change ISA_BUS_API dependency to selection
>>    watchdog: Change ISA_BUS_API dependency to selection
>>    gpio: Change ISA_BUS_API dependency to selection
>> 
>>   drivers/gpio/Kconfig        | 14 +++++++++-----
>>   drivers/iio/adc/Kconfig     |  3 ++-
>>   drivers/iio/counter/Kconfig |  3 ++-
>>   drivers/iio/dac/Kconfig     |  3 ++-
>>   drivers/watchdog/Kconfig    |  3 ++-
>>   5 files changed, 17 insertions(+), 9 deletions(-)
>> 
>But why keep "config ISA_BUS" ? Its only purpose is to select ISA_BUS_API.

I intend to have CONFIG_ISA_BUS now serve purely as a mask for true ISA
device drivers (e.g. CIO_DAC within this patchset). The legacy
CONFIG_ISA has a X86_32 dependency which prevents its use for X86_64
builds -- and unfortunately existing drivers depending on CONFIG_ISA
expect the X86_32 arch, thus making the task of decoupling that arch
dependency difficult. I'm hoping CONFIG_ISA_BUS can therefore supersede
the legacy CONFIG_ISA because an ISA bus can physically exist on a
non-X86_32 system.

However, there is no longer a need to select ISA_BUS_API, so that should
be removed, as well as the help text updated to match the changes. I'll
make these updates and submit a version 2 of this patchset some time
tomorrow then.

William Breathitt Gray

>
>Guenter
