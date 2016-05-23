Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33538 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbcEWRnW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 May 2016 13:43:22 -0400
Date: Mon, 23 May 2016 13:43:12 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	x86@kernel.org, linux-next@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/4] isa: Allow ISA-style drivers on modern systems
Message-ID: <20160523174312.GA1073@sophia>
References: <cover.1464014576.git.vilhelm.gray@gmail.com>
 <484d20f0a177f48a6d9a93520933b830d4412cca.1464014576.git.vilhelm.gray@gmail.com>
 <20160523172125.GA8264@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160523172125.GA8264@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, May 23, 2016 at 10:21:25AM -0700, Guenter Roeck wrote:
>On Mon, May 23, 2016 at 10:58:41AM -0400, William Breathitt Gray wrote:
>> +config ISA_BUS_API
>> +	def_bool ISA
>> +
>> +config ISA_BUS
>> +	bool "ISA-style bus support on modern systems" if (X86 && EXPERT)
>> +	default y
>
>Sure you want it enabled by default ?

Since the X86 ISA bus driver is more of an abstraction interface and
doesn't perform any hardware operations, I believe it's safe enough to
enable by default, thus allowing drivers dependent on it to show up for
selection in menuconfig.

>> +	select ISA_BUS_API
>> +	help
>> +	  Enables ISA-style drivers on modern systems. This is necessary to
>> +	  support PC/104 devices on X86_64 platforms.
>> +
>> +	  If unsure, say Y.
>> +
>>  # x86_64 have no ISA slots, but can have ISA-style DMA.
>>  config ISA_DMA_API
>>  	bool "ISA-style DMA support" if (X86_64 && EXPERT)
>> diff --git a/drivers/base/Makefile b/drivers/base/Makefile
>> index 6b2a84e..2609ba2 100644
>> --- a/drivers/base/Makefile
>> +++ b/drivers/base/Makefile
>> @@ -10,7 +10,7 @@ obj-$(CONFIG_DMA_CMA) += dma-contiguous.o
>>  obj-y			+= power/
>>  obj-$(CONFIG_HAS_DMA)	+= dma-mapping.o
>>  obj-$(CONFIG_HAVE_GENERIC_DMA_COHERENT) += dma-coherent.o
>> -obj-$(CONFIG_ISA)	+= isa.o
>> +obj-$(CONFIG_ISA_BUS_API)	+= isa.o
>
>Unless I am missing something, this is insufficient, and I am a bit surprised
>that it actually works. include/linux/isa.h declares isa_register_driver()
>and isa_unregister_driver() as dummies if CONFIG_ISA is not enabled.
>Doesn't this cause a compile error ? Confused.

You are correct: CONFIG_ISA in include/linux/isa.h should be
CONFIG_ISA_BUS_API. I'll add the change and submit version 2 of this
patchset after retesting.

William Breathitt Gray
