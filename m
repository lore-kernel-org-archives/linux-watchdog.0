Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35755 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161301AbcE3OMs (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 30 May 2016 10:12:48 -0400
Received: by mail-wm0-f42.google.com with SMTP id a136so88776827wme.0
        for <linux-watchdog@vger.kernel.org>; Mon, 30 May 2016 07:12:47 -0700 (PDT)
Subject: Re: [PATCH 0/3] watchdog: Add Amlogic Meson GXBB Watchdog Timer
 driver
To: Carlo Caione <carlo@caione.org>
References: <1464614948-28247-1-git-send-email-narmstrong@baylibre.com>
 <20160530134537.GA16188@mephisto>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-amlogic@lists.infradead.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From: Neil Armstrong <narmstrong@baylibre.com>
Message-ID: <574C4A76.10807@baylibre.com>
Date: Mon, 30 May 2016 16:13:10 +0200
MIME-Version: 1.0
In-Reply-To: <20160530134537.GA16188@mephisto>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/30/2016 03:45 PM, Carlo Caione wrote:
> On 30/05/16 15:29, Neil Armstrong wrote:
>> Adds support for the Amlogic Meson GXBB SoC Watchdog Timer.
>> It differs from the meson6/meson8b HW, so need for a separate driver.
>> The HW provides a divider capable of having a 1ms timebase thus simplifying
>> the counter update.
>> The restart call is not provided even if the HW is capable of triggering a
>> system reset immediately because of the PSCI firmare having such functionnality.
>> The watchdog is not expected to be running at boot time since there is a separate
>> system-level watchdog running from the SCPI co-processor, but this case would be
>> handle in a next driver update.
>>
>> Changes since RFC version at http://lkml.kernel.org/r/1464249112-13658-1-git-send-email-narmstrong@baylibre.com :
>> - Remove status callback, will re-introduce it later to managed the already-running use case
>> - Fix registers defines indentation
>> - Fix space between operators
>> - Make all callbacks static functions
>> - Fix bindings with missing clocks attribute
>> - Do not stop/start watchdog on a timeout setup
>> - Fix probe device configuration
>>
>> Neil Armstrong (3):
>>   watchdog: Add Meson GXBB Watchdog Driver
>>   dt-bindings: watchdog: Add Meson GXBB Watchdog bindings
>>   ARM64: dts: amlogic: meson-gxbb: Add watchdog node
> 
> I'm missing [PATCH 2/3]
> 
Sorry, fixed here :
