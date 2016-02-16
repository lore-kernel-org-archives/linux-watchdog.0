Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44105 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbcBPPar (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 16 Feb 2016 10:30:47 -0500
Subject: Re: [PATCH v12 1/4] Documentation: add sbsa-gwdt driver documentation
To: fu.wei@linaro.org, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, wim@iguana.be, corbet@lwn.net,
	catalin.marinas@arm.com, will.deacon@arm.com,
	Suravee.Suthikulpanit@amd.com
References: <1455611785-2407-1-git-send-email-fu.wei@linaro.org>
 <1455611785-2407-2-git-send-email-fu.wei@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
	rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
	timur@codeaurora.org, dyoung@redhat.com, panand@redhat.com,
	graeme.gregory@linaro.org, al.stone@linaro.org,
	hanjun.guo@linaro.org, jcm@redhat.com, arnd@arndb.de,
	leo.duran@amd.com, sudeep.holla@arm.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56C3409F.2020103@roeck-us.net>
Date: Tue, 16 Feb 2016 07:30:39 -0800
MIME-Version: 1.0
In-Reply-To: <1455611785-2407-2-git-send-email-fu.wei@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/16/2016 12:36 AM, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> The sbsa-gwdt.txt documentation in devicetree/bindings/watchdog is for
> introducing SBSA(Server Base System Architecture) Generic Watchdog
> device node info into FDT.
>
> Also add sbsa-gwdt introduction in watchdog-parameters.txt
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   .../devicetree/bindings/watchdog/sbsa-gwdt.txt     | 31 ++++++++++++++++++++++
>   Documentation/watchdog/watchdog-parameters.txt     |  7 +++++
>   2 files changed, 38 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt b/Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
> new file mode 100644
> index 0000000..6f2d5f9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/sbsa-gwdt.txt
> @@ -0,0 +1,31 @@
> +* SBSA (Server Base System Architecture) Generic Watchdog
> +
> +The SBSA Generic Watchdog Timer is used to force a reset of the system
> +after two stages of timeout have elapsed.  A detailed definition of the
> +watchdog timer can be found in the ARM document: ARM-DEN-0029 - Server
> +Base System Architecture (SBSA)
> +
> +Required properties:
> +- compatible: Should at least contain "arm,sbsa-gwdt".
> +
> +- reg: Each entry specifies the base physical address of a register frame
> +  and the length of that frame; currently, two frames must be defined,
> +  in this order:
> +  1: Watchdog control frame;
> +  2: Refresh frame.
> +
> +- interrupts: Should contain the Watchdog Signal 0 (WS0) SPI (Shared
> +  Peripheral Interrupt) number of SBSA Generic Watchdog.
> +
> +Optional properties
> +- timeout-sec: Watchdog timeout values (in seconds).
> +
> +Example for FVP Foundation Model v8:
> +
> +watchdog@2a440000 {
> +	compatible = "arm,sbsa-gwdt";
> +	reg = <0x0 0x2a440000 0 0x1000>,
> +	      <0x0 0x2a450000 0 0x1000>;
> +	interrupts = <0 27 4>;
> +	timeout-sec = <30>;
> +};
> diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
> index 9f9ec9f..ce7ae4e 100644
> --- a/Documentation/watchdog/watchdog-parameters.txt
> +++ b/Documentation/watchdog/watchdog-parameters.txt
> @@ -284,6 +284,13 @@ sbc_fitpc2_wdt:
>   margin: Watchdog margin in seconds (default 60s)
>   nowayout: Watchdog cannot be stopped once started
>   -------------------------------------------------
> +sbsa_gwdt:
> +timeout: Watchdog timeout in seconds. (default 10s)
> +action: Watchdog action at the first stage timeout,
> +	set to 0 to ignore, 1 to panic. (default=0)
> +nowayout: Watchdog cannot be stopped once started
> +	(default=kernel config parameter)
> +-------------------------------------------------
>   sc1200wdt:
>   isapnp: When set to 0 driver ISA PnP support will be disabled (default=1)
>   io: io port
>

