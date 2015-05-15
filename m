Return-path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linaro-acpi@lists.linaro.org
Cc: fu.wei@linaro.org, Suravee.Suthikulpanit@amd.com, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net, jcm@redhat.com, timur@codeaurora.org, wim@iguana.be, tekkamanninja@gmail.com, vgandhi@codeaurora.org, linux@roeck-us.net
Subject: Re: [Linaro-acpi] [PATCH 0/6] Watchdog: introdouce ARM SBSA watchdog driver
Date: Fri, 15 May 2015 16:07:58 +0200
Message-ID: <179589472.1OI8rAN8jV@wuerfel>
In-Reply-To: <1431688090-2145-1-git-send-email-fu.wei@linaro.org>
References: <=fu.wei@linaro.org> <1431688090-2145-1-git-send-email-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-watchdog@vger.kernel.org>

On Friday 15 May 2015 19:08:04 fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> This patchset:
> 
>     (1)Introdouces Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
>     for FDT info of SBSA Generic Watchdog, and give two examples of
>     adding SBSA Generic Watchdog device node into the dts files:
>     foundation-v8.dts and amd-seattle-soc.dtsi
> 
>     (2)Introdouce "pretimeout" into the watchdog framework
> 
>     (3)Introdouces ARM SBSA watchdog driver
>         a.Use linux kernel watchdog framework
>         b.Work with FDT on ARM64
>         c.Use "pretimeout" in watchdog framework
>         d.In first timeout(WS0), do panic to save system context
>         e.Support geting timeout and pretimeout from
>           parameter and FDT at the driver init stage
> 
>     (4)Parse SBSA Generic Watchdog Structure in GTDT table of ACPI,
>        and create a platform device with that information
>        This platform device can be used by This Watchdog driver
> 
> This patchset has been tested with watchdog daemon
> (ACPI/FDT, module/build-in) on the following platforms:
>     (1)ARM Foundation v8 model
>     (2)AMD Seattle B0
> 
> 

I've had a few very minor comments to the individual patches, otherwise
looks good. I have not reviewed the ACPI part of the series, as I have
no knowledge of that.

	Arnd
