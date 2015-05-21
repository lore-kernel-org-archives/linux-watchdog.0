Return-path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linaro-acpi@lists.linaro.org
Cc: fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net, jcm@redhat.com, timur@codeaurora.org, wim@iguana.be, tekkamanninja@gmail.com, vgandhi@codeaurora.org, linux@roeck-us.net
Subject: Re: [Linaro-acpi] [PATCH v2 0/7] Watchdog: introduce ARM SBSA watchdog driver
Date: Thu, 21 May 2015 10:46:59 +0200
Message-ID: <4405999.8GGyzVsbM7@wuerfel>
In-Reply-To: <1432197156-16947-1-git-send-email-fu.wei@linaro.org>
References: <=fu.wei@linaro.org> <1432197156-16947-1-git-send-email-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-watchdog@vger.kernel.org>

On Thursday 21 May 2015 16:32:29 fu.wei@linaro.org wrote:
> 
> This patchset:
> 
>     (1)Export "arch_timer_get_rate" in arm_arch_timer.c for the
>     other drivers, like SBSA watchdog driver
> 
>     (2)Introduce Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
>     for FDT info of SBSA Generic Watchdog, and give two examples of
>     adding SBSA Generic Watchdog device node into the dts files:
>     foundation-v8.dts and amd-seattle-soc.dtsi.
> 
>     (3)Introduce "pretimeout" into the watchdog framework, and update
>     Documentation/watchdog/watchdog-kernel-api.txt to introduce:
>         (1)the new elements in the watchdog_device and watchdog_ops struct;
>         (2)the new API "watchdog_init_timeouts".
> 
>     (4)Introduce ARM SBSA watchdog driver:
>         a.Use linux kernel watchdog framework;
>         b.Work with FDT on ARM64;
>         c.Use "pretimeout" in watchdog framework;
>         d.In first timeout(WS0), do panic to save system context;
>         e.Support geting timeout and pretimeout from parameter and FDT
>           at the driver init stage.

Looks all good to me, please add

Acked-by: Arnd Bergmann <arnd@arndb.de>

for patches 1-6.

>     (5)Parse SBSA Generic Watchdog Structure in GTDT table of ACPI,
>     and create a platform device with that information.
>     This platform device can be used by This Watchdog driver.

This needs to be reviewed by someone who understands ACPI.

	Arnd
