Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45014 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783AbcBPPbm (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 16 Feb 2016 10:31:42 -0500
Subject: Re: [PATCH v12 3/4] ARM64: add SBSA Generic Watchdog device node in
 amd-seattle-soc.dtsi
To: fu.wei@linaro.org, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, wim@iguana.be, corbet@lwn.net,
	catalin.marinas@arm.com, will.deacon@arm.com,
	Suravee.Suthikulpanit@amd.com
References: <1455611785-2407-1-git-send-email-fu.wei@linaro.org>
 <1455611785-2407-4-git-send-email-fu.wei@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
	rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
	timur@codeaurora.org, dyoung@redhat.com, panand@redhat.com,
	graeme.gregory@linaro.org, al.stone@linaro.org,
	hanjun.guo@linaro.org, jcm@redhat.com, arnd@arndb.de,
	leo.duran@amd.com, sudeep.holla@arm.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56C340D8.2050302@roeck-us.net>
Date: Tue, 16 Feb 2016 07:31:36 -0800
MIME-Version: 1.0
In-Reply-To: <1455611785-2407-4-git-send-email-fu.wei@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/16/2016 12:36 AM, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> This can be a example of adding SBSA Generic Watchdog device node
> into some dts files for the Soc which contains SBSA Generic Watchdog.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
> index 2874d92..0a8ca1d 100644
> --- a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
> +++ b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
> @@ -84,6 +84,14 @@
>   			clock-names = "uartclk", "apb_pclk";
>   		};
>
> +		watchdog0: watchdog@e0bb0000 {
> +			compatible = "arm,sbsa-gwdt";
> +			reg = <0x0 0xe0bc0000 0 0x1000>,
> +				<0x0 0xe0bb0000 0 0x1000>;
> +			interrupts = <0 337 4>;
> +			timeout-sec = <15>;
> +		};
> +
>   		spi0: ssp@e1020000 {
>   			status = "disabled";
>   			compatible = "arm,pl022", "arm,primecell";
>

