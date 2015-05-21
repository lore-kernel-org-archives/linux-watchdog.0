Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bl2on0116.outbound.protection.outlook.com ([65.55.169.116]:27029
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753915AbbEUUtW (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 21 May 2015 16:49:22 -0400
Message-ID: <555E4107.8010208@amd.com>
Date: Thu, 21 May 2015 15:33:11 -0500
From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
MIME-Version: 1.0
To: <fu.wei@linaro.org>, <linaro-acpi@lists.linaro.org>,
	<linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC: <tekkamanninja@gmail.com>, <graeme.gregory@linaro.org>,
	<al.stone@linaro.org>, <hanjun.guo@linaro.org>,
	<timur@codeaurora.org>, <ashwin.chaugule@linaro.org>,
	<arnd@arndb.de>, <linux@roeck-us.net>, <vgandhi@codeaurora.org>,
	<wim@iguana.be>, <jcm@redhat.com>, <leo.duran@amd.com>,
	<corbet@lwn.net>, <mark.rutland@arm.com>
Subject: Re: [PATCH v2 4/7] ARM64: add SBSA Generic Watchdog device node in
 amd-seattle-soc.dtsi
References: <=fu.wei@linaro.org>
 <1432197156-16947-1-git-send-email-fu.wei@linaro.org>
 <1432197156-16947-5-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1432197156-16947-5-git-send-email-fu.wei@linaro.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 5/21/15 03:32, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> This can be a example of adding SBSA Generic Watchdog device node
> into some dts files for the Soc which contains SBSA Generic Watchdog.
>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> ---
>   arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
> index 2874d92..95994eb 100644
> --- a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
> +++ b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
> @@ -84,6 +84,17 @@
>   			clock-names = "uartclk", "apb_pclk";
>   		};
>
> +		watchdog0: watchdog@e0bb0000 {
> +			compatible = "arm,sbsa-gwdt";
> +			reg = <0x0 0xe0bb0000 0 0x10000>,
> +				<0x0 0xe0bc0000 0 0x10000>;
> +			reg-names = "refresh",
> +				"control";
> +			interrupts = <0 337 4>;
> +			interrupt-names = "ws0";
> +			timeout-sec = <10 5>;
> +		};
> +
>   		spi0: ssp@e1020000 {
>   			status = "disabled";
>   			compatible = "arm,pl022", "arm,primecell";
>

Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Acked-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
