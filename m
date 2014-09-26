Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:60615 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753441AbaIZDUF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 25 Sep 2014 23:20:05 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XXM4j-000O1W-Hb
	for linux-watchdog@vger.kernel.org; Fri, 26 Sep 2014 03:20:05 +0000
Message-ID: <5424DB33.1060700@roeck-us.net>
Date: Thu, 25 Sep 2014 20:19:15 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Josh Cartwright <joshc@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
CC: linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Kumar Gala <galak@codeaurora.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/3] watchdog: qcom: document device tree bindings
References: <cover.1411684967.git.joshc@codeaurora.org> <84605584a0634ad35a7829daf5a148107aaabc72.1411684967.git.joshc@codeaurora.org>
In-Reply-To: <84605584a0634ad35a7829daf5a148107aaabc72.1411684967.git.joshc@codeaurora.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/25/2014 03:51 PM, Josh Cartwright wrote:
> The Qualcomm Krait Processor Sub-system (KPSS) contains one or more
> instances of the WDT.  Provide documentation on how to describe these in
> the device tree.
>
> Signed-off-by: Josh Cartwright <joshc@codeaurora.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   .../devicetree/bindings/watchdog/qcom-wdt.txt      | 24 ++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
>
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt b/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
> new file mode 100644
> index 0000000..4726924
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
> @@ -0,0 +1,24 @@
> +Qualcomm Krait Processor Sub-system (KPSS) Watchdog
> +---------------------------------------------------
> +
> +Required properties :
> +- compatible : shall contain only one of the following:
> +
> +			"qcom,kpss-wdt-msm8960"
> +			"qcom,kpss-wdt-apq8064"
> +			"qcom,kpss-wdt-ipq8064"
> +
> +- reg : shall contain base register location and length
> +- clocks : shall contain the input clock
> +
> +Optional properties :
> +- timeout-sec : shall contain the default watchdog timeout in seconds,
> +                if unset, the default timeout is 30 seconds
> +
> +Example:
> +	watchdog@208a038 {
> +		compatible = "qcom,kpss-wdt-ipq8064";
> +		reg = <0x0208a038 0x40>;
> +		clocks = <&sleep_clk>;
> +		timeout-sec = <10>;
> +	};
>

