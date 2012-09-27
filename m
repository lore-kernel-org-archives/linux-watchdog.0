Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:55392 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025Ab2I0O7Y (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 27 Sep 2012 10:59:24 -0400
Received: by obbuo13 with SMTP id uo13so1843967obb.19
        for <linux-watchdog@vger.kernel.org>; Thu, 27 Sep 2012 07:59:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120927055636.GP17667@game.jcrosoft.org>
References: <1348568704-28304-1-git-send-email-fabio.porcedda@gmail.com>
 <1348568704-28304-2-git-send-email-fabio.porcedda@gmail.com> <20120927055636.GP17667@game.jcrosoft.org>
From: Fabio Porcedda <fabio.porcedda@gmail.com>
Date: Thu, 27 Sep 2012 16:59:02 +0200
Message-ID: <CAHkwnC_R4DMaRfjQHO=+K1DO62-iH70B2_QsipLD5D4xRznouw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] watchdog: at91sam9_wdt: add device tree support
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Andrew Victor <linux@maxim.org.za>,
	devicetree-discuss@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Sep 27, 2012 at 7:56 AM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> On 12:25 Tue 25 Sep     , Fabio Porcedda wrote:
>> Tested on an at91sam9260 board (evk-pro3)
>>
>> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
>> ---
>>  .../devicetree/bindings/watchdog/atmel-wdt.txt      | 19 +++++++++++++++++++
>>  drivers/watchdog/at91sam9_wdt.c                     | 21 +++++++++++++++++++++
>>  2 files changed, 40 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
>> new file mode 100644
>> index 0000000..5947929
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
>> @@ -0,0 +1,19 @@
>> +* Atmel Watchdog Timers
>> +
>> +** at91sam9-wdt
>> +
>> +Required properties:
>> +- compatible: must be "atmel,at91sam9260-wdt".
>> +- reg: physical base address of the controller and length of memory mapped
>> +  region.
>> +
>> +Optional properties:
>> +- heartbeat: contains the watchdog heartbeats in seconds.
> more I read this binding more it's seems wrong
>
> Today we do not use yet the watchdog framework which we will so we need to
> use the same binding as the watchdog framework

What is the binding of the heartbeat value in the watchdog framework?
I didn't found any binding of the heartbeat in other dt enabled drivers.

> So when we switch the DT will not change


Best regards
-- 
Fabio Porcedda
