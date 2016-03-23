Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:56827 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbcCWWkb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 23 Mar 2016 18:40:31 -0400
Date: Wed, 23 Mar 2016 15:40:28 -0700
From: Stephen Boyd <sboyd@codeaurora.org>
To: Matthew McClintock <mmcclint@codeaurora.org>
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
	qca-upstream.external@qca.qualcomm.com,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	"open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/17] watchdog: qcom: add option for standalone watchdog
 not in timer block
Message-ID: <20160323224028.GC18567@codeaurora.org>
References: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org>
 <1458770712-10880-8-git-send-email-mmcclint@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1458770712-10880-8-git-send-email-mmcclint@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/23, Matthew McClintock wrote:
> @@ -202,13 +238,6 @@ static int qcom_wdt_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static const struct of_device_id qcom_wdt_of_table[] = {
> -	{ .compatible = "qcom,kpss-timer" },
> -	{ .compatible = "qcom,scss-timer" },
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(of, qcom_wdt_of_table);
> -

Leave this here and use of_device_get_match_data() in probe
instead.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
