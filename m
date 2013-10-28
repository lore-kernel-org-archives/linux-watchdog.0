Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:40967 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751857Ab3J1GwM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 28 Oct 2013 02:52:12 -0400
Date: Mon, 28 Oct 2013 06:52:01 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"wim@iguana.be" <wim@iguana.be>,
	"rob@landley.net" <rob@landley.net>,
	"linux-samsung-soc@vger.kernel.org"
	<linux-samsung-soc@vger.kernel.org>,
	"kgene.kim@samsung.com" <kgene.kim@samsung.com>
Subject: Re: [PATCH] Documentation/watchdog: Update node name in samsung-wdt
 example
Message-ID: <20131028065201.GB3065@kartoffel>
References: <1382941457-2826-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1382941457-2826-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Oct 28, 2013 at 06:24:17AM +0000, Sachin Kamat wrote:
> Update the name as per DT naming convention.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

> ---
>  .../devicetree/bindings/watchdog/samsung-wdt.txt   |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
> index 4c798e3..0642fb8 100644
> --- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
> @@ -17,7 +17,7 @@ Optional properties:
>  
>  Example:
>  
> -watchdog {
> +watchdog@101D0000 {
>  	compatible = "samsung,s3c2410-wdt";
>  	reg = <0x101D0000 0x100>, <0x10040408 0x4>, <0x1004040c 0x4>;
>  	interrupts = <0 42 0>;
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
