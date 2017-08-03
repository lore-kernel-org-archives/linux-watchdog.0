Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:58440 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbdHCTci (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 3 Aug 2017 15:32:38 -0400
Subject: Re: [PATCH v5 0/8] Add board support for TS-4600
To: Shawn Guo <shawnguo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@savoirfairelinux.com, robh@kernel.org, linux@roeck-us.net,
        linus.walleij@linaro.org, fabio.estevam@nxp.com,
        mark@embeddedarm.com, kris@embeddedarm.com
References: <20170714203218.14409-1-sebastien.bourdelin@savoirfairelinux.com>
 <20170803012652.GB31819@dragon>
From: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
Message-ID: <d40e5ff1-2741-af5c-9dee-b24cd5780aae@savoirfairelinux.com>
Date: Thu, 3 Aug 2017 15:32:36 -0400
MIME-Version: 1.0
In-Reply-To: <20170803012652.GB31819@dragon>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-classic
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org



On 08/02/2017 09:26 PM, Shawn Guo wrote:
> On Fri, Jul 14, 2017 at 04:32:10PM -0400, Sebastien Bourdelin wrote:
>> This patch serie adds support for the TS-4600 boards rev A and B. These
>> boards, manufactured by Technologic Systems, are based on an i.MX28.
>>
>> This serie include the support for the watchdog which could be enable
>> at Linux boot time depending on the bootloader.
>>
>> The watchdog and few peripherals are implemented in a FPGA, and can
>> only be access using a custom GPIOs bit-banged bus which is called the
>> NBUS by Technologic Systems.
>> A driver for this bus is also included and used by the watchdog.
>>
>> Sebastien Bourdelin (8):
>>   of: documentation: add bindings documentation for TS-4600
>>   ARM: dts: TS-4600: add basic device tree
>>   dt-bindings: bus: Add documentation for the Technologic Systems NBUS
>>   bus: add driver for the Technologic Systems NBUS
>>   ARM: dts: TS-4600: add NBUS support
>>   dt-bindings: watchdog: add documentation for TS4600 watchdog
>>     controller
>>   watchdog: TS-4600: add driver for TS-4600 watchdog controller
>>   ARM: dts: TS-4600: add watchdog support
> 
> You are mixing changes on 3 subsystem in a single patch series.  It
> makes the merge process unnecessarily hard.  I suggest you split the
> series as following:
> 
>  - nbus dt-bindings and driver
>  - watchdog dt-bindings and driver
>  - ts-4600 board bindings and dts
> 
> You should get the first two into mainline through corresponding
> subsystem tree, and then submit the last one to me.  In that case, NBUS
> and watchdog dts changes do not have to be separate patches.
> 
> Shawn
> 

Hi Shawn,

Thanks i understand, however if it's ok, i would like to process in the
same time with the TS4600 board bindings and initial dts without the
part related to the nbus and watchdog.
There is no dependencies here and we can accellerate the process.

Regards,
Sebastien.
