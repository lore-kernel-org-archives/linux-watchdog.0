Return-path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linaro-acpi@lists.linaro.org
Cc: Timur Tabi <timur@codeaurora.org>, devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org, corbet@lwn.net, jcm@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, wim@iguana.be, tekkamanninja@gmail.com, vgandhi@codeaurora.org, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [Linaro-acpi] [PATCH v2 6/7] Watchdog: introduce ARM SBSA watchdog driver
Date: Fri, 22 May 2015 22:13:43 +0200
Message-ID: <3381585.xxhO00lRy6@wuerfel>
In-Reply-To: <555F5728.5060209@codeaurora.org>
References: <=fu.wei@linaro.org> <10437443.BChumWu5Uk@wuerfel> <555F5728.5060209@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-watchdog@vger.kernel.org>

On Friday 22 May 2015 11:19:52 Timur Tabi wrote:
> On 05/22/2015 10:24 AM, Arnd Bergmann wrote:
> > That will break the ACPI case, but ACPI could use platform_data to
> > pass the clock rate into the driver, to make it independent of
> > low-level APIs.
> 
> The clock rate isn't the only problem.  You still need to current clock 
> timestamp, and that's ARM-specific.

Ah, I didn't realize that. I also just noticed that the two arch_timer
functions we call here are inline functions that just access control
registers.

If we want to enable COMPILE_TEST then, it would have to be something
like 

#ifdef CONFIG_ARM || CONFIG_ARM64
#include <asm/arch_timer.h>
#else
... /* stub functions */
#endif

That might still be helpful to get coverage from things like the public
coverity builds that always build x86 allmodconfig, but it's also a bit
ugly.

	Arnd
