Return-Path: <michal.simek@xilinx.com>
Return-path: <michal.simek@xilinx.com>
Subject: Re: [PATCH 59/61] watchdog: simplify getting .drvdata
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	<linux-kernel@vger.kernel.org>
CC: <linux-renesas-soc@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
	<linux@roeck-us.net>, Michal Simek <michal.simek@xilinx.com>,
	<linux-watchdog@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-60-wsa+renesas@sang-engineering.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <c8156dd1-5081-7ab6-6dce-fde367190ae9@xilinx.com>
Date: Fri, 20 Apr 2018 09:23:00 +0200
MIME-Version: 1.0
In-Reply-To: <20180419140641.27926-60-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 19.4.2018 16:06, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Build tested only. buildbot is happy. Please apply individually.
> 
>  drivers/watchdog/cadence_wdt.c   | 6 ++----
>  drivers/watchdog/of_xilinx_wdt.c | 6 ++----

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
