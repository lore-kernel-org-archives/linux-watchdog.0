Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33617 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbbEBNzb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 2 May 2015 09:55:31 -0400
Received: by pacwv17 with SMTP id wv17so117825531pac.0
        for <linux-watchdog@vger.kernel.org>; Sat, 02 May 2015 06:55:31 -0700 (PDT)
Message-ID: <5544D749.7080802@linaro.org>
Date: Sat, 02 May 2015 21:55:21 +0800
From: Hanjun Guo <hanjun.guo@linaro.org>
MIME-Version: 1.0
To: Timur Tabi <timur@codeaurora.org>, linux-watchdog@vger.kernel.org,
	Ashwin Chaugule <ashwin.chaugule@linaro.org>,
	Vipul Gandhi <vgandhi@codeaurora.org>,
	Fu Wei <fu.wei@linaro.org>, Al Stone <al.stone@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: introduce the ARM64 SBSA watchdog driver
References: <1430336034-5275-1-git-send-email-timur@codeaurora.org>
In-Reply-To: <1430336034-5275-1-git-send-email-timur@codeaurora.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Timur,

I didn't review it in detail since I'm preparing the
ACPI GICv3 related patches and run out of time, but
I noticed a obvious error, comments inline.

On 2015年04月30日 03:33, Timur Tabi wrote:

> +static int __exit arm_sbsa_wdt_remove(struct platform_device *pdev)
> +{
> +	struct arm_sbsa_watchdog_data *data = platform_get_drvdata(pdev);
> +
> +	watchdog_unregister_device(&data->wdev);
> +
> +	return 0;
> +}
> +
> +static struct platform_device *arm_sbsa_wdt_pdev;
> +
> +static int __init arm_sbsa_wdt_parse_gtdt(struct acpi_subtable_header *header,
> +	const unsigned long end)
> +{
> +	struct acpi_gtdt_watchdog *wdg = (struct acpi_gtdt_watchdog *)header;

struct acpi_subtable_header can not be used here, because
acpi_subtable_header with the u8 structure length, but
for gtdt watchdog timer structure, its length is u16 defined.

Thanks
Hanjun
