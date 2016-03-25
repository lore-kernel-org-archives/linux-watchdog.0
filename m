Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46766 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752709AbcCYONU (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 25 Mar 2016 10:13:20 -0400
Date: Fri, 25 Mar 2016 09:13:13 -0500
From: Rob Herring <robh@kernel.org>
To: Matthew McClintock <mmcclint@codeaurora.org>
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
	qca-upstream.external@qca.qualcomm.com,
	linux-watchdog@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/17] watchdog: qcom: update device tree bindings
Message-ID: <20160325141313.GA11056@rob-hp-laptop>
References: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org>
 <1458770712-10880-7-git-send-email-mmcclint@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1458770712-10880-7-git-send-email-mmcclint@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Mar 23, 2016 at 05:05:01PM -0500, Matthew McClintock wrote:
> Update the compatible string to align with driver
> 
> CC: linux-watchdog@vger.kernel.org
> Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
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

Keep the SoC specific ones even if they are not used. The DTS should 
have both strings.

Rob
