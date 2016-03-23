Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55728 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbcCWW0D (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 23 Mar 2016 18:26:03 -0400
Subject: Re: [PATCH 06/17] watchdog: qcom: update device tree bindings
To: Matthew McClintock <mmcclint@codeaurora.org>,
	andy.gross@linaro.org, linux-arm-msm@vger.kernel.org
References: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org>
 <1458770712-10880-7-git-send-email-mmcclint@codeaurora.org>
Cc: qca-upstream.external@qca.qualcomm.com,
	linux-watchdog@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
From: Stephen Boyd <sboyd@codeaurora.org>
Message-ID: <56F317F8.1070409@codeaurora.org>
Date: Wed, 23 Mar 2016 15:26:00 -0700
MIME-Version: 1.0
In-Reply-To: <1458770712-10880-7-git-send-email-mmcclint@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/23/2016 03:05 PM, Matthew McClintock wrote:
> Update the compatible string to align with driver
>
> CC: linux-watchdog@vger.kernel.org
> Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>

I had a patch similar to this before
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/325235.html


> ---
>  Documentation/devicetree/bindings/watchdog/qcom-wdt.txt | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt b/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
> index 4726924..60bb2f98 100644
> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
> @@ -4,9 +4,8 @@ Qualcomm Krait Processor Sub-system (KPSS) Watchdog
>  Required properties :
>  - compatible : shall contain only one of the following:
>  
> -			"qcom,kpss-wdt-msm8960"
> -			"qcom,kpss-wdt-apq8064"
> -			"qcom,kpss-wdt-ipq8064"
> +			"qcom,kpss-timer"
> +			"qcom,scss-timer"
>  
>  - reg : shall contain base register location and length
>  - clocks : shall contain the input clock

No example update?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

