Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:50507 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723Ab3J3F10 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Oct 2013 01:27:26 -0400
Received: by mail-ob0-f176.google.com with SMTP id uy5so960467obc.7
        for <linux-watchdog@vger.kernel.org>; Tue, 29 Oct 2013 22:27:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1383109870-30297-1-git-send-email-sachin.kamat@linaro.org>
References: <1383109870-30297-1-git-send-email-sachin.kamat@linaro.org>
Date: Wed, 30 Oct 2013 10:57:25 +0530
Message-ID: <CAK9yfHyEB_jLqY7XXbVr+AsgRTCLsm1Xb2tHE5hEZS9kGOOGrQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Documentation/watchdog: Add binding example in samsung-wdt
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-watchdog@vger.kernel.org
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Sachin Kamat <sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 30 October 2013 10:41, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Added an example for reference.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  .../devicetree/bindings/watchdog/samsung-wdt.txt   |    9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
> index 2aa486c..7ddf461 100644
> --- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
> @@ -12,3 +12,12 @@ Required properties:
>
>  Optional properties:
>  - timeout-sec : contains the watchdog timeout in seconds.
> +
> +Example:
> +
> +watchdog@101D0000 {
> +       compatible = "samsung,s3c2410-wdt";
> +       reg = <0x101D0000 0x100>;
> +       interrupts = <0 42 0>;
> +       status = "disabled";
> + };
> --
> 1.7.9.5
>

Reports whitespace errors while applying (undetected by checkpatch).
Please ignore this version.
Have resent the fixed up one.

-- 
With warm regards,
Sachin
