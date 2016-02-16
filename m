Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43262 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbcBPPaH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 16 Feb 2016 10:30:07 -0500
Subject: Re: [PATCH v12 4/4] Watchdog: introduce ARM SBSA watchdog driver
To: fu.wei@linaro.org, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, wim@iguana.be, corbet@lwn.net,
	catalin.marinas@arm.com, will.deacon@arm.com,
	Suravee.Suthikulpanit@amd.com
References: <1455611785-2407-1-git-send-email-fu.wei@linaro.org>
 <1455611785-2407-5-git-send-email-fu.wei@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
	rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
	timur@codeaurora.org, dyoung@redhat.com, panand@redhat.com,
	graeme.gregory@linaro.org, al.stone@linaro.org,
	hanjun.guo@linaro.org, jcm@redhat.com, arnd@arndb.de,
	leo.duran@amd.com, sudeep.holla@arm.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56C34076.1020206@roeck-us.net>
Date: Tue, 16 Feb 2016 07:29:58 -0800
MIME-Version: 1.0
In-Reply-To: <1455611785-2407-5-git-send-email-fu.wei@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/16/2016 12:36 AM, fu.wei@linaro.org wrote:
> From: Fu Wei <fu.wei@linaro.org>
>
> According to Server Base System Architecture (SBSA) specification,
> the SBSA Generic Watchdog has two stage timeouts: the first signal (WS0)
> is for alerting the system by interrupt, the second one (WS1) is a real
> hardware reset.
> More details about the hardware specification of this device:
> ARM DEN0029B - Server Base System Architecture (SBSA)
>
> This driver can operate ARM SBSA Generic Watchdog as a single stage watchdog
> or a two stages watchdog, it's set up by the module parameter "action".
> In the single stage mode, when the timeout is reached, your system
> will be reset by WS1. The first signal (WS0) is ignored.
> In the two stages mode, when the timeout is reached, the first signal (WS0)
> will trigger panic. If the system is getting into trouble and cannot be reset
> by panic or restart properly by the kdump kernel(if supported), then the
> second stage (as long as the first stage) will be reached, system will be
> reset by WS1. This function can help administrator to backup the system
> context info by panic console output or kdump.
>
> This driver bases on linux kernel watchdog framework, so it can get
> timeout from module parameter and FDT at the driver init stage.
>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>
> Reviewed-by: Graeme Gregory <graeme.gregory@linaro.org>
> Tested-by: Pratyush Anand <panand@redhat.com>
> Acked-by: Timur Tabi <timur@codeaurora.org>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   drivers/watchdog/Kconfig     |  20 +++
>   drivers/watchdog/Makefile    |   1 +
>   drivers/watchdog/sbsa_gwdt.c | 403 +++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 424 insertions(+)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 0f6d851..ed9a5cb 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig

[ ... ]

> +
> +static int sbsa_gwdt_probe(struct platform_device *pdev)
> +{

[ ... ]

> +		if (!action)
> +			dev_warn(dev, "falling back to signle stage mode.\n");

Still:

s/signle/single/

[ ... ]

> +
> +MODULE_DESCRIPTION("SBSA Generic Watchdog Driver");
> +MODULE_AUTHOR("Fu Wei <fu.wei@linaro.org>");
> +MODULE_AUTHOR("Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>");
> +MODULE_AUTHOR("Al Stone <al.stone@linaro.org>");
> +MODULE_AUTHOR("Timur Tabi <timur@codeaurora.org>");
> +MODULE_LICENSE("GPL v2");
>
Do you need a MODULE_ALIAS ?

Guenter

