Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:34252 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756543AbcCaNms (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 31 Mar 2016 09:42:48 -0400
Received: by mail-lb0-f175.google.com with SMTP id vo2so52835885lbb.1
        for <linux-watchdog@vger.kernel.org>; Thu, 31 Mar 2016 06:42:47 -0700 (PDT)
Subject: Re: [PATCH 2/4] arm64: dts: r8a7795: Add RWDT node
To: Wolfram Sang <wsa@the-dreams.de>, linux-watchdog@vger.kernel.org
References: <1459351725-14144-1-git-send-email-wsa@the-dreams.de>
 <1459351725-14144-3-git-send-email-wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <56FD2955.8030907@cogentembedded.com>
Date: Thu, 31 Mar 2016 16:42:45 +0300
MIME-Version: 1.0
In-Reply-To: <1459351725-14144-3-git-send-email-wsa@the-dreams.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello.

On 3/30/2016 6:28 PM, Wolfram Sang wrote:

> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> This patch adds the RWDT device node for r8a7795.
>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Changes since last RFC (only on renesas-soc-list):
>
> * rename RWDT to WDT since it can also be used for the now documented SWDT :)
> * use mainstream-style for the DT compatibles and update docs
>
>   arch/arm64/boot/dts/renesas/r8a7795.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> index bccd52e0462b92..dcdf914b67d4d9 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -167,6 +167,14 @@
>   					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>   		};
>
> +		wdt0: wdt@e6020000 {

    ePAPR has "watchdog", not "wdt" for the name.

[...]

MBR, Sergei

