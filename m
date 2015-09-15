Return-path: <dyoung@redhat.com>
Date: Tue, 15 Sep 2015 16:43:32 +0800
From: Dave Young <dyoung@redhat.com>
To: fu.wei@linaro.org
Cc: Suravee.Suthikulpanit@amd.com, hanjun.guo@linaro.org,
        linaro-acpi@lists.linaro.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, tekkamanninja@gmail.com,
        graeme.gregory@linaro.org, al.stone@linaro.org, arnd@arndb.de,
        linux@roeck-us.net, vgandhi@codeaurora.org, wim@iguana.be,
        jcm@redhat.com, leo.duran@amd.com, corbet@lwn.net,
        mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        rjw@rjwysocki.net, panand@redhat.com
Subject: Re: [PATCH v7 2/8] ARM64: add SBSA Generic Watchdog device node in
 foundation-v8.dts
Message-ID: <20150915084332.GC5767@localhost.localdomain>
References: <=fu.wei@linaro.org>
 <1440435683-7343-1-git-send-email-fu.wei@linaro.org>
 <1440435683-7343-3-git-send-email-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1440435683-7343-3-git-send-email-fu.wei@linaro.org>
List-ID: <linux-watchdog@vger.kernel.org>

On 08/25/15 at 01:01am, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
> 
> This can be a example of adding SBSA Generic Watchdog device node
> into some dts files for the Soc which contains SBSA Generic Watchdog.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> ---
>  arch/arm64/boot/dts/arm/foundation-v8.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/arm/foundation-v8.dts b/arch/arm64/boot/dts/arm/foundation-v8.dts
> index 4eac8dc..824431f 100644
> --- a/arch/arm64/boot/dts/arm/foundation-v8.dts
> +++ b/arch/arm64/boot/dts/arm/foundation-v8.dts
> @@ -237,4 +237,11 @@
>  			};
>  		};
>  	};
> +	watchdog@2a440000 {
> +		compatible = "arm,sbsa-gwdt";
> +		reg = <0x0 0x2a440000 0 0x1000>,
> +			<0x0 0x2a450000 0 0x1000>;
> +		interrupts = <0 27 4>;
> +		timeout-sec = <10 5>;

I assume 10 is timeout, 5 is pre timeout, but in the driver code the default
value is 30/10, I think the example dts[i] should use same default values as in code.

BTW, for kdump kernel Pratyush is working on kdump on wdt enabled system. 
Basiclly we expect one configure longer timeout, and kick it in shorter
period so we can get a chance to save vmcore. 10s sounds too short for the case..

> +	};
>  };
> -- 
> 2.4.3
> 
