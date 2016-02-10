Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bl2on0090.outbound.protection.outlook.com ([65.55.169.90]:12752
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750750AbcBJU4p (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 10 Feb 2016 15:56:45 -0500
Subject: Re: [PATCH v11 3/4] ARM64: add SBSA Generic Watchdog device node in
 amd-seattle-soc.dtsi
To: <fu.wei@linaro.org>, <robh+dt@kernel.org>, <pawel.moll@arm.com>,
	<mark.rutland@arm.com>, <ijc+devicetree@hellion.org.uk>,
	<galak@codeaurora.org>, <wim@iguana.be>, <linux@roeck-us.net>,
	<corbet@lwn.net>, <catalin.marinas@arm.com>, <will.deacon@arm.com>
References: <1455037240-16192-1-git-send-email-fu.wei@linaro.org>
 <1455037240-16192-4-git-send-email-fu.wei@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linaro-acpi@lists.linaro.org>, <rruigrok@codeaurora.org>,
	<harba@codeaurora.org>, <cov@codeaurora.org>,
	<timur@codeaurora.org>, <dyoung@redhat.com>, <panand@redhat.com>,
	<graeme.gregory@linaro.org>, <al.stone@linaro.org>,
	<hanjun.guo@linaro.org>, <jcm@redhat.com>, <arnd@arndb.de>,
	<leo.duran@amd.com>, <sudeep.holla@arm.com>
From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Message-ID: <56BBA3F0.4010908@amd.com>
Date: Thu, 11 Feb 2016 03:56:16 +0700
MIME-Version: 1.0
In-Reply-To: <1455037240-16192-4-git-send-email-fu.wei@linaro.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Fu Wei,

On 2/10/16 00:00, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> This can be a example of adding SBSA Generic Watchdog device node
> into some dts files for the Soc which contains SBSA Generic Watchdog.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> ---
>   arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
> index 2874d92..67eb636 100644
> --- a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
> +++ b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
> @@ -84,6 +84,15 @@
>   			clock-names = "uartclk", "apb_pclk";
>   		};
>
> +		watchdog0: watchdog@e0bb0000 {
> +			compatible = "arm,sbsa-gwdt";
> +			reg = <0x0 0xe0bc0000 0 0x1000>,
> +				<0x0 0xe0bb0000 0 0x1000>;
> +			interrupts = <0 337 4>;
> +			timeout-sec = <15>;
> +			status = "disabled";

Could you please remove this status line? I do not think it is necessary 
for this one here anymore.

Thanks,
Suravee

> +		};
> +
>   		spi0: ssp@e1020000 {
>   			status = "disabled";
>   			compatible = "arm,pl022", "arm,primecell";
>
