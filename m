Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53685 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862AbcF1FUc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 28 Jun 2016 01:20:32 -0400
Subject: Re: [PATCH 1/3] watchdog: qcom: update device tree bindings
To: Thomas Pedersen <twp@codeaurora.org>,
	linux-watchdog@vger.kernel.org
References: <1467070010-16965-1-git-send-email-twp@codeaurora.org>
 <1467070010-16965-2-git-send-email-twp@codeaurora.org>
Cc: Matthew McClintock <mmcclint@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <57720917.5000006@roeck-us.net>
Date: Mon, 27 Jun 2016 22:20:23 -0700
MIME-Version: 1.0
In-Reply-To: <1467070010-16965-2-git-send-email-twp@codeaurora.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/27/2016 04:26 PM, Thomas Pedersen wrote:
> From: Matthew McClintock <mmcclint@codeaurora.org>
>
> Update the compatible string to align with driver
>
> CC: linux-watchdog@vger.kernel.org
> Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
> ---
>   Documentation/devicetree/bindings/watchdog/qcom-wdt.txt | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt b/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
> index 4726924..60bb2f98 100644
> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
> @@ -4,9 +4,8 @@ Qualcomm Krait Processor Sub-system (KPSS) Watchdog
>   Required properties :
>   - compatible : shall contain only one of the following:
>
> -			"qcom,kpss-wdt-msm8960"
> -			"qcom,kpss-wdt-apq8064"
> -			"qcom,kpss-wdt-ipq8064"
> +			"qcom,kpss-timer"
> +			"qcom,scss-timer"
>
>   - reg : shall contain base register location and length
>   - clocks : shall contain the input clock
>

Rob's earlier feedback to the same patch you had submitted in March:

"Keep the SoC specific ones even if they are not used. The DTS should
have both strings."

Guenter

