Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36638 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbcFEUDl (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 5 Jun 2016 16:03:41 -0400
Date: Sun, 5 Jun 2016 16:03:32 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	x86@kernel.org, linux-next@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/4] gpio: Allow PC/104 devices on X86_64
Message-ID: <20160605200310.GA24295@sophia>
References: <cover.1464029828.git.vilhelm.gray@gmail.com>
 <d7320150373a0a04ba44b12c5c56d92370853316.1464029828.git.vilhelm.gray@gmail.com>
 <20160603205703.GC11253@amd>
 <20160603211244.GA6831@sophia>
 <20160604071408.GA22045@amd>
 <20160604111204.GA19180@sophia>
 <20160605192424.GB20086@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160605192424.GB20086@amd>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, Jun 05, 2016 at 09:24:24PM +0200, Pavel Machek wrote:
>On Sat 2016-06-04 07:12:21, William Breathitt Gray wrote:
>> I think I see the merit of a prompt for PC104 devices. I've encountered
>> a use case recently which I'm curious about in this scenario. Given the
>> compatibility with ISA, manufacturers may occasionally develop variants
>> of existing ISA devices by duplicating the firmware on a PC/104 form
>> factor.
>> 
>> I'm working on an IIO DAC driver for the Measurement Computing CIO-DAC
>> family (CIO-DAC08, CIO-DAC16, and PC104-DAC06); while not a GPIO driver,
>> I believe it can serve as a decent example. Interestingly, while the
>> CIO-DAC08 and CIO-DAC16 are true ISA devices, the PC104-DAC06 is a
>> PC/104 variant compatible with the others in the family. The IIO DAC
>> driver works just as well with the PC104-DAC06, as it does with the true
>> ISA devices in the family.
>> 
>> What would the Kconfig depends line look in this scenario? I imagine
>> simply "depends on PC104" would be inappropriate since there are a
>> number of true ISA devices supported by the driver, but "depends on
>> ISA_BUS_API || PC104" seems somewhat redundant when the PC104 Kconfig
>> option implies ISA_BUS_API. This situation isn't that much of an issue
>> overall, but I anticipate encountering it occassionally as I develop
>> future PC/104 drivers.
>
>ISA_BUS_API || PC104 sounds fine to me. But it seems probable to me
>that such devices will be connectable by PC104 and something else that
>is logically ISA but physically something else...?
>
>So in such case it would be logical to have driver depend on PC104 ||
>SOMETHING_ELSE. Of course, if some hardware is so common it is on many
>such buses, we can use ISA_BUS_API...

It does sound like it would be good to have a filter for drivers which
support only PC/104 device: a user would be able to conveniently filter
out PC/104 drivers, since most consumer systems do not feature a PC/104
bus even if they do possess an ISA bus. For drivers which support both
ISA and PC/104 devices, we could simply do as you suggest; but it's
likely that we will see fewer and fewer of these true ISA devices in the
future, which leaves the PC104 Kconfig option quite useful to implement.

William Breathitt Gray
