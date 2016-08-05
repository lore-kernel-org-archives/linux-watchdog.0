Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34120 "EHLO
	mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759213AbcHED5o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 4 Aug 2016 23:57:44 -0400
MIME-Version: 1.0
In-Reply-To: <20160804172918.GA22921@rob-hp-laptop>
References: <1470198518-22286-1-git-send-email-shubhrajyoti.datta@xilinx.com> <20160804172918.GA22921@rob-hp-laptop>
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date: Fri, 5 Aug 2016 09:27:09 +0530
Message-ID: <CAKfKVtGHeVz6s0YgZ6__KN-R8iT1EmkUyMmHOXj3FfwJQyP20Q@mail.gmail.com>
Subject: Re: [PATCHv2] watchdog: xilinx: Add clock support
To: Rob Herring <robh@kernel.org>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	=?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
	Michal Simek <michal.simek@xilinx.com>, wim@iguana.be
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Aug 4, 2016 at 10:59 PM, Rob Herring <robh@kernel.org> wrote:
> On Wed, Aug 03, 2016 at 09:58:38AM +0530, Shubhrajyoti Datta wrote:
>> Add support for the clock. Currently we enable
>> at probe and relinquish at remove.
>>
>> Acked-by: Sören Brinkmann <soren.brinkmann@xilinx.com>
>> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>> ---
>> v2:
>> fix spaces and error path.
>>
>>  .../devicetree/bindings/watchdog/of-xilinx-wdt.txt |  3 +++
>>  drivers/watchdog/of_xilinx_wdt.c                   | 23 ++++++++++++++++++++--
>>  2 files changed, 24 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt b/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt
>> index 6d63782..b0a9fa3 100644
>> --- a/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt
>> +++ b/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt
>> @@ -5,6 +5,8 @@ Required properties:
>>  - compatible         : Should be "xlnx,xps-timebase-wdt-1.00.a" or
>>                         "xlnx,xps-timebase-wdt-1.01.a".
>>  - reg                        : Physical base address and size
>> +- clocks             : Input clock specifier. Refer to common clock
>> +                       bindings.
>
> You can't add new required properties. Doing so breaks compatibility
> with old DTs.
Will resend fixing the compatibility with old dts.

>
> Rob
